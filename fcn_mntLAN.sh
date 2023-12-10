#!/bin/bash

# sudo bash "/Scripts/fcn_mntLAN.sh" "/path/to/local/mnt" "192.168.xx.xx" "/path/to/remote/dir" "username" "password" "port"
# sudo bash "/Scripts/fcn_mntLAN.sh" "/mnt/LAN/ABC" "192.168.56.78" "/root"

LOCDIR="${1%/}"
REMIPA="${2}"
REMDIR="${3%/}"
USNAME="${4:-a}"
PASSWD="${5}"
PORTNO="${6:-445}"

# Install Dependencies
sudo apt-get install -y net-tools cifs-utils >/dev/null && \

# Check if directory exists, if not, make it.
sudo mkdir -p "${LOCDIR}" >/dev/null

# Exit if Something is mounted to LOCDIR already
if [[ $(sudo bash "${0%/*}"/fcn_chckmnt.sh "${LOCDIR}") == 1 ]]; then
  echo "Directory Mounted Already. Exiting"
  exit
fi

# If LOCDIR is NOT empty, lock it and exit. If empty, unlock it.
if [[ $(sudo bash "${0%/*}"/fcn_chckdir4contents.sh "${LOCDIR}") == 1 ]]; then
  echo "Directory is NOT Empty, Locking Directory and Exiting"
  sudo chattr +i "${LOCDIR}"
  exit
else
  sudo chattr -i "${LOCDIR}"
fi

# Exit if IP is Unreachable
ping -c 1 -n "${REMIPA}" >/dev/null || { echo "IP unreachable"; exit; }

# Mount Remote Directory to Local Mountpoint
sudo mount -t cifs -o port="${PORTNO}",username="${USNAME}",password="${PASSWD}" "//${REMIPA}${REMDIR}" "${LOCDIR}" >/dev/null
