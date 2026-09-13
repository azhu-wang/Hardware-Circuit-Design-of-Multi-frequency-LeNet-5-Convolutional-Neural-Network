"""Export fixed Q0.7 MNIST images in the same 30x30 format used by RTL."""

from __future__ import annotations

import argparse
from pathlib import Path

import torch
import torchvision
import torchvision.transforms as transforms

from LeNet_Main import write_coe


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--count", type=int, default=10)
    parser.add_argument("--data-dir", type=Path, default=Path("data"))
    parser.add_argument("--output", type=Path, default=Path("weights/quantized_images.coe"))
    args = parser.parse_args()

    transform = transforms.Compose([
        transforms.Resize((30, 30)),
        transforms.ToTensor(),
        transforms.Normalize((0.5,), (0.5,)),
    ])
    dataset = torchvision.datasets.MNIST(args.data_dir, train=False, download=True, transform=transform)
    values: list[int] = []
    labels: list[int] = []
    for index in range(args.count):
        image, label = dataset[index]
        quantized = torch.clamp(torch.round(image * 128.0), -128, 127).to(torch.int8)
        values.extend(int(item) for item in quantized.flatten().tolist())
        labels.append(int(label))

    write_coe(args.output, values)
    args.output.with_suffix(".labels.txt").write_text(
        "\n".join(str(label) for label in labels) + "\n", encoding="ascii"
    )
    print(f"images={args.output.resolve()} labels={labels}")


if __name__ == "__main__":
    main()
