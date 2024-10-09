#!/bin/bash

set -e

PREV_DIR=$(pwd)

error_exit() {
    echo "Error occurred at line $1 while executing $2. Exiting..."
    cd "$PREV_DIR"
    exit 1
}

trap 'error_exit $LINENO "$BASH_COMMAND"' ERR

cd ~ || exit

if [ ! -d "wisun-br-linux" ]; then
    echo "Cloning wisun-br-linux..."
    git clone https://github.com/SiliconLabs/wisun-br-linux.git
else
    echo "wisun-br-linux directory already exists. Skipping clone."
fi

cd ~/wisun-br-linux/ || exit

echo "Generating build files with CMake..."
cmake -G Ninja . || exit

echo "Building the project using Ninja..."
ninja || exit

echo "Installing wisun-br-linux..."
sudo ninja install || exit

cd "$PREV_DIR" || exit

echo "wisun-br-linux installation complete. Returned to $PREV_DIR."