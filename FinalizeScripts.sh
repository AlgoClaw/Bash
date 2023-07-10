#!/bin/bash

# Install Dependencies
sudo apt install -y dos2unix mergerfs & wait

# Set Permissions
sudo dos2unix /Docker/Scripts/*.sh
sudo chmod +x /Docker/Scripts/*.sh

# Merge /Docker/Scripts/ with /usr/local/bin/
sudo mergerfs -o nonempty,allow_other,use_ino "/Docker/Scripts" "/usr/local/bin"

# Make Symbolic Links in /usr/local/bin
#sudo ln -sf /Docker/Scripts/* /usr/local/bin

# Delete Dead Symbolic Links in /usr/local/bin
#sudo find /usr/local/bin -xtype l -delete