#!/bin/bash

sudo rm /etc/apt/apt.conf.d/20apt-esm-hook.conf & wait
sudo dpkg --configure -a & wait
sudo DEBIAN_FRONTEND=noninteractive apt install -y ubuntu-advantage-tools & wait
sudo DEBIAN_FRONTEND=noninteractive apt update -y & wait
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y & wait
sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade --fix-missing -y & wait
sudo DEBIAN_FRONTEND=noninteractive apt install -f -y & wait
sudo DEBIAN_FRONTEND=noninteractive apt autoremove -y & wait
