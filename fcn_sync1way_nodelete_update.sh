#!/bin/bash

sudo apt install -y rsync && \

DIR1=${1%/}/
DIR2=${2%/}/

sudo rsync --append-verify --partial --progress --archive --relative --update "${DIR1}./" "${DIR2}"
