#!/bin/bash

###

sudo cat "/etc/sudoers" | grep -q "$SUDO_USER ALL = (ALL) NOPASSWD: ALL" ||  $(sudo tee -a "/etc/sudoers" > /dev/null <<EOT

$SUDO_USER ALL = (ALL) NOPASSWD: ALL
EOT)

###

sudo cat "/etc/hosts" | grep -q "127.0.0.1 $USER" ||  $(sudo tee -a "/etc/hosts" > /dev/null <<EOT

127.0.0.1 $USER
EOT)

###

sudo cat "/etc/hosts" | grep -q "127.0.0.1 $HOSTNAME" ||  $(sudo tee -a "/etc/hosts" > /dev/null <<EOT

127.0.0.1 $HOSTNAME
EOT)

###

sudo cat "/etc/hosts" | grep -q "127.0.0.1 localhost" ||  $(sudo tee -a "/etc/hosts" > /dev/null <<EOT

127.0.0.1 localhost
EOT)

###

sudo cat "/etc/hosts" | grep -q "127.0.0.1 $SUDO_USER" ||  $(sudo tee -a "/etc/hosts" > /dev/null <<EOT

127.0.0.1 $SUDO_USER
EOT)