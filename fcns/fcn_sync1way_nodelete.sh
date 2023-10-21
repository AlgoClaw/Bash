#!/bin/bash

DIR1=${1%/}/
DIR2=${2%/}/

sudo rsync --relative --recursive --partial --progress --append-verify --update --times  "${DIR1}./" "${DIR2}"
