from flask import Flask, request, jsonify
import numpy as np
import librosa
from keras.models import load_model

app = Flask(__name__)

# Load the trained model
model_path = 'lung_disease_model.h5'
model = load_model(model_path)

def hanning(N):
    alpha = 0.54
    beta = 1 - alpha
    n = np.arange(N)
    return alpha - beta * np.cos(2 * np.pi * n / (N - 1))

def apply_noise_reduction(audio_data, sr):
    D = librosa.stft(audio_data, n_fft=2048, window=hanning(2048))
    magnitude = np.abs(D)
    phase = np.angle(D)
    noise_mean = np.mean(magnitude[:, :5], axis=1, keepdims=True)
    mask = magnitude > noise_mean
    magnitude_filtered = magnitude * mask
    D_filtered = magnitude_filtered * np.exp(1j * phase)
    y_filtered = librosa.istft(D_filtered)
    return y_filtered

def normalize_spectrogram(spectrogram, target_shape=(128, 128)):
    if spectrogram.shape[1] > target_shape[1]:
        spectrogram = spectrogram[:, :target_shape[1]]  # Trim
    elif spectrogram.shape[1] < target_shape[1]:
        spectrogram = np.pad(spectrogram, ((0, 0), (0, target_shape[1] - spectrogram.shape[1])), 'constant')  # Pad
    return spectrogram

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'audio' not in request.files:
        return jsonify({'error': 'No file provided'}), 400

    audio_file = request.files['audio']
    audio_data, _ = librosa.load(audio_file, sr=None)

    audio_data = apply_noise_reduction(audio_data, _)
    S = librosa.feature.melspectrogram(y=audio_data, sr=_, n_fft=2048, hop_length=512)
    S_dB = librosa.power_to_db(S, ref=np.max)
    S_dB = normalize_spectrogram(S_dB)

    S_dB = S_dB[np.newaxis, ..., np.newaxis]

    predictions = model.predict(S_dB)
    predicted_class_index = np.argmax(predictions, axis=1)

    class_labels = ['Normal', 'Asthma', 'Heart Failure', 'COPD', 'Lung Fibrosis', 'Pneumonia', 'Bronchial', 'Pleural Effusion', 'Bron', 'Crep']
    predicted_label = class_labels[predicted_class_index[0]]

    return jsonify({'predicted_class': predicted_label})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=1000)
