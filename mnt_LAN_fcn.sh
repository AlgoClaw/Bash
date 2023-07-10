#!/bin/bash

LOCDIR="${1}"
REMDIR="${2}"
USNAME="${3:-a}"
PASSWD="${4}"
PORTNO="${5:-445}"

# Install Dependencies
sudo apt install -y net-tools cifs-utils & wait >/dev/null

# Wait for Live LAN Connection (30 seconds max)
i=0
until ifconfig | grep -F "192.168" >/dev/null
do
	sleep 1 >/dev/null
	((i=i+1))
	if [ $i -gt 30 ]
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
sudo mount -t cifs -o port="${PORTNO}",username="${USNAME}",password="${PASSWD}" "${REMDIR}" "${LOCDIR}" >/dev/null

# Unlock Writes to Mountpoint (if mounted)
mountpoint -q "${LOCDIR}" && sudo chattr -i "${LOCDIR}" & wait >/dev/null
