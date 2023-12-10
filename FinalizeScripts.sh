#!/bin/bash

# Install Dependencies
sudo apt install -y dos2unix & wait

# Set Permissions
sudo dos2unix "${0%/*}"/*.sh
sudo chmod +x "${0%/*}"/*.sh
