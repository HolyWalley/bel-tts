Simple dockerized flask http interface around [bel-tts](https://huggingface.co/jhlfrfufyfn/bel-tts)

## Build

1. Clone repo
2. docker compose build

## Run

1. docker compose up
2. On the first run it will download and caches models and other data from huggingface
3. curl it
```bash
curl -X POST http://localhost:5001/synthesize \
                               -F "text=ҁбаЦка" \
                               --output output.wav
```
4. open output.wav
