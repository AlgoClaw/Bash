#!/bin/bash

# sudo bash fcn_backup_timestamp.sh /path/to/dir1 /path/to/dir2

DIR1=${1%/}/
DIR2=${2%/}/
DIR2_Date="${DIR2}"`date +%F_%H-%M-%S`/

mkdir "${DIR2}" >/dev/null
mkdir "${DIR2_Date}" >/dev/null

sudo rsync --partial --append-verify --recursive --relative "${DIR1}./" "${DIR2_Date}"
