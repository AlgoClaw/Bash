#!/bin/bash

sudo rm /Scripts/update_scripts_tmp.sh & wait

sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/update_scripts_tmp.sh --create-dirs -o /Scripts/update_scripts_tmp.sh & wait

sudo bash /Scripts/update_scripts_tmp.sh