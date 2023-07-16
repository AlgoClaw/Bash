#!/bin/bash

# Example Usage
# "/path/to/script/mnt_LAN_fcn.sh" "/path/to/local/mnt" "192.168.xx.xx" "/path/to/remote/dir" "username" "password"

LOCDIR="${1%/}"
REMIPA="${2}"
REMDIR="${3%/}"
USNAME="${4:-a}"
PASSWD="${5}"
PORTNO="${6:-445}"

# Install Dependencies
sudo apt install -y net-tools cifs-utils & wait >/dev/null

# Wait for Live LAN Connection (30 seconds max)
i=1
while ! timeout 1 ping -c 1 -n "${REMIPA}" &> /dev/null
do
	((i=i+1))
	printf $i
	if [ $i -gt 20 ]
	then
		break
	fi
done

# Unlock Writes to Mountpoint (if nothing is mounted)
mountpoint -q "${LOCDIR}" || sudo chattr -i "${LOCDIR}" & wait >/dev/null

# Delete Mountpoint and All Contents (if nothing is mounted)
mountpoint -q "${LOCDIR}" || sudo rm -r "${LOCDIR}" & wait >/dev/null

# Create Mountpoint Directory (if it does not exist already)
sudo mkdir -p "${LOCDIR}" & wait >/dev/null

# Lock Writes to Mountpoint
sudo chattr +i "${LOCDIR}" & wait >/dev/null

# Mount Remote Directory to Local Mountpoint
sudo mount -t cifs -o port="${PORTNO}",username="${USNAME}",password="${PASSWD}" "//${REMIPA}${REMDIR}" "${LOCDIR}" >/dev/null

# Unlock Writes to Mountpoint (if mounted)
mountpoint -q "${LOCDIR}" && sudo chattr -i "${LOCDIR}" & wait >/dev/null
