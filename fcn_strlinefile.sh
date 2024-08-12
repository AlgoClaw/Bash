#!/bin/bash

# Usage example:
# fcn_strlinefile.sh "/etc/hosts" "127.0.0.1"

FILE="${1}"
STR="${2}"

str_in_file=$(sudo grep "${STR}*" ${FILE} | tail -1)

if [ "${str_in_file}" = "" ]; then
	str_exist=false
else
	str_exist=true
fi

echo "${str_exist}"