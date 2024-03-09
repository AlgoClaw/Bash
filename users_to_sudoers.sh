#!/bin/bash

### Adds $USER to "/etc/sudoers"
### When executing a "sudo" command, $USER is passed to the variable $SUDO_USER

sudo cat "/etc/sudoers" | grep -q "$SUDO_USER ALL = (ALL) NOPASSWD: ALL" ||  $(sudo tee -a "/etc/sudoers" > /dev/null <<EOT

$SUDO_USER ALL = (ALL) NOPASSWD: ALL
EOT)

### Adds "root" to "/etc/sudoers"
### When executing a "sudo" command, $USER changes to "root"

sudo cat "/etc/sudoers" | grep -q "$USER ALL = (ALL) NOPASSWD: ALL" ||  $(sudo tee -a "/etc/sudoers" > /dev/null <<EOT

$USER ALL = (ALL) NOPASSWD: ALL
EOT)
