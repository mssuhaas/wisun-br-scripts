
# Installation Scripts

This repository contains a set of installation scripts to set up required dependencies and create the Wi-SUN Border Router. 

## Contents

- `install_dependencies.sh`: Checks and installs required packages.
- `install_mbedtls.sh`: Installs Mbed TLS.
- `install_cpc_daemon.sh`: Installs the CPC Daemon.
- `install_wisun_br_linux.sh`: Installs the Wi-SUN BR Linux implementation.
- `install_wisun_br_gui.sh`: Installs the Wi-SUN BR GUI.

## Installation Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/mssuhaas/wisun-br-scripts
   cd wisun-br-scripts
   ```

2. **Make all scripts executable:**
   ```bash
   chmod +x *.sh
   ```

3. **Run the installation scripts:**
   You can run each script with `sudo` to create the Wi-SUN Border Router.
   ```bash
   sudo ./install_dependencies.sh
   sudo ./install_mbedtls.sh
   sudo ./install_cpc_daemon.sh
   sudo ./install_wisun_br_linux.sh
   sudo ./install_wisun_br_gui.sh
   ```


## Notes

- It is recommended to run the scripts in a terminal with sudo privileges to ensure all packages can be installed successfully.
- If you encounter any issues, please check the console output for error messages.
