#!/bin/bash

DIR1=${1%/}/
DIR2=${2%/}/
DIR2_Date="${DIR2}"`date +%F_%H-%M-%S`/

mkdir "${DIR2}" 2>/dev/null
mkdir "${DIR2_Date}" 2>/dev/null

sudo rsync --partial --append-verify --recursive --relative "${DIR1}./" "${DIR2_Date}"