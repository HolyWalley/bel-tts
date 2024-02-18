# Use Python 3.10.12 base image
FROM python:3.10.12

# Set the working directory in the container
WORKDIR /app

# Install system dependencies for Rust compiler
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential curl libssl-dev pkg-config libsndfile1 && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Set PATH for Rust
ENV PATH="/root/.cargo/bin:${PATH}"

# Upgrade pip and install TTS package
# Combining these RUN commands to reduce image layers
RUN pip install --upgrade pip && \
    pip install TTS

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY app.py .

EXPOSE 5000

# Command to run when starting the container
CMD ["gunicorn", "-w", "1", "-b", "0.0.0.0:5000", "app:app"]
