#!/bin/bash

FILE="/etc/hosts"

sudo bash fcn_str2file.sh "${FILE}" "127.0.0.1 localhost"
sudo bash fcn_str2file.sh "${FILE}" "127.0.0.1 root"
sudo bash fcn_str2file.sh "${FILE}" "127.0.0.1 ${USER}"
sudo bash fcn_str2file.sh "${FILE}" "127.0.0.1 ${HOSTNAME}"
sudo bash fcn_str2file.sh "${FILE}" "127.0.0.1 ${SUDO_USER}"
#sudo bash fcn_str2file.sh "${FILE}" "127.0.0.1 ${SUDO_NAME}"
