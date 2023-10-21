#!/bin/bash

sudo apt install -y rsync & wait

DIR1=${1%/}/
DIR2=${2%/}/

sudo rsync --relative --recursive --partial --progress --append-verify --update --times  "${DIR1}./" "${DIR2}"
