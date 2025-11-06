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

# --- Set Permissions ---

# 1. Convert line endings (run only on files)
find "$SCRIPT_DIR" -type f -exec sudo dos2unix {} +

# 2. Replace non-standard whitespace (run only on files)
# This finds any whitespace character that is NOT a space, tab,
# newline, or carriage return and replaces it with a standard space.
find "$SCRIPT_DIR" -type f -exec sudo perl -i -CS -pe 's/[^\x20\x0A\x0D\x09\S]/ /g' {} +

# 3. Make executable (recursively on all files and directories)
sudo chmod -R +x "$SCRIPT_DIR"
