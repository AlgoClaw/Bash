#!/bin/bash

USRSTR="${1}"
SUDOLOC="/etc/sudoers"

if [ "${USRSTR}" = "" ]; then
	user_empty=true
else
	user_empty=false
fi

str1=$(sudo grep "$USRSTR	ALL=(ALL:ALL) NOPASSWD:ALL" ${SUDOLOC} | tail -1)
str2=$(echo "$USRSTR	ALL=(ALL:ALL) NOPASSWD:ALL")
if [ "${str1}" = "${str2}" ]; then
	user_entryexist=true
else
	user_entryexist=false
fi

if [ "${user_empty}" = false ] && [ "${user_entryexist}" = false ]; then
	echo "${USRSTR}	ALL=(ALL:ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo
fi

#sudo $(awk '!a[$0]++' ${SUDOLOC} > ${SUDOLOC}1)

sudo apt install -y dos2unix &>/dev/null
sudo dos2unix ${SUDOLOC} &>/dev/null