#!/bin/bash

USRSTR="${1}"
SUDOLOC="/etc/sudoers"


if [ "${USRSTR}" = "" ]; then
	user_empty=true
else
	user_empty=false
fi

str1="$USRSTR	ALL=(ALL:ALL) NOPASSWD:ALL"
str2=$(sudo grep "${str1}" ${SUDOLOC} | tail -1)

if [ "${str1}" = "${str2}" ]; then
	user_entryexist=true
else
	user_entryexist=false
fi


if [ "${user_empty}" = false ] && [ "${user_entryexist}" = false ]; then
	echo "${USRSTR}	ALL=(ALL:ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo
fi


sudo apt install -y dos2unix &>/dev/null
sudo dos2unix ${SUDOLOC} &>/dev/null
