#!/bin/bash

SMBSCRDIR="/Scripts"

sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/smb_tmp.sh --create-dirs -o "${SMBSCRDIR}"/smb_tmp.sh & wait

sudo bash "${SMBSCRDIR}"/smb_tmp.sh
