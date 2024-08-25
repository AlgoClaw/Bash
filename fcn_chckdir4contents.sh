#!/bin/bash

# sudo bash "/Scripts/fcn_chckdir4contents.sh" "/path/to/dir"
# 0 = empty
# 1 = NOT empty

DIR="${1%/}"

if [ "$(ls -A ${DIR})" == "" ]; then
	echo "0" # empty
else
	echo "1" # NOT empty
fi
