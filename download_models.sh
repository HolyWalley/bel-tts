#!/bin/bash

# Install required Python package
pip install huggingface_hub

# Download the model using a Python one-liner
python -c "
import os
from huggingface_hub import snapshot_download
# Ensure the target directory exists
os.makedirs('/app/models', exist_ok=True)
# Download the model
model_path = snapshot_download(repo_id='jhlfrfufyfn/bel-tts', revision='3e6b609f1d0671330b475477184d49dea4b724a6', cache_dir='/app/models')
print(f'Model downloaded to {model_path}')
"
