#!/bin/bash

# Install Dependencies
sudo DEBIAN_FRONTEND=noninteractive apt install -y dos2unix
sudo pacman -Sy --noconfirm dos2unix --overwrite '*'

# Set Permissions
sudo dos2unix "${0%/*}"/*
sudo chmod +x "${0%/*}"/*.sh
