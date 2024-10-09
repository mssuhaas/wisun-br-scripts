#!/bin/bash

set -e

MBEDTLS_VERSION="v3.0.0"

PREV_DIR=$(pwd)

error_exit() {
    echo "Error occurred at line $1 while executing $2. Exiting..."
    cd "$PREV_DIR"
    exit 1
}

trap 'error_exit $LINENO "$BASH_COMMAND"' ERR

cd ~ || exit

if [ ! -d "mbedtls" ]; then
    echo "Cloning Mbed TLS version $MBEDTLS_VERSION"
    git clone --branch=$MBEDTLS_VERSION https://github.com/ARMmbed/mbedtls.git
else
    echo "Mbed TLS directory already exists. Skipping clone."
fi

cd ~/mbedtls/ || exit

echo "Generating build files with CMake..."
cmake -G Ninja . || exit

echo "Building the project using Ninja..."
ninja || exit

echo "Installing Mbed TLS..."
sudo ninja install || exit

cd "$PREV_DIR" || exit

echo "Mbed TLS installation complete. Returned to $PREV_DIR."