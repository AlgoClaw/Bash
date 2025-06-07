#!/bin/bash

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y git > /dev/null 2>&1

sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/update_scripts_tmp.sh --create-dirs -o /update_scripts_tmp.sh > /dev/null 2>&1

sudo bash /update_scripts_tmp.sh || sudo bash /scripts/update_scripts_tmp.sh > /dev/null 2>&1

sudo rm -f /update_scripts_tmp.sh > /dev/null 2>&1
