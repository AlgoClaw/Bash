#!/bin/bash

sudo rm /scripts/update_tmp.sh & wait

sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/update_tmp.sh --create-dirs -o /scripts/update_tmp.sh & wait

sudo bash /scripts/update_tmp.sh
