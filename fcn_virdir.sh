#!/bin/bash

#### Example:
# SRC="/path/to/existing/dir"
# DST="/path/to/empty/dir"
# sudo bash /scripts/fcn_virdir.sh ${SRC} ${DST}

SRC="${1}"
DST="${2}"

if [ "${SRC}" == "" ]; then
   exit
fi

if [ "${DST}" == "" ]; then
    exit
fi

SRC="${SRC%/}"
DST="${DST%/}"

# Forcefully Unmount DST
sudo umount -fl ${DST} >/dev/null 2>&1

# Make Directories
sudo mkdir -p "${SRC}"
sudo mkdir -p "${DST}"

# If DST is NOT empty, exit.
if [[ $(sudo bash /scripts/fcn_chckdir4contents.sh "${DST}") == 1 ]]; then
    echo "Mountpoint is NOT empty. Exiting."
    exit
fi

# "Merge" SRC to DST
sudo mergerfs -o nonempty,allow_other,use_ino,category.create=ff "${SRC}" "${DST}"
