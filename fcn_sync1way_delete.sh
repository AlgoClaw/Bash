#!/bin/bash

# sudo bash fcn_sync1way_delete.sh "/path/to/source" "/path/to/destination"

sudo bash fcn_install.sh "rsync"

DIR1=${1%/}/
DIR2=${2%/}/

# EXPLICIT CHECK: Exit immediately if the source directory does not exist.
if [ ! -d "${DIR1}" ]; then
    echo "Error: Source directory '${DIR1}' does not exist. Aborting to protect backup."
    exit 1
fi

sudo mkdir -p "${DIR2}"

sudo chmod -R 777 "${DIR1}"
sudo chmod -R 777 "${DIR2}"

sudo rsync \
--partial \
--relative \
--progress \
--archive \
--delete-after \
--inplace \
"${DIR1}./" \
"${DIR2}"
