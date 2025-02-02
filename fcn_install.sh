#!/bin/bash

# sudo bash fcn_install.sh "rsync"

PKG=${1%}

INSTALL_STATE=$(dpkg -l | grep "${PKG}" | grep ii >/dev/null && echo "1" || echo "0")

#echo "${INSTALL_STATE}"

# 0 = not installed
# 1 = installed

if [[ "${INSTALL_STATE}" == 1 ]]; then
  #echo '"'"${PKG}"'"'" already installed"
else
  #echo '"'"${PKG}"'"'" not installed, installing now"
  sudo DEBIAN_FRONTEND=noninteractive apt install -y ${PKG}
fi
