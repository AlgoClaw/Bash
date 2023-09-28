#!/bin/bash

# Install Dependencies
sudo apt install -y dos2unix mergerfs & wait

# Set Permissions
sudo dos2unix /Scripts/*.sh
sudo chmod +x /Scripts/*.sh

# Virtually Merge /Docker/Scripts/ with /usr/local/bin/ (better than symbolic links)
sudo mergerfs -o nonempty,allow_other,use_ino "/Scripts" "/usr/local/bin"

# Make Symbolic Links in /usr/local/bin
#sudo ln -sf /Scripts/* /usr/local/bin

# Delete Dead Symbolic Links in /usr/local/bin
#sudo find /usr/local/bin -xtype l -delete
