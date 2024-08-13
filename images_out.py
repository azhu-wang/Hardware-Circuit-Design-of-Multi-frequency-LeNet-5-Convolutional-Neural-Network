import torch
import torch.nn as nn
import torchvision
import torchvision.transforms as transforms
import numpy as np
import matplotlib.pyplot as plt

# LeNet-5
class LeNet5(nn.Module):
    def __init__(self):
        super(LeNet5, self).__init__()
        self.conv1 = nn.Conv2d(1, 6, kernel_size=3, stride=1, padding=0)
        self.pool2 = nn.MaxPool2d(kernel_size=2, stride=2, padding=0)
        self.conv3 = nn.Conv2d(6, 12, kernel_size=3, stride=1, padding=0)
        self.pool4 = nn.MaxPool2d(kernel_size=2, stride=2, padding=0)
        self.conv5 = nn.Conv2d(12, 2, kernel_size=1, stride=1, padding=0)
        self.fc1 = nn.Linear(72, 10)


    def forward(self, x):
        x = torch.relu(self.conv1(x))
        x = self.pool2(x)
        x = torch.relu(self.conv3(x))
        x = self.pool4(x)
        x = torch.relu(self.conv5(x))
        x = x.view(x.size(0), -1)  
        x = self.fc1(x)
        return x

# 
def quantize_tensor_signed(tensor, bit_width):
    min_val = tensor.min().item()
    max_val = tensor.max().item()

    qmin = -2**(bit_width - 1)
    qmax = 2**(bit_width - 1) - 1
    scale = (max_val - min_val) / (qmax - qmin)
    zero_point = qmin - min_val / scale

    quantized_tensor = torch.round(tensor / scale + zero_point).to(torch.int)
    quantized_tensor.clamp_(qmin, qmax)

    if bit_width == 8:
        quantized_tensor = quantized_tensor.to(torch.int8)
    elif bit_width == 16:
        quantized_tensor = quantized_tensor.to(torch.int16)
    elif bit_width == 32:
        quantized_tensor = quantized_tensor.to(torch.int32)
    else:
        raise ValueError("Unsupported bit width")

    return quantized_tensor, scale, zero_point

# 
transform = transforms.Compose([
    transforms.Resize((30, 30)),
    transforms.ToTensor(),
    transforms.Normalize((0.5,), (0.5,))
])

testset = torchvision.datasets.MNIST(root='./data', train=False, download=True, transform=transform)
testloader = torch.utils.data.DataLoader(testset, batch_size=64, shuffle=False)

# 
dataiter = iter(testloader)
images, labels = next(dataiter)

# 打印
for i in range(5):
    img = images[i].numpy().squeeze()
    plt.imshow(img, cmap='gray')
    plt.title(f"Label: {labels[i].item()}")
    plt.show()

# 量化
quantized_images, scales, zero_points = [], [], []
for img in images[:10]:  #first 10
    q_img, scale, zero_point = quantize_tensor_signed(img, 8)
    quantized_images.append(q_img)
    scales.append(scale)
    zero_points.append(zero_point)

# 2補數存取
def to_hex(val):
    if val < 0:
        val = (1 << 8) + val
    return f"{val:02x}"

with open('quantized_images.coe', 'w') as f:
    f.write("memory_initialization_radix=16;\n")
    f.write("memory_initialization_vector=\n")
    for i, q_img in enumerate(quantized_images):
        for row in q_img.squeeze(0):
            hex_values = [to_hex(val.item()) for val in row]
            f.write(' '.join(hex_values) + '\n')
        f.write('\n')  # 空行
    print(f"前10張已保存到 quantized_images.coe 文件中")
