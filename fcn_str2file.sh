#!/bin/bash

# Usage example:
# fcn_str2file.sh "/etc/hosts" "127.0.0.1 localhost"
# fcn_str2file.sh "/etc/sudoers" "ubuntu	ALL=(ALL:ALL) NOPASSWD:ALL"

FILE="${1}"
STR="${2}"

# File empty?
if [ "${FILE}" = "" ]; then
	empty_file=true
else
	empty_file=false
fi

# String empty?
if [ "${STR}" = "" ]; then
	empty_str=true
else
	empty_str=false
fi

# String already exists as a line?
str2=$(sudo grep -x "${STR}" ${FILE} | tail -1)
if [ "${STR}" = "${str2}" ]; then
	exists=true
else
	exists=false
fi

# Write to File
if [ "${empty_file}" = false ] && [ "${empty_str}" = false ] && [ "${exists}" = false ]; then

sudo tee -a "${FILE}" > /dev/null <<EOT
${STR}
EOT

fi

# Debugging
#echo "${FILE}"
#echo "${STR}"
#echo "${empty_file}"
#echo "${empty_str}"
#echo "${exists}"
#echo "${str2}"
#sudo cat "${FILE}"
