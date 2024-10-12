#!/bin/bash

set -e

PREV_DIR=$(pwd)

error_exit() {
    echo "Error occurred at line $1 while executing $2. Exiting..."
    cd "$PREV_DIR"
    exit 1
}

trap 'error_exit $LINENO "$BASH_COMMAND"' ERR

if ! command -v node &> /dev/null; then
    echo "Node.js is not installed. Installing Node.js..."

    curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    echo "Node.js is already installed."
fi

sudo su << 'EOF'

. /etc/os-release

echo "deb http://deb.debian.org/debian ${VERSION_CODENAME}-backports main" > /etc/apt/sources.list.d/backports.list

sudo apt update

sudo apt install -t ${VERSION_CODENAME}-backports cockpit -y

cd /home/raspberrypi/Workswith_WiSUN
if [ ! -d "wisun-br-gui" ]; then
    git clone https://github.com/SiliconLabs/wisun-br-gui
fi

cd /home/raspberrypi/Workswith_WiSUN/wisun-br-gui

make
sudo make install

mkdir -p /usr/local/share/cockpit/wisun-br-gui
cp -r dist/* /usr/local/share/cockpit/wisun-br-gui

echo "wisun-br-gui installation complete."

exit
EOF

cd "$PREV_DIR"

echo "Script completed and returned to $PREV_DIR."