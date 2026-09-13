"""Compare exported COE inference with the PyTorch fixed-point model."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

import numpy as np
import torch
import torchvision
import torchvision.transforms as transforms

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from LeNet_Main import LeNet5  # noqa: E402


def read_coe(path: Path) -> np.ndarray:
    text = path.read_text(encoding="ascii").split("memory_initialization_vector=", 1)[1]
    values = [int(token, 16) for token in re.findall(r"\b[0-9a-fA-F]{2}\b", text)]
    return np.asarray([value - 256 if value >= 128 else value for value in values], dtype=np.int32)


def unpack_layer(path: Path, outputs: int, inputs_per_output: int) -> np.ndarray:
    packed = read_coe(path).reshape(outputs, inputs_per_output + 1)
    if np.any(packed[:, -1] != 0):
        raise ValueError(f"{path} contains a non-zero bias")
    return packed[:, :-1]


def conv2d(value: np.ndarray, weight: np.ndarray) -> np.ndarray:
    kh, kw = weight.shape[-2:]
    windows = np.lib.stride_tricks.sliding_window_view(value, (kh, kw), axis=(1, 2))
    return np.einsum("chwkl,ockl->ohw", windows.astype(np.int64), weight.astype(np.int64))


def requant_relu(value: np.ndarray, shift: int) -> np.ndarray:
    positive = np.maximum(value, 0)
    return np.minimum((positive + (1 << (shift - 1))) >> shift, 127).astype(np.int32)


def max_pool(value: np.ndarray) -> np.ndarray:
    channels, height, width = value.shape
    return value.reshape(channels, height // 2, 2, width // 2, 2).max(axis=(2, 4))


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--count", type=int, default=1000)
    args = parser.parse_args()

    weight_dir = ROOT / "weights"
    w1 = unpack_layer(weight_dir / "kernel_c1.coe", 6, 9).reshape(6, 1, 3, 3)
    w2 = unpack_layer(weight_dir / "kernel_c3.coe", 12, 54).reshape(12, 6, 3, 3)
    w3 = unpack_layer(weight_dir / "kernel_c5.coe", 2, 12).reshape(2, 12, 1, 1)
    wf = unpack_layer(weight_dir / "weights_fc.coe", 10, 72)

    transform = transforms.Compose([
        transforms.Resize((30, 30)),
        transforms.ToTensor(),
        transforms.Normalize((0.5,), (0.5,)),
    ])
    dataset = torchvision.datasets.MNIST(ROOT / "data", train=False, download=False, transform=transform)
    model = LeNet5()
    model.load_state_dict(torch.load(weight_dir / "lenet_q7.pt", map_location="cpu"))
    model.eval()

    matched = 0
    correct = 0
    with torch.no_grad():
        for index in range(min(args.count, len(dataset))):
            image, label = dataset[index]
            q = torch.clamp(torch.round(image * 128.0), -128, 127).to(torch.int8).numpy().astype(np.int32)
            q = max_pool(requant_relu(conv2d(q, w1), 11))
            q = max_pool(requant_relu(conv2d(q, w2), 9))
            q = requant_relu(conv2d(q, w3), 7)
            logits = wf.astype(np.int64) @ q.reshape(72).astype(np.int64)
            rtl_prediction = int(np.argmax(logits))
            pytorch_prediction = int(model(image.unsqueeze(0)).argmax(dim=1))
            matched += rtl_prediction == pytorch_prediction
            correct += rtl_prediction == label

    count = min(args.count, len(dataset))
    print(f"samples={count}")
    print(f"rtl_vs_pytorch={100.0 * matched / count:.2f}%")
    print(f"integer_accuracy={100.0 * correct / count:.2f}%")
    if matched != count:
        raise SystemExit("exported integer model does not exactly match PyTorch")


if __name__ == "__main__":
    main()
