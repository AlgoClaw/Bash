#!/bin/bash

DIR1=${1%/}/
DIR2=${2%/}/

# DIR1 to DIR2
sudo rsync --update --times --recursive "${DIR1}./" "${DIR2}"

# DIR2 to DIR1
sudo rsync --update --times --recursive "${DIR2}./" "${DIR1}"