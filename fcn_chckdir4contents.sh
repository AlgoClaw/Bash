#!/bin/bash

# sudo bash "/Scripts/fcn_chckdir4contents.sh" "/path/to/dir"
# 0 = empty
# 1 = NOT empty

DIR="${1%/}"

[[ $(sudo ls -A "${DIR}") ]] && echo "1" || echo "0"
