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
sudo apt install -y net-tools cifs-utils >/dev/null && \

# Check if directory exists, if not, make it.
if [ -d "${LOCDIR}" ]; then
  continue
else
  sudo mkdir -p "${LOCDIR}" >/dev/null && \
fi

# Exit if Something is mounted to LOCDIR already
if [[ $(sudo bash "/Scripts/fcn_chckmnt.sh" "${LOCDIR}") == 1 ]]; then
  echo "Directory Mounted Already. Exiting"
  exit
else
  continue
fi

# Exit if LOCDIR is NOT empty
if [[ $(sudo bash "/Scripts/fcn_chckdir4contents.sh" "${LOCDIR}") == 1 ]]; then
  echo "Directory is NOT Empty, Locking Directory and Exiting"
  sudo chattr +i "${LOCDIR}"
  exit
else
  sudo chattr -i "${LOCDIR}"
  continue
fi

# Exit if IP is unreachable
ping -c 1 -n "${REMIPA}" >/dev/null || exit

# Mount Remote Directory to Local Mountpoint
sudo mount -t cifs -o port="${PORTNO}",username="${USNAME}",password="${PASSWD}" "//${REMIPA}${REMDIR}" "${LOCDIR}" >/dev/null
