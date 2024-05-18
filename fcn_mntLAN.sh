#!/bin/bash

# sudo bash "/path/to/fcn_mntLAN.sh" "/path/to/local/mntpnt" "192.168.xx.xx" "/path/to/remote/dir" "username" "password" "port"
# sudo bash "/path/to/fcn_mntLAN.sh" "/mnt/LAN/ABC" "192.168.56.78" "/root"

LOCDIR="${1%/}"
REMIPA="${2}"
REMDIR="${3%/}"
USNAME="${4:-a}"
PASSWD="${5}"
PORTNO="${6:-445}"

# Install Dependencies
sudo apt-get install -y net-tools cifs-utils >/dev/null && \

# Script Direcotry
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ) >/dev/null

# Check if directory exists, if not, make it.
sudo mkdir -p "${LOCDIR}" >/dev/null

# Exit if Something is mounted to LOCDIR already
if [[ $(sudo bash $SCRIPT_DIR/fcn_chckmnt.sh "${LOCDIR}") == 1 ]]; then
  echo "Mountpoint directory already mounted. Exiting. (${LOCDIR})"
  exit
fi

# If LOCDIR is NOT empty, lock it and exit. If empty, unlock it.
if [[ $(sudo bash $SCRIPT_DIR/fcn_chckdir4contents.sh "${LOCDIR}") == 1 ]]; then
  echo "Mountpoint directory is NOT empty. Locking directory (chattr +i). Exiting. (${LOCDIR})"
  sudo chattr +i "${LOCDIR}"
  exit
else
  sudo chattr -i "${LOCDIR}"
fi

# Exit if IP is Unreachable
ping -c 1 -n "${REMIPA}" >/dev/null || { echo "Remote IP unreachable. Exiting. (${REMIPA} for ${LOCDIR})"; exit; }

# Mount Remote Directory to Local Mountpoint
sudo mount -t cifs -o port="${PORTNO}",username="${USNAME}",password="${PASSWD}" "//${REMIPA}${REMDIR}" "${LOCDIR}" >/dev/null && echo "Directory mounted at ${LOCDIR}"
