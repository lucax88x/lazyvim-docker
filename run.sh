#!/usr/bin/env bash

# Set error handling
set -euo pipefail

# Function to check if container exists and is running
container_exists() {
    docker ps -a --format '{{.Names}}' | grep -q "^lazyvim$"
}

container_running() {
    docker ps --format '{{.Names}}' | grep -q "^lazyvim$"
}

# Try to run the container first
if ! container_exists; then
    echo "Starting new LazyVim container..."
    docker run -it \
        -v "$(pwd):/repos" \
        -v lazyvim-data:/root/.config/nvim \
        -v lazyvim-cache:/root/.cache \
        -v lazyvim-loc-share:/root/.local/share \
        --name lazyvim \
        lazyvim
elif ! container_running; then
    echo "Container exists but is not running. Starting container..."
    docker start -i lazyvim
else
    echo "Container already running, executing nvim..."
    docker exec -it lazyvim nvim
fi
