#!/bin/bash

# Example
# sudo bash /scripts/fcn_virdir.sh 

SRC="${1}"
DST="${2}"

if [ "${SRC}" == "" ]; then
	exit
fi

if [ "${DST}" == "" ]; then
    exit
fi

# Script Direcotry
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ) >/dev/null 2>&1

# Forcefully Unmount Directory
sudo umount -fl ${DST} >/dev/null 2>&1

# Make Directory
sudo mkdir -p ${DST}

# If DST is NOT empty, exit.
if [[ $(sudo bash $SCRIPT_DIR/fcn_chckdir4contents.sh ${DST}) == 1 ]]; then
    echo "Mountpoint is NOT empty. Exiting."
    exit
fi

# "Merge" SRC to DST
sudo mergerfs -o nonempty,allow_other,use_ino,category.create=ff ${SRC} ${DST}