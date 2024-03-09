#!/bin/bash

### Adds $USER to "/etc/hosts"
### When executing a "sudo" command, $USER is passed to the variable $SUDO_USER

sudo cat "/etc/hosts" | grep -q "127.0.0.1 $SUDO_USER" ||  $(sudo tee -a "/etc/hosts" > /dev/null <<EOT

127.0.0.1 $SUDO_USER
EOT)

### Adds "root" to "/etc/hosts"
### When executing a "sudo" command, $USER changes to "root"

sudo cat "/etc/hosts" | grep -q "127.0.0.1 $USER" ||  $(sudo tee -a "/etc/hosts" > /dev/null <<EOT

127.0.0.1 $USER
EOT)

### Adds $HOSTNAME to "/etc/hosts"

sudo cat "/etc/hosts" | grep -q "127.0.0.1 $HOSTNAME" ||  $(sudo tee -a "/etc/hosts" > /dev/null <<EOT

127.0.0.1 $HOSTNAME
EOT)

### Adds "localhost" to "/etc/hosts"

sudo cat "/etc/hosts" | grep -q "127.0.0.1 localhost" ||  $(sudo tee -a "/etc/hosts" > /dev/null <<EOT

127.0.0.1 localhost
EOT)
