#!/bin/bash
#
sudo rm -r /Scripts_tmp > /dev/null 2>&1
sudo git clone https://github.com/AlgoClaw/Bash /Scripts_tmp > /dev/null 2>&1
sudo rm -r /Scripts_tmp/.git
sudo rm -f /Scripts_tmp/README.md
sudo cp -RTf /Scripts_tmp/fcns /Scripts_tmp
sudo rm -r /Scripts_tmp/fcns
sudo cp -RTf /Scripts_tmp /Scripts
sudo rm -r /Scripts_tmp
#
sudo apt install -y dos2unix > /dev/null 2>&1
sudo dos2unix /Scripts/*.sh > /dev/null 2>&1
sudo chmod +x /Scripts/*.sh > /dev/null 2>&1
#
sudo umount -A "/usr/local/bin" > /dev/null 2>&1
sudo cp -RTn /usr/local/bin /Scripts
sudo rm /usr/local/bin/* > /dev/null 2>&1
#
sudo apt install -y mergerfs > /dev/null 2>&1
sudo mergerfs -o nonempty,allow_other,use_ino "/Scripts" "/usr/local/bin"
