#!/bin/bash

# sudo bash "/path/to/fcn_mntLAN.sh" "/path/to/local/mntpnt" "192.168.xx.xx" "/path/to/remote/dir" "username" "password" "port"
# sudo bash "/path/to/fcn_mntLAN.sh" "/mnt/LAN/ABC" "192.168.56.78" "/root"

#####

# 1. Directory exist?
#  1.1. No - Make directory
# 2. Lock directory
# 3. Directory already mountpoint?
#  3.1. Yes - Do NOT mount, print error, EXIT
# 4. Directory empty?
#  4.1. No -  Do NOT mount, print error, EXIT
# 5. IP reachable?
#  5.1. No -  Do NOT mount, print error, EXIT
# 6. (Attempt) mount.
# 7. Directory already mountpoint?
#  7.1. Yes - Print success, EXIT
#  7.2. No  - Print error, EXIT

LOCDIR="${1%/}"
REMIPA="${2}"
REMDIR="${3%/}"
USNAME="${4:-a}"
PASSWD="${5:-a}"
PORTNO="${6:-445}"

# Script Direcotry
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ) >/dev/null

# Install Dependencies
sudo bash $SCRIPT_DIR/fcn_install.sh "net-tools" & wait
sudo bash $SCRIPT_DIR/fcn_install.sh "cifs-utils" & wait

#####

# 1. Check if LOCDIR exists. If not, create LOCDIR.
sudo mkdir -p "${LOCDIR}" >/dev/null

# 2. Lock LOCDIR to prevent local writes. Applicable in all cases.
sudo chattr +i "${LOCDIR}" >/dev/null 2>&1

# 3. Check if LOCDIR is already a mountpoint. If so, exit.
if [[ $(sudo bash $SCRIPT_DIR/fcn_chckmnt.sh "${LOCDIR}") == 1 ]]; then
  echo "Mountpoint already mounted. Exiting. (${LOCDIR})"
  exit
fi

# 4. Check if LOCDIR is empty. If not, exit.
if [[ $(sudo bash $SCRIPT_DIR/fcn_chckdir4contents.sh "${LOCDIR}") == 1 ]]; then
  echo "Mountpoint is NOT empty. Exiting. Unlocking (sudo chattr -i ${LOCDIR}) required to edit mountpoint."
  exit
fi

# 5. Check if IP is reachable. If not, exit.
ping -c 1 -n "${REMIPA}" >/dev/null || \
{ echo "Mount FAILED. IP unreachable. Exiting. (//${REMIPA}${REMDIR} NOT mounted at ${LOCDIR})"; exit; }

# 6. (Attempt) Mounting {REMIPA}{REMDIR} to LOCDIR
# Determine the target user for ownership
# If SUDO_USER is set (sudo used), use it. Otherwise fallback to current user (e.g., root).
TARGET_USER="${SUDO_USER:-$(whoami)}"
# Uses TARGET_USER to assign ownership dynamically
sudo mount -t cifs -o port="${PORTNO}",username="${USNAME}",password="${PASSWD}",uid=$(id -u "${TARGET_USER}"),gid=$(id -g "${TARGET_USER}") "//${REMIPA}${REMDIR}" "${LOCDIR}" >/dev/null

# 7. Check if LOCDIR is already a mountpoint. If so, print success. If not, print error.
if [[ $(sudo bash $SCRIPT_DIR/fcn_chckmnt.sh "${LOCDIR}") == 1 ]]; then
  echo "Mount SUCCESS (//${REMIPA}${REMDIR} mounted at ${LOCDIR})"
else
  echo "Mount FAILED. Last step. (//${REMIPA}${REMDIR} NOT mounted at ${LOCDIR})"
fi
