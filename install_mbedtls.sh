#!/bin/bash

set -e

PREV_DIR=$(pwd)

error_exit() {
    echo "Error occurred at line $1 while executing $2. Exiting..."
    cd "$PREV_DIR"
    exit 1
}

trap 'error_exit $LINENO "$BASH_COMMAND"' ERR

cd $HOME/Workswith_WiSUN || exit

if [ ! -d "mbedtls" ]; then
    echo "Cloning Mbed TLS version v3.0.0"
    git clone --branch=v3.0.0 https://github.com/ARMmbed/mbedtls.git
else
    echo "Mbed TLS directory already exists. Skipping clone."
fi

cd $HOME/Workswith_WiSUN/mbedtls/ || exit

echo "Generating build files with CMake..."
cmake -G Ninja . || exit

echo "Building the project using Ninja..."
ninja || exit

echo "Installing Mbed TLS..."
sudo ninja install || exit

cd "$PREV_DIR" || exit

echo "Mbed TLS installation complete. Returned to $PREV_DIR."