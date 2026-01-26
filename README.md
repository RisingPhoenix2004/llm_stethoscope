
# 🩺 LLM STETHOSCOPE

**Deep Learning–Powered Lung Disease Prediction System**

---

## 📌 Overview

**LLM Stethoscope** is an end-to-end intelligent lung sound analysis platform that combines a **Flutter-based cross-platform mobile application** with a **Flask backend** powered by **Deep Learning and Transformer architectures**.
The system enables automated lung disease classification by analyzing respiratory sound recordings using advanced signal processing and neural network models.

The mobile client allows users to play bundled stethoscope audio or upload custom lung sound recordings, which are then sent to a local Flask server for inference using a trained **Keras (.h5) model**.

---

## ❓ Problem Statement

Respiratory diseases such as asthma, bronchitis, pneumonia, and COPD often require expert auscultation and interpretation of lung sounds, which can be subjective and inaccessible in low-resource settings. Traditional diagnosis relies heavily on clinician expertise, leading to delayed or inconsistent detection.

There is a need for an **automated, accurate, and scalable lung sound analysis system** that can assist healthcare professionals and enable early disease detection using modern machine learning techniques.

---

## 🎯 Objectives

* Develop predictive models for **lung disease classification** using:

  * Deep Learning (CNN)
  * Transformer-based architectures (Vision Transformer)
* Perform robust **audio signal preprocessing** and feature extraction
* Build a **cross-platform mobile client** for seamless interaction
* Enable real-time inference through a **Flask-based ML backend**
* Provide a scalable architecture suitable for clinical decision support

---

## 📊 Dataset

**Respiratory Sound Database**
📍 Source: Kaggle
🔗 [https://www.kaggle.com/datasets/vbookshelf/respiratory-sound-database](https://www.kaggle.com/datasets/vbookshelf/respiratory-sound-database)

The dataset contains labeled lung sound recordings collected from patients with various respiratory conditions, making it suitable for supervised learning and audio classification tasks.

---

## 🧠 Approach & Methodology

### 1. Data Preprocessing

* Noise filtering and normalization
* Audio segmentation using **windowing techniques**
* Application of **Hanning Window** to reduce spectral leakage

### 2. Feature Extraction

* **Fast Fourier Transform (FFT)**
* Spectral representations for model input

### 3. Model Architectures

* **Convolutional Neural Networks (CNN)**
  For learning spatial features from transformed audio signals
* **Vision Transformer (ViT)**
  For capturing long-range dependencies in spectrogram-like representations

### 4. Inference Pipeline

* Audio uploaded from Flutter app
* Flask API (`/upload`) processes audio
* Trained Keras model predicts lung disease label
* Prediction returned to the client application

---

## 🧩 Features

* **Cross-Platform Support**
  Runs seamlessly on:

  * Android
  * iOS
  * Web
  * Linux
  * macOS
  * Windows

* **Firebase Integration**

  * Authentication
  * Real-time database
  * Cloud storage

* **Customizable Analysis**

  * Configurable rules and parameters for LLM output interpretation

* **Asset Management**

  * Organized handling of audio files and data assets

---

## 📁 Project Structure

```plaintext
lib/
├── main.dart                  # Flutter app entry point
├── DLmodel.dart                # UI for audio playback & upload
├── login.dart                  # Login screen
├── register.dart               # Registration screen
├── home.dart                   # Home & navigation
├── firebase_options.dart       # Firebase configuration (auto-generated)
├── app.py                      # Flask backend with /upload endpoint
├── requirements.txt            # Backend Python dependencies
├── lung_disease_model.h5       # Trained Keras model
├── assets/
│   ├── Audio 1.wav
│   └── Audio 2.wav
pubspec.yaml                    # Flutter dependencies & assets
```

---

## 🚀 Getting Started

### Prerequisites

* Flutter SDK
* Dart (managed via Flutter)
* Python 3.x
* Firebase account & CLI (optional, if modifying backend)

---

### 🔧 Setup Instructions

#### 1. Clone the Repository

```bash
git clone https://github.com/RisingPhoenix2004/llm_stethoscope.git
cd llm_stethoscope
```

#### 2. Install Flutter Dependencies

```bash
flutter pub get
```

#### 3. Configure Firebase

* Ensure your Firebase project matches:

  * `firebase.json`
  * `.firebaserc`
  * Firebase rules files
* Download and place:

  * `google-services.json` (Android)
  * `GoogleService-Info.plist` (iOS)

#### 4. Run the Application

```bash
flutter run
```

---

## 🤝 Contributing

Contributions are welcome and encouraged!

1. Fork the repository
2. Create a new feature branch

   ```bash
   git checkout -b feature/your-feature
   ```
3. Commit your changes
4. Open a pull request for review

---

## ✨ Acknowledgements

- [Kaggle Respiratory Sound Database](https://www.kaggle.com/datasets/vbookshelf/respiratory-sound-database)
- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
* [TensorFlow](https://www.tensorflow.org/)
