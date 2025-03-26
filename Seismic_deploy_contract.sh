#!/bin/bash
echo "Script deploy Counter Seismic contract on devnet"

set -e  # Exit immediately if a command exits with a non-zero status
set -o pipefail  # Catch errors in pipelines
set -u  # Treat unset variables as errors

cd
# Update and install required dependencies
echo "Updating system and installing dependencies..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git build-essential jq

# Install Rust
if ! command -v rustc &> /dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
else
    echo "Rust is already installed. Skipping installation."
fi

rustc --version

sleep 2
# Install sfoundryup
echo "Installing sfoundryup..."
curl -L -H "Accept: application/vnd.github.v3.raw" \
     "https://api.github.com/repos/SeismicSystems/seismic-foundry/contents/sfoundryup/install?ref=seismic" | bash

sleep 2

# Run sfoundryup
echo "Running sfoundryup..."
sfoundryup

# Clone try-devnet repository with submodules
if [ ! -d "try-devnet" ]; then
    echo "Cloning try-devnet repository..."
    git clone --recurse-submodules https://github.com/SeismicSystems/try-devnet.git
else
    echo "try-devnet repository already exists. Pulling latest changes..."
    cd try-devnet
    git pull
    git submodule update --init --recursive
    cd ..
fi

# Navigate to contract directory and deploy
cd try-devnet/packages/contract/ || exit
echo "Deploying contract..."
bash script/deploy.sh

curl -fsSL https://bun.sh/install | bash
cd try-devnet/packages/cli/
bun install

### Interact with an encrypted contract
bash script/transact.sh
