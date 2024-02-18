from flask import Flask, request, send_file, jsonify
from TTS.utils.synthesizer import Synthesizer
import soundfile as sf
import os
import io

app = Flask(__name__)

# Initialize the Synthesizer with the correct paths and settings
synthesizer = Synthesizer(
    tts_checkpoint='/app/model.pth',
    tts_config_path='/app/config.json',
    vocoder_checkpoint='/app/vocoder.pth',
    vocoder_config='/app/vocoder_config.json',
    use_cuda=False
)

@app.route('/synthesize', methods=['POST'])
def synthesize():
    text = request.form['text']

    # Synthesize the speech using the loaded model
    wavs = synthesizer.tts(text)
    out = io.BytesIO()
    synthesizer.save_wav(wavs, out)
    return send_file(out, mimetype="audio/wav")

if __name__ == '__main__':
    app.run(debug=True, port=5000)
