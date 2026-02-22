#!/bin/bash

# sudo bash fcn_mnt-drive-label.sh "/path/to/mount/dir" "LABEL_NAME"

LOCDIR="${1%/}"
LBL="${2}"

# Script Directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ) >/dev/null

# Version: 2026.02.22.13.15.00

#####

# 1. Check if LOCDIR exists. If not, create LOCDIR.
sudo mkdir -p "${LOCDIR}" >/dev/null

# 2. Lock LOCDIR to prevent local writes while unmounted.
sudo chattr +i "${LOCDIR}" >/dev/null 2>&1

# 3. Check if LOCDIR is already a mountpoint. If so, exit.
if [[ $(sudo bash "$SCRIPT_DIR/fcn_chckmnt.sh" "${LOCDIR}") == 1 ]]; then
  echo "Mountpoint already mounted. Exiting. (${LOCDIR})"
  exit
fi

# 4. Check if LOCDIR is empty. If not, exit.
# Note: Since we use chattr +i, it should be empty unless files were there before locking.
if [[ $(sudo bash "$SCRIPT_DIR/fcn_chckdir4contents.sh" "${LOCDIR}") == 1 ]]; then
  echo "Mountpoint is NOT empty. Exiting. Unlocking (sudo chattr -i ${LOCDIR}) required to edit mountpoint."
  exit
fi

# 5. Check if the Label exists on the system.
if ! blkid -L "${LBL}" >/dev/null; then
  echo "Mount FAILED. Label '${LBL}' not found. Exiting."
  exit
fi

# 6. (Attempt) Mounting by Label
# Determine the target user for ownership (SUDO_USER or current)
TARGET_USER="${SUDO_USER:-$(whoami)}"

# Note: permissions/ownership for exfat/vfat must be set at mount time via -o
# For ext4 and others, these flags are ignored, and you'd use chown after mounting.
sudo mount -L "${LBL}" "${LOCDIR}" -o uid=$(id -u "${TARGET_USER}"),gid=$(id -g "${TARGET_USER}") >/dev/null 2>&1 || \
sudo mount -L "${LBL}" "${LOCDIR}" >/dev/null

# 7. Check if mount was successful.
if [[ $(sudo bash "$SCRIPT_DIR/fcn_chckmnt.sh" "${LOCDIR}") == 1 ]]; then
  # Unlock the directory so the user can actually write to the mounted drive
  sudo chattr -i "${LOCDIR}" >/dev/null 2>&1
  echo "Mount SUCCESS (Drive '${LBL}' mounted at ${LOCDIR})"
else
  echo "Mount FAILED. (Drive '${LBL}' NOT mounted at ${LOCDIR})"
fi