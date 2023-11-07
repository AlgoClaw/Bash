#!/bin/bash

# sudo bash "/Scripts/fcn_chckmnt.sh" "/path/to/local/mnt"
# 0 = not mounted
# 1 = mounted

MNTDIR="${1%/}"

sudo findmnt --mountpoint "${MNTDIR}" >/dev/null && echo "1" || echo "0"
