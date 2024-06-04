#!/bin/bash

###
### Add "$SUDO_USER" to "/etc/hosts"

sudo cat "/etc/hosts" | grep -q "127.0.0.1 $SUDO_USER" ||  $(sudo tee -a "/etc/hosts" > /dev/null <<EOT

127.0.0.1 $SUDO_USER
EOT)

###
### Adds "$USER" to "/etc/hosts"

sudo cat "/etc/hosts" | grep -q "127.0.0.1 $USER" ||  $(sudo tee -a "/etc/hosts" > /dev/null <<EOT

127.0.0.1 $USER
EOT)

###
### Add "$HOSTNAME" to "/etc/hosts"

sudo cat "/etc/hosts" | grep -q "127.0.0.1 $HOSTNAME" ||  $(sudo tee -a "/etc/hosts" > /dev/null <<EOT

127.0.0.1 $HOSTNAME
EOT)

###
### Add "localhost" to "/etc/hosts"

sudo cat "/etc/hosts" | grep -q "127.0.0.1 localhost" ||  $(sudo tee -a "/etc/hosts" > /dev/null <<EOT

127.0.0.1 localhost
EOT)
