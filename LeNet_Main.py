import torch
import torch.nn as nn
import torch.optim as optim
import torchvision
import torchvision.transforms as transforms
import numpy as np
from torch.quantization import QuantStub, DeQuantStub, prepare_qat, convert
import torch.nn.functional as F

# LeNet-5 
class LeNet5(nn.Module):
    def __init__(self):
        super(LeNet5, self).__init__()
        self.conv1 = nn.Conv2d(1, 6, kernel_size=3, stride=1, padding=0)  # 輸出尺寸：28x28x6
        self.pool2 = nn.MaxPool2d(kernel_size=2, stride=2, padding=0)  # 輸出尺寸：14x14x6
        self.conv3 = nn.Conv2d(6, 12, kernel_size=3, stride=1, padding=0)  # 輸出尺寸：12x12x16
        self.pool4 = nn.MaxPool2d(kernel_size=2, stride=2, padding=0)  # 輸出尺寸：6x6x12
        self.conv5 = nn.Conv2d(12, 2, kernel_size=1, stride=1, padding=0)  # 輸出尺寸：1x1x72
        self.fc1 = nn.Linear(72, 10)
  
    
    def forward(self, x):
        x = F.relu6(self.conv1(x))  # 輸出尺寸：24x24x6
        x = self.pool2(x)  # 輸出尺寸：12x12x6
        x = F.relu6(self.conv3(x))  # 輸出尺寸：8x8x16
        x = self.pool4(x)  # 輸出尺寸：4x4x16
        x = F.relu6(self.conv5(x))  # 輸出尺寸：1x1x120
        x = x.view(-1, 72 * 1 * 1)  # 展平為1維向量
        x = self.fc1(x)  # 全連接層1
        return x

# 加載數據集
transform = transforms.Compose([
    transforms.Resize((32, 32)),
    transforms.ToTensor(),
    transforms.Normalize((0.5,), (0.5,)),
])

trainset = torchvision.datasets.MNIST(root='./data', train=True, download=True, transform=transform)
trainloader = torch.utils.data.DataLoader(trainset, batch_size=64, shuffle=True)

testset = torchvision.datasets.MNIST(root='./data', train=False, download=True, transform=transform)
testloader = torch.utils.data.DataLoader(testset, batch_size=64, shuffle=False)

# 訓練模型
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
net = LeNet5().to(device)

criterion = nn.CrossEntropyLoss()
optimizer = optim.Adam(net.parameters(), lr=0.001)
# 測試模型
net.eval()
correct = 0
total = 0
with torch.no_grad():
    for data in testloader:
        images, labels = data
        images, labels = images.to(device), labels.to(device)
        outputs = net(images)
        _, predicted = torch.max(outputs.data, 1)
        total += labels.size(0)
        correct += (predicted == labels).sum().item()

print(f'Before Accuracy of the network on the 10000 test images: {100 * correct / total}%')


# 開始量化感知訓練
net.train()
for epoch in range(2):  # 訓練2個epoch
    running_loss = 0.0
    for i, data in enumerate(trainloader, 0):
        inputs, labels = data
        inputs, labels = inputs.to(device), labels.to(device)
        
        optimizer.zero_grad()
        
        outputs = net(inputs)
        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()
        
        running_loss += loss.item()
        if i % 100 == 99:  # 每100個mini-batch打印一次loss
            print(f"[{epoch + 1}, {i + 1}] loss: {running_loss / 100:.3f}")
            running_loss = 0.0

print('Finished Training')

# 測試模型
net.eval()
correct = 0
total = 0
with torch.no_grad():
    for data in testloader:
        images, labels = data
        images, labels = images.to(device), labels.to(device)
        outputs = net(images)
        _, predicted = torch.max(outputs.data, 1)
        total += labels.size(0)
        correct += (predicted == labels).sum().item()

print(f'Accuracy of the network on the 10000 test images: {100 * correct / total}%')

# 轉換為量化模型
convert(net.eval(), inplace=True)

#quantize
def quantize_tensor_signed(tensor, bit_width):
    min_val = tensor.min().item()
    max_val = tensor.max().item()

    # 缩放因子和零點
    qmin = -2**(bit_width - 1)
    qmax = 2**(bit_width - 1) - 1
    scale = (max_val - min_val) / (qmax - qmin)
    zero_point = qmin - min_val / scale

    # 量化
    quantized_tensor = torch.round(tensor / scale + zero_point).to(torch.int)
    quantized_tensor.clamp_(qmin, qmax)

    # 根據bit_width轉換
    if bit_width == 8:
        quantized_tensor = quantized_tensor.to(torch.int8)
    else:
        raise ValueError("Unsupported bit width")

    return quantized_tensor, scale, zero_point

def quantize_layer_signed(layer, bit_width):
    if hasattr(layer, 'weight') and hasattr(layer, 'bias'):
        weights, weight_scale, weight_zero_point = quantize_tensor_signed(layer.weight, bit_width)
        biases, bias_scale, bias_zero_point = quantize_tensor_signed(layer.bias, bit_width)
        return weights, biases, weight_scale, weight_zero_point, bias_scale, bias_zero_point
    else:
        raise AttributeError("The layer does not have weight and bias attributes")

# 保存量化權重
def save_weights(layer, filename, bit_width, scale, split_kernel):
    weights, biases, weight_scale, weight_zero_point, bias_scale, bias_zero_point = quantize_layer_signed(layer, bit_width)

    print(weights.shape)
    print(weight_scale)
    print(weight_zero_point)
    print("Weights")
    print(weights)
    print(bias_scale)
    print("biases")
    print(biases)
    print(bias_zero_point)

    weights_flat = weights.view(weights.shape[0], weights.shape[1:].numel()).cpu().detach().numpy()
    biases_flat = biases.cpu().detach().numpy()

    print(weights_flat.shape)

    file_idx = 1
    write_type = 'w'
    for i in range(weights_flat.shape[0]):
        if i in split_kernel:
            file_idx += 1
            write_type = 'w'

        with open(f"{filename}.coe", write_type) as f:
            if write_type == 'w':
                f.write(f"memory_initialization_radix=16;\n")
                f.write("memory_initialization_vector=\n")

            for j, val in enumerate(weights_flat[i]):
                f.write(f"{val & ((1 << bit_width) - 1):x},\n")  

            f.write(f"{biases_flat[i] & ((1 << bit_width) - 1):x},\n")  

        write_type = 'a'

# 存取
save_weights(net.conv1, 'kernel_c1', bit_width=8, scale=255, split_kernel = [])
save_weights(net.conv3, 'kernel_c3', bit_width=8, scale=255, split_kernel = [])
save_weights(net.conv5, 'kernel_c5', bit_width=8, scale=255, split_kernel = [])
save_weights(net.fc1, 'weights_fc', bit_width=8, scale=255, split_kernel = [])
print("權重已保存")