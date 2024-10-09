#!/bin/bash

packages=(
    "libnl-3-dev"
    "libnl-route-3-dev"
    "libcap-dev"
    "libsystemd-dev"
    "libdbus-1-dev"
    "cargo"
    "cmake"
    "ninja-build"
    "pkg-config"
    "lrzsz"
)

echo "Updating package lists..."
sudo apt-get update -y

for package in "${packages[@]}"; do
    if dpkg -s "$package" >/dev/null 2>&1; then
        echo "$package is already installed."
    else
        echo "$package is not installed. Installing..."
        sudo apt-get install -y "$package"
    fi
done

echo "All packages are installed or up-to-date."
