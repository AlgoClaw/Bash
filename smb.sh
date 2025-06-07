#!/bin/bash

SCRDIR="/scripts"

sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/smb_tmp.sh --create-dirs -o "${SCRDIR}"/smb_tmp.sh & wait

sudo bash "${SCRDIR}"/smb_tmp.sh
