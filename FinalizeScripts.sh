#!/bin/bash
set -euo pipefail

# Single Instance Lock
exec 9>"/tmp/$(basename "$0").lock" && flock -n 9 || { echo "Script is already running. Exiting."; exit 1; }

# Install Dependencies
sudo bash fcn_install.sh "dos2unix"
sudo bash fcn_install.sh "perl"
#sudo pacman -Sy --noconfirm dos2unix perl --overwrite '*'

# Script Direcotry
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ) >/dev/null

# 1. Convert line endings (run only on files)
find "$SCRIPT_DIR" -type f -exec sudo dos2unix {} +

# 2. Replace Non-Breaking Spaces (NBSP) with a standard space
# This safely targets *only* the \x{00A0} character.
find "$SCRIPT_DIR" -type f -exec sudo perl -i -CS -pe 's/\x{00A0}/ /g' {} +

# 3. Make executable (recursively on all files and directories)
sudo chmod -R +x "$SCRIPT_DIR"
