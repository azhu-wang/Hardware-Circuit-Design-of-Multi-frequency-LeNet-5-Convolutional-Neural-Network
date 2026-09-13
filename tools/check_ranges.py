from pathlib import Path
import sys

import torch
import torchvision
import torchvision.transforms as transforms

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from LeNet_Main import (
    ACT1_SCALE,
    ACT2_SCALE,
    ACT3_SCALE,
    LeNet5,
    fake_quant_q7,
    fake_quant_relu,
)


model = LeNet5()
model.load_state_dict(torch.load(Path("weights/lenet_q7.pt"), map_location="cpu"))
model.eval()
dataset = torchvision.datasets.MNIST(
    "data",
    train=False,
    download=False,
    transform=transforms.Compose([
        transforms.Resize((30, 30)),
        transforms.ToTensor(),
        transforms.Normalize((0.5,), (0.5,)),
    ]),
)
images = torch.stack([dataset[index][0] for index in range(512)])
with torch.no_grad():
    x = fake_quant_q7(images)
    stages = []
    raw = torch.relu(model.conv1(x)); stages.append(("conv1", raw, ACT1_SCALE)); x = torch.max_pool2d(fake_quant_relu(raw, ACT1_SCALE), 2)
    raw = torch.relu(model.conv3(x)); stages.append(("conv3", raw, ACT2_SCALE)); x = torch.max_pool2d(fake_quant_relu(raw, ACT2_SCALE), 2)
    raw = torch.relu(model.conv5(x)); stages.append(("conv5", raw, ACT3_SCALE))
    for name, value, scale in stages:
        limit = 127.0 / scale
        clipped = 100.0 * float((value >= limit).float().mean())
        print(f"{name}: max={float(value.max()):.4f} representable={limit:.4f} clipped={clipped:.3f}%")
