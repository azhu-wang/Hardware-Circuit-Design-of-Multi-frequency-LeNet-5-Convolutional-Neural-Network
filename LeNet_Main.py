"""Train a 30x30 LeNet model whose fixed-point math matches the RTL.

Inputs and weights use signed Q0.7. Layer activations use power-of-two scales
8, 2, and 2, matching RTL shifts 11, 9, and 7. Biases are disabled so an
8-bit ROM entry is not incorrectly added to a wider accumulator.
"""

from __future__ import annotations

import argparse
import random
from pathlib import Path

import numpy as np
import torch
import torch.nn as nn
import torch.nn.functional as F
import torchvision
import torchvision.transforms as transforms


Q_SCALE = 128.0
Q_MIN = -128
Q_MAX = 127
ACT1_SCALE = 8.0
ACT2_SCALE = 2.0
ACT3_SCALE = 2.0


def fake_quant_q7(value: torch.Tensor) -> torch.Tensor:
    quantized = torch.clamp(torch.round(value * Q_SCALE), Q_MIN, Q_MAX) / Q_SCALE
    return value + (quantized - value).detach()


def fake_quant_relu(value: torch.Tensor, scale: float) -> torch.Tensor:
    value = F.relu(value)
    quantized = torch.clamp(torch.floor(value * scale + 0.5), 0, Q_MAX) / scale
    return value + (quantized - value).detach()


class FixedConv2d(nn.Conv2d):
    def forward(self, value: torch.Tensor) -> torch.Tensor:
        return F.conv2d(value, fake_quant_q7(self.weight), None, self.stride,
                        self.padding, self.dilation, self.groups)


class FixedLinear(nn.Linear):
    def forward(self, value: torch.Tensor) -> torch.Tensor:
        return F.linear(value, fake_quant_q7(self.weight), None)


class LeNet5(nn.Module):
    def __init__(self) -> None:
        super().__init__()
        self.conv1 = FixedConv2d(1, 6, kernel_size=3, bias=False)
        self.conv3 = FixedConv2d(6, 12, kernel_size=3, bias=False)
        self.conv5 = FixedConv2d(12, 2, kernel_size=1, bias=False)
        self.fc1 = FixedLinear(72, 10, bias=False)

    def forward(self, value: torch.Tensor) -> torch.Tensor:
        value = fake_quant_q7(value)
        value = fake_quant_relu(self.conv1(value), ACT1_SCALE)  # 30 -> 28
        value = F.max_pool2d(value, 2)                    # 28 -> 14
        value = fake_quant_relu(self.conv3(value), ACT2_SCALE)  # 14 -> 12
        value = F.max_pool2d(value, 2)                    # 12 -> 6
        value = fake_quant_relu(self.conv5(value), ACT3_SCALE)  # 6x6x2
        return self.fc1(torch.flatten(value, 1))


def q7_tensor(value: torch.Tensor) -> torch.Tensor:
    return torch.clamp(torch.round(value.detach().cpu() * Q_SCALE), Q_MIN, Q_MAX).to(torch.int8)


def write_coe(path: Path, values: list[int]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    encoded = [f"{value & 0xFF:02x}" for value in values]
    with path.open("w", encoding="ascii", newline="\n") as output:
        output.write("memory_initialization_radix=16;\n")
        output.write("memory_initialization_vector=\n")
        for index, item in enumerate(encoded):
            output.write(item)
            output.write(";\n" if index == len(encoded) - 1 else ",\n")


def export_layer(layer: nn.Module, path: Path) -> None:
    weights = q7_tensor(layer.weight).reshape(layer.weight.shape[0], -1)
    values: list[int] = []
    for output_channel in weights:
        values.extend(int(item) for item in output_channel.tolist())
        values.append(0)  # RTL-compatible zero bias entry
    write_coe(path, values)


def data_loaders(data_dir: Path, batch_size: int):
    transform = transforms.Compose([
        transforms.Resize((30, 30)),
        transforms.ToTensor(),
        transforms.Normalize((0.5,), (0.5,)),
    ])
    train_set = torchvision.datasets.MNIST(data_dir, train=True, download=True, transform=transform)
    test_set = torchvision.datasets.MNIST(data_dir, train=False, download=True, transform=transform)
    train_loader = torch.utils.data.DataLoader(train_set, batch_size=batch_size, shuffle=True)
    test_loader = torch.utils.data.DataLoader(test_set, batch_size=batch_size, shuffle=False)
    return train_loader, test_loader


def accuracy(model: nn.Module, loader, device: torch.device) -> float:
    model.eval()
    correct = 0
    total = 0
    with torch.no_grad():
        for images, labels in loader:
            predicted = model(images.to(device)).argmax(dim=1)
            correct += int((predicted == labels.to(device)).sum())
            total += labels.numel()
    return 100.0 * correct / total


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--epochs", type=int, default=2)
    parser.add_argument("--batch-size", type=int, default=128)
    parser.add_argument("--seed", type=int, default=7)
    parser.add_argument("--data-dir", type=Path, default=Path("data"))
    parser.add_argument("--output-dir", type=Path, default=Path("weights"))
    parser.add_argument("--resume", type=Path)
    args = parser.parse_args()

    random.seed(args.seed)
    np.random.seed(args.seed)
    torch.manual_seed(args.seed)
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    train_loader, test_loader = data_loaders(args.data_dir, args.batch_size)

    model = LeNet5().to(device)
    if args.resume:
        model.load_state_dict(torch.load(args.resume, map_location=device))
    optimizer = torch.optim.Adam(model.parameters(), lr=1e-3)
    for epoch in range(args.epochs):
        model.train()
        for images, labels in train_loader:
            optimizer.zero_grad(set_to_none=True)
            loss = F.cross_entropy(model(images.to(device)), labels.to(device))
            loss.backward()
            optimizer.step()
        print(f"epoch={epoch + 1} accuracy={accuracy(model, test_loader, device):.2f}%")

    args.output_dir.mkdir(parents=True, exist_ok=True)
    torch.save(model.state_dict(), args.output_dir / "lenet_q7.pt")
    export_layer(model.conv1, args.output_dir / "kernel_c1.coe")
    export_layer(model.conv3, args.output_dir / "kernel_c3.coe")
    export_layer(model.conv5, args.output_dir / "kernel_c5.coe")
    export_layer(model.fc1, args.output_dir / "weights_fc.coe")
    print(f"final_accuracy={accuracy(model, test_loader, device):.2f}%")
    print(f"weights={args.output_dir.resolve()}")


if __name__ == "__main__":
    main()
