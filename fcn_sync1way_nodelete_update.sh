#!/bin/bash

# sudo bash fcn_sync1way_nodelete_update.sh "/path/to/source" "/path/to/destination"

sudo bash fcn_install.sh "rsync"

DIR1=${1%/}/
DIR2=${2%/}/

sudo mkdir -p "${DIR1}"
sudo mkdir -p "${DIR2}"

sudo chmod -R 777 "${DIR1}"
sudo chmod -R 777 "${DIR2}"

sudo rsync --append-verify --partial --progress --archive --relative --update "${DIR1}./" "${DIR2}"
