#!/bin/bash
sudo apt update && \
sudo apt install -y git && \
sudo rm -f /Scripts_tmp && \
sudo git clone https://github.com/AlgoClaw/Bash /Scripts_tmp && \
sudo cp -RT /Scripts_tmp /Scripts && \
sudo rm -r /Scripts_tmp && \
sudo cp -RT /Scripts/fcns /Scripts && \
sudo rm -r /Scripts/fcns && \
sudo rm -r /Scripts/.git && \
sudo cp /Scripts/README.md /update_scripts.sh && \
sudo rm -r /Scripts/README.md  && \
sudo umount "/usr/local/bin"  & wait
sudo umount "/usr/local/bin"  & wait
sudo cp -RTn /usr/local/bin /Scripts && \
sudo rm /usr/local/bin/* & wait
sudo apt install -y dos2unix mergerfs & wait
sudo dos2unix /Scripts/*.sh & wait
sudo chmod +x /Scripts/*.sh & wait
sudo mergerfs -o nonempty,allow_other,use_ino "/Scripts" "/usr/local/bin"
