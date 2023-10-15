#!/bin/bash

sudo rm /Scripts/update_tmp.sh & wait

sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/update_tmp.sh --create-dirs -o /Scripts/update_tmp.sh & wait

sudo bash /Scripts/update_tmp.sh
