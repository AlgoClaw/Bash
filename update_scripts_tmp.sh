#!/bin/bash
sudo apt update && \
sudo rm -f /Scripts_tmp && \
sudo git clone https://github.com/AlgoClaw/Bash /Scripts_tmp && \
sudo rm -r /Scripts_tmp/.git && \
sudo cp -RT --update[=all] /Scripts_tmp/fcns /Scripts_tmp && \
sudo rm -r /Scripts_tmp/fcns && \
sudo cp -RT --update[=all] /Scripts_tmp /Scripts && \
sudo rm -r /Scripts_tmp && \
sudo umount "/usr/local/bin"  & wait
sudo cp -RTn /usr/local/bin /Scripts && \
sudo rm /usr/local/bin/* & wait
sudo apt install -y dos2unix mergerfs & wait
sudo dos2unix /Scripts/*.sh & wait
sudo chmod +x /Scripts/*.sh & wait
sudo mergerfs -o nonempty,allow_other,use_ino "/Scripts" "/usr/local/bin"