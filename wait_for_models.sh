#!/bin/bash

# Path where models are expected to be found
MODEL_PATH="/app/models/models--jhlfrfufyfn--bel-tts/snapshots/3e6b609f1d0671330b475477184d49dea4b724a6"

# Function to check if a file exists
file_exists() {
    [[ -f "$1" ]]
}

# Wait for the TTS model and vocoder to be downloaded
while ! file_exists "$MODEL_PATH/model.pth" || ! file_exists "$MODEL_PATH/vocoder.pth"; do
  echo "Waiting for TTS model and vocoder to be downloaded..."
  sleep 5  # Check every 5 seconds
done

cp "$MODEL_PATH/scale_stats.npy" /app/scale_stats.npy

echo "TTS model and vocoder downloaded. Starting the main service..."
# Now start the main Flask application
exec "$@"

