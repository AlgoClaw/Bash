#!/bin/bash

sudo rm /Scripts/ftp_tmp.sh & wait

sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/ftp_tmp.sh --create-dirs -o /Scripts/ftp_tmp.sh & wait

sudo bash /Scripts/ftp_tmp.sh
