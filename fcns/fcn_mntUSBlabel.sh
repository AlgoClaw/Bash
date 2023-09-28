#!/bin/bash

# fcn_mnt_USB_label.sh /path/to/mount/dir label

DIR="${1}"
LBL="${2}"

# Delete Mountpoint and All Contents (if nothing is mounted)
mountpoint -q "${DIR}" || sudo rm -r "${DIR}" & wait >/dev/null

# Create Mountpoint Directory (if it does not exist already)
sudo mkdir -p "${DIR}" & wait >/dev/null

# Lock Writes to Mountpoint
sudo chattr +i "${DIR}" & wait >/dev/null

# Mount Disk to Mountpoint
sudo mount -L "${LBL}" "${DIR}" & wait >/dev/null

# Unlock Writes to Mountpoint (if mounted)
mountpoint -q "${DIR}" && sudo chattr -i "${DIR}" & wait >/dev/null
