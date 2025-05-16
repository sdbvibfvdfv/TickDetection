# Overview

## 1. Data preprocess

## 2. Classification

##### Overview

This project performs image classification of tick species using a MobileNetV2 model. Training and evaluation are conducted on Google Colab with data stored in Google Drive.

##### Use Google Colab

Run the provided notebook in Google Colab for training and inference.

##### Mount Google Drive

To access your dataset and store trained models, mount your Google Drive with:

```python
from google.colab import drive
drive.mount('/content/drive')
```

##### Expected File Structure

```
classification/
└── data/
    ├── train/
    │   ├── 1/  # Amblyomma (blood-fed)
    │   ├── 2/  # Amblyomma (non-fed)
    │   ├── 3/  # Haemaphysalis
    │   └── 4/  # Ixodes
    └── val/
        ├── 1/  # Amblyomma (blood-fed)
        ├── 2/  # Amblyomma (non-fed)
        ├── 3/  # Haemaphysalis
        └── 4/  # Ixodes
```

Each class folder should contain images belonging to the respective tick category.

###### Trained Model Output

After training, the model will be saved as:

```
classification/
└── saved_model/
    └── model.pth
```

## 3. Application

#### Overview

This is a tick prediction app that are used flutter and django API. Flutter_project is flutter mobile app. Django_prediction_API is API are made of django for prediction. User can login and uplaod tick's image and that place. Flutter app sends django API that image. Django app return prediction result to flutter app. Flutter app show that result by palce that user resgistered on Google Map.

#### How to run flutter_project

1. Install Android Studio
   Android Studio URL > https://developer.android.com/studio/install?hl=ja

2. Install flutter
   flutter URL > https://docs.flutter.dev/get-started/install

3. Start emulator

4. Run app

