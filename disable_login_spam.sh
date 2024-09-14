#!/bin/bash

# Hide System-Wide Messages Which Display for All Users
touch ~/.hushlogin 

# Disable RPi User-Specific Warnings
sudo rm /etc/profile.d/sshpwd.sh
sudo rm /etc/profile.d/wifi-check.sh
