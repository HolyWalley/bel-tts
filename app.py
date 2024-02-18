from flask import Flask, request, send_file
from TTS.utils.synthesizer import Synthesizer
import io

# Set the path to where the models are stored in the shared volume
model_path = "/app/models/models--jhlfrfufyfn--bel-tts/snapshots/3e6b609f1d0671330b475477184d49dea4b724a6"

# Initialize the Synthesizer with paths pointing to the models in the shared volume
synthesizer = Synthesizer(
    tts_checkpoint=f"{model_path}/model.pth",
    tts_config_path=f"{model_path}/config.json",
    vocoder_checkpoint=f"{model_path}/vocoder.pth",
    vocoder_config=f"{model_path}/vocoder_config.json",
    use_cuda=False
)

app = Flask(__name__)

@app.route('/synthesize', methods=['POST'])
def synthesize():
    data = request.get_json()
    text = data['text']

    # Synthesize the speech using the loaded model
    wavs = synthesizer.tts(text)
    out = io.BytesIO()
    synthesizer.save_wav(wavs, out)
    out.seek(0)  # Important: move the pointer to the beginning of the BytesIO object after writing
    return send_file(out, mimetype="audio/wav")

if __name__ == '__main__':
    app.run(debug=True, port=5000)
