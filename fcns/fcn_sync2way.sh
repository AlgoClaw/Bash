#!/bin/bash

# sudo bash fcn_sync2way /path/to/dir1 /path/to/dir2

DIR1=${1%/}/
DIR2=${2%/}/

# Install dependencies
sudo apt install -y rsync & wait

# DIR1 to DIR2
sudo rsync --relative --recursive --partial --progress --append-verify --update --times "${DIR1}./" "${DIR2}" & wait

# DIR2 to DIR1
sudo rsync --relative --recursive --partial --progress --append-verify --update --times "${DIR2}./" "${DIR1}"
