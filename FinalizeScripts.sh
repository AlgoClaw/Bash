#!/bin/bash

# Install Dependencies
sudo apt install -y dos2unix mergerfs & wait

# Set Permissions
sudo dos2unix /Scripts/*.sh & wait
sudo chmod +x /Scripts/*.sh & wait

# Make /usr/local/bin if it does not exist already
sudo mkdir -p /usr/local/bin & wait

# Virtually Merge /Docker/Scripts/ with /usr/local/bin/ (better than symbolic links)
sudo mergerfs -o nonempty,allow_other,use_ino "/Scripts" "/usr/local/bin" & wait
sudo umount "/usr/local/bin"

# Make Symbolic Links in /usr/local/bin
#sudo ln -sf /Scripts/* /usr/local/bin

# Delete Dead Symbolic Links in /usr/local/bin
#sudo find /usr/local/bin -xtype l -delete