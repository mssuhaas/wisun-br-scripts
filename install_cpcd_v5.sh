#!/bin/bash

set -e

PREV_DIR=$(pwd)

error_exit() {
    echo "Error occurred at line $1 while executing $2. Exiting..."
    cd "$PREV_DIR"
    exit 1
}

trap 'error_exit $LINENO "$BASH_COMMAND"' ERR

cd /home/raspberrypi/Workswith_WiSUN || exit

if [ -d "/usr/local/lib/arm-linux-gnueabihf/" ]; then
    echo "Removing previous libcpc installs..."
    sudo rm -rf /usr/local/lib/arm-linux-gnueabihf/*
else
    echo "/usr/local/lib/arm-linux-gnueabihf/ does not exist. Skipping removal."
fi

if [ ! -d "cpc_daemon_stash" ]; then
    echo "Cloning the CPC Daemon repository..."
    git clone https://github.com/SiliconLabs/cpc_daemon.git cpc_daemon_stash
else
    echo "cpc_daemon_stash directory already exists. Skipping clone."
fi

cd /home/raspberrypi/Workswith_WiSUN/cpc_daemon_stash/ || exit

if [ -d "build" ]; then
    echo "Removing existing build directory..."
    rm -rf build/
fi

echo "Creating build directory..."
mkdir build
cd build/ || exit

echo "Running cmake..."
cmake ../ || exit

echo "Compiling CPC Daemon..."
make || exit

echo "Installing CPC Daemon..."
sudo make install || exit

echo "Running ldconfig..."
sudo ldconfig || exit

CPC_VERSION=$(grep 'set(CPC_PROTOCOL_VERSION' /home/raspberrypi/Workswith_WiSUN/cpc_daemon_stash/CMakeLists.txt | awk -F\" '{print $2}')
echo "CPC Protocol Version: $CPC_VERSION"

echo "Verifying libcpc installation..."
ls -al /usr/local/lib/arm-linux-gnueabihf/ || exit

echo "Checking installed CPC Daemon version..."
cpcd --version || exit

cd "$PREV_DIR" || exit

echo "CPC Daemon with Protocol v5 installation complete. Returned to $PREV_DIR."