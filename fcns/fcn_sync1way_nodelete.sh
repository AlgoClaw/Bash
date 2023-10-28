#!/bin/bash

sudo apt install -y rsync & wait

DIR1=${1%/}/
DIR2=${2%/}/

sudo rsync --partial --append-verify --recursive --relative  --progress  --update --times  "${DIR1}./" "${DIR2}"
