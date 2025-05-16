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

Tick Prediction App
This project consists of a Flutter mobile application and a Django-based prediction API.

Flutter_project: The Flutter mobile app that users interact with.

Django_prediction_API: A Django API that handles image-based tick prediction.

Features
Users can log in and upload an image of a tick along with the location where it was found.

The Flutter app sends the image and to the Django API.

The Django API processes the image and returns the predicted tick type.

The Flutter app then displays the prediction result on a Google Map, pinned at the user-specified location.

Users can ask Gemini from the Flutter app and also ask about that tick by tapping the pin on the map.

This system allows users to visualize where different types of ticks have been found, helping in awareness and prevention efforts.

#### flutter_project

##### Technology used 

firestore - to save URL of uploaded images and the user who uploaded them, date, time, latitude and longitude.  
firestorage - to save uploaded image.  
firebase authentication - to login, signup and save users' password and email.  
Gemini - to enable users to get information about tick.  
Google Map Flutter - to visualize the type and location of ticks on a map from the stored information.  
Geocoding API - to convert address or place name to latitude and longitude.  

##### How to run
1. Install Android Studio.  
   Android Studio URL > https://developer.android.com/studio/install?hl=ja

2. Install flutter.  
   flutter URL > https://docs.flutter.dev/get-started/install

3. Start emulator. (Click on the area circled in blue.)  
![Image](https://github.com/user-attachments/assets/84cd2f8f-9356-42eb-bbf6-c908dda4623f)
![Image](https://github.com/user-attachments/assets/5364b245-c12b-496e-9c5d-c21458c26960)

5. Run app. (Click on the area circled in blue.)  
![Image](https://github.com/user-attachments/assets/a3272358-6899-43d8-a6ba-33ef68619636)

#### django_prediction_API

##### Technology used

torch - to define and load model.  

##### How to run
1. Install VSCode.
   VScode URL > https://code.visualstudio.com/Download

2. Move to django_prediction_API and install django, djangorestframework, pillow, torch and torchvision. (Run the following code in the terminal.)  
   ```
   cd django_prediction_API
   pip install django djangorestframework pillow torch torchvision
   ```

3. Run server. (Run the following code in the terminal.)  
   ```
   python manage.py runserver
   ```
