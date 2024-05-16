#!/bin/bash

# Install Samba
sudo DEBIAN_FRONTEND=noninteractive apt install -y samba samba-common-bin

# Delete Existing smb.conf
sudo rm -f "/etc/samba/smb.conf"

# Generate smb.conf
sudo tee -a "/etc/samba/smb.conf" > /dev/null <<EOT
[global]
   unix extensions = NO
   workgroup = WORKGROUP
   map to guest = BAD USER
   usershare allow guests = YES
   store dos attributes = NO
   ea support = NO
   map archive = NO
   map hidden = NO
   map system = NO
   map readonly = NO

[root]
   path = /
   public = YES
   read only = NO
   writeable = YES
   guest ok = YES
   guest only = YES
   browseable = YES
   wide links = YES
   hide dot files = NO
   follow symlinks = YES
   protocol = SMB3
   force user = root
   create mask = 0777
   directory mask = 0777
   force create mode = 0777
   force directory mode = 0777
EOT

# Services
sudo service smbd reload
sudo service smbd restart
sudo service nmbd reload
sudo service nmbd restart
