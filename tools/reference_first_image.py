"""Dependency-free integer reference for the first image stored in the ROM."""

from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]


def read_coe(name):
    text = (ROOT / "weights" / name).read_text(encoding="ascii").split(
        "memory_initialization_vector=", 1
    )[1]
    values = [int(token, 16) for token in re.findall(r"\b[0-9a-fA-F]{2}\b", text)]
    return [value - 256 if value >= 128 else value for value in values]


def unpack(name, outputs, inputs):
    values = read_coe(name)
    return [values[i * (inputs + 1):i * (inputs + 1) + inputs]
            for i in range(outputs)]


def conv(value, weights, kernel):
    channels = len(value)
    height = len(value[0])
    width = len(value[0][0])
    out = []
    for output_weights in weights:
        plane = []
        for y in range(height - kernel + 1):
            row = []
            for x in range(width - kernel + 1):
                total = 0
                for c in range(channels):
                    for ky in range(kernel):
                        for kx in range(kernel):
                            total += value[c][y + ky][x + kx] * \
                                     output_weights[(c * kernel + ky) * kernel + kx]
                row.append(total)
            plane.append(row)
        out.append(plane)
    return out


def requant(value, shift):
    rounding = 1 << (shift - 1)
    return [[[min((max(item, 0) + rounding) >> shift, 127) for item in row]
             for row in plane] for plane in value]


def pool(value):
    return [[[max(plane[y][x], plane[y][x + 1], plane[y + 1][x], plane[y + 1][x + 1])
              for x in range(0, len(plane[0]), 2)]
             for y in range(0, len(plane), 2)] for plane in value]


def flat_chw(value):
    return [item for plane in value for row in plane for item in row]


def report(name, value):
    items = flat_chw(value)
    print(f"{name}: values={len(items)} min={min(items)} max={max(items)} sum={sum(items)}")


def main():
    image = read_coe("quantized_images.coe")[:900]
    value = [[image[row * 30:(row + 1) * 30] for row in range(30)]]
    value = pool(requant(conv(value, unpack("kernel_c1.coe", 6, 9), 3), 11))
    report("pool1", value)
    value = pool(requant(conv(value, unpack("kernel_c3.coe", 12, 54), 3), 9))
    report("pool2", value)
    value = requant(conv(value, unpack("kernel_c5.coe", 2, 12), 1), 7)
    report("conv5", value)
    features = flat_chw(value)
    logits = [sum(item * weight for item, weight in zip(features, row))
              for row in unpack("weights_fc.coe", 10, 72)]
    print("logits", logits, "prediction", max(range(10), key=logits.__getitem__))


if __name__ == "__main__":
    main()
