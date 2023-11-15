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
sudo bash /Scripts/FinalizeScripts.sh && \
sudo cp /Scripts/README.md /Scripts/update_scripts.sh && \
sudo rm -r /Scripts/README.md
