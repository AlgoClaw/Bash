#!/bin/bash

# sudo bash "/path/to/fcn_sync2way.sh" "/path/to/dir1" "/path/to/dir2"

DIR1=${1%/}/
DIR2=${2%/}/

# Install dependencies
sudo bash fcn_install.sh "rsync"

# DIR1 to DIR2
sudo rsync --relative --recursive --partial --progress --append-verify "${DIR1}./" "${DIR2}" & wait

# DIR2 to DIR1
sudo rsync --relative --recursive --partial --progress --append-verify "${DIR2}./" "${DIR1}"
