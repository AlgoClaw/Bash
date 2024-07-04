#!/bin/bash

FILE="/etc/sudoers"

sudo bash fcn_str2file.sh "${FILE}" "localhost	ALL=(ALL:ALL) NOPASSWD:ALL"
sudo bash fcn_str2file.sh "${FILE}" "root	ALL=(ALL:ALL) NOPASSWD:ALL"
sudo bash fcn_str2file.sh "${FILE}" "${USER}	ALL=(ALL:ALL) NOPASSWD:ALL"
sudo bash fcn_str2file.sh "${FILE}" "${HOSTNAME}	ALL=(ALL:ALL) NOPASSWD:ALL"
