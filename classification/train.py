import torch
import torch.nn as nn
import torchvision.transforms as transforms
from torchvision import datasets, models
from torch.utils.data import DataLoader
import os

# === 設定 ===
DATA_DIR = "/content/drive/MyDrive/classification/data"
BATCH_SIZE = 32
IMG_SIZE = 224
NUM_CLASSES = len(os.listdir(os.path.join(DATA_DIR, "train")))
DEVICE = torch.device("cuda" if torch.cuda.is_available() else "cpu")

# === データ前処理 ===
transform = transforms.Compose([
    transforms.Resize((IMG_SIZE, IMG_SIZE)),
    transforms.ToTensor(),
])

train_dataset = datasets.ImageFolder(os.path.join(DATA_DIR, "train"), transform=transform)
train_loader = DataLoader(train_dataset, batch_size=BATCH_SIZE, shuffle=True)

# === モデル作成（MobileNetV2） ===
def get_model():
    model = models.mobilenet_v2(weights="IMAGENET1K_V1")
    model.classifier[1] = nn.Linear(model.classifier[1].in_features, NUM_CLASSES)
    return model.to(DEVICE)

# === 学習関数 ===
def train_model(model, train_loader, epochs=3):
    criterion = nn.CrossEntropyLoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=1e-4)
    model.train()
    for epoch in range(epochs):
        for inputs, labels in train_loader:
            inputs, labels = inputs.to(DEVICE), labels.to(DEVICE)
            optimizer.zero_grad()
            outputs = model(inputs)
            loss = criterion(outputs, labels)
            loss.backward()
            optimizer.step()
    return model, optimizer  # 学習後に返す

# === 実行 ===
model = get_model()
model, optimizer = train_model(model, train_loader)

# === 学習済みモデルの保存 ===
torch.save(model.state_dict(), "/content/drive/MyDrive/classification/saved_model/model.pth")

# === （必要に応じて学習状態も保存する場合）===
torch.save({
    'model_state_dict': model.state_dict(),
    'optimizer_state_dict': optimizer.state_dict(),
    'epoch': 3
}, "/content/drive/MyDrive/classification/saved_model/model_checkpoint.pth")
