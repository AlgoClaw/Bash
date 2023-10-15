#!/bin/bash

sudo rm /Scripts/smb_tmp.sh & wait

sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/smb_tmp.sh --create-dirs -o /Scripts/smb_tmp.sh & wait

sudo bash /Scripts/smb_tmp.sh
