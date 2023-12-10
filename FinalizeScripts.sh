#!/bin/bash

# Install Dependencies
sudo apt install -y dos2unix
sudo pacman -Sy --noconfirm dos2unix --overwrite '*'

# Set Permissions
sudo dos2unix "${0%/*}"/*.sh
sudo chmod +x "${0%/*}"/*.sh
