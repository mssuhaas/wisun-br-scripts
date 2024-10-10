#!/bin/bash

set -e

PREV_DIR=$(pwd)

error_exit() {
    echo "Error occurred at line $1 while executing $2. Exiting..."
    cd "$PREV_DIR"
    exit 1
}

trap 'error_exit $LINENO "$BASH_COMMAND"' ERR

cd ~/Workswith_WiSUN || exit

if [ ! -d "cpc_daemon" ]; then
    echo "Cloning cpc_daemon..."
    git clone https://github.com/SiliconLabs/cpc_daemon.git
else
    echo "cpc_daemon directory already exists. Skipping clone."
fi

cd ~/Workswith_WiSUN/cpc_daemon || exit

echo "Generating build files with CMake..."
cmake -S . -B build -G Ninja || exit

echo "Building the project using Ninja..."
ninja -C build || exit

echo "Installing cpc_daemon..."
sudo ninja -C build install || exit

echo "Running sudo ldconfig to update shared library cache..."
sudo ldconfig || exit

cd "$PREV_DIR" || exit

echo "cpc_daemon installation complete. Returned to $PREV_DIR."