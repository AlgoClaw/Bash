#!/bin/bash

sudo rm /Scripts/smb_tmp_steamos.sh & wait

sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/smb_tmp_steamos.sh --create-dirs -o /Scripts/smb_tmp_steamos.sh & wait

sudo bash /Scripts/smb_tmp_steamos.sh