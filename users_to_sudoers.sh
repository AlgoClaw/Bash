#!/bin/bash

### Adds $USER to "/etc/sudoers"
### When executing a "sudo" command, $USER is passed to the variable $SUDO_USER (not always true)

if [$(sudo echo $SUDO_USER) -eq ""]
then
else
sudo cat "/etc/sudoers" | grep -q "$SUDO_USER ALL = (ALL) NOPASSWD: ALL" ||  $(sudo tee -a "/etc/sudoers" > /dev/null <<EOT
$SUDO_USER ALL = (ALL) NOPASSWD: ALL
EOT)
fi

### Adds "root" to "/etc/sudoers"
### When executing a "sudo" command, $USER changes to "root" (not always true)

if [$(sudo echo $USER) -eq ""]
then
else
sudo cat "/etc/sudoers" | grep -q "$USER ALL = (ALL) NOPASSWD: ALL" ||  $(sudo tee -a "/etc/sudoers" > /dev/null <<EOT
$USER ALL = (ALL) NOPASSWD: ALL
EOT)
fi
