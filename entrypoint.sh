#!/bin/bash
export PATH=$PATH:/home/runner/.local/bin/

cd /home/runner
echo "entrypoint> Starting..."

if [ ! -d ".venv" ]; then
    python -m venv .venv
    . .venv/bin/activate
    pip install --upgrade pip
    # since we use venv, install pytorch again.
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
    pip install -r ./requirements.txt
else
    . .venv/bin/activate
fi

jupyter notebook --notebook-dir=. --ip=0.0.0.0 --port=8888 --no-browser
