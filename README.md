Simple dockerized flask http interface around [bel-tts](https://huggingface.co/jhlfrfufyfn/bel-tts)

It additionally requires at least 2 files that are not in this repo:
- model.pth
- vocoder.pth

And if there were changes:
- vocoder_config.json
- config.json
- scale_stats.npy

I have not yet decided how to handle it better, but I don't really like the idea of storing those files in this repo.
# TODO: https://huggingface.co/docs/huggingface_hub/guides/download

## Build

1. Clone repo
2. To build copy required files from [bel-tts](https://huggingface.co/jhlfrfufyfn/bel-tts) to this directory
3. docker compose build

## Run

1. docker compose up
2. curl it
```bash
curl -X POST http://localhost:5000/synthesize \
                               -F "text=ҁбаЦка" \
                               --output output.wav
```
3. open output.wav
