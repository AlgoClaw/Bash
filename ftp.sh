#!/bin/bash

SCRDIR="/scripts"

sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/ftp_tmp.sh --create-dirs -o "${SCRDIR}"/ftp_tmp.sh & wait

sudo bash "${SCRDIR}"/ftp_tmp.sh
