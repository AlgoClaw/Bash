#!/bin/bash

#Usage example:
# fcn_str2file.sh "/etc/hosts" "127.0.0.1 localhost"

FILE="${1}"
STR="${2}"

if [ "${FILE}" = "" ]; then
	empty_file=true
else
	empty_file=false
fi

if [ "${STR}" = "" ]; then
	empty_str=true
else
	empty_str=false
fi

str2=$(sudo grep -x "${STR}" ${FILE})
if [ "${STR}" = "${str2}" ]; then
	exists=true
else
	exists=false
fi

# Troubleshooting
#echo "${FILE}"
#echo "${STR}"
#echo "${empty_file}"
#echo "${empty_str}"
#echo "${exists}"

if [ "${empty_file}" = false ] && [ "${empty_str}" = false ] && [ "${exists}" = false ]; then
sudo tee -a "${FILE}" > /dev/null <<EOT
${STR}
EOT
sudo apt install -y dos2unix &>/dev/null
sudo dos2unix "${FILE}" &>/dev/null
fi