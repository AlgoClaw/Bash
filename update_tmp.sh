#!/bin/bash

sudo rm -r /etc/apt/apt.conf.d/*esm* >/dev/null & wait
sudo dpkg --force-confdef --force-confold --configure -a & wait
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" ubuntu-advantage-tools & wait
sudo DEBIAN_FRONTEND=noninteractive apt update -y & wait
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y & wait
sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade --fix-missing -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" & wait
sudo DEBIAN_FRONTEND=noninteractive apt install -f -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" & wait
sudo DEBIAN_FRONTEND=noninteractive apt autoremove -y & wait
