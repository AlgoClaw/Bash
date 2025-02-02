#!/bin/bash

# Uninstall and purge FTP server installation
sudo apt remove -y --purge vsftpd

# Install FTP server
sudo bash fcn_install.sh "vsftpd"

# Change FTP root directory to system’s root directory ("/")
sudo usermod -d "/" ftp

# Configure FTP server to allow for anonymous read/write access
sudo rm -r "/etc/vsftpd.conf"
sudo tee -a "/etc/vsftpd.conf" > /dev/null <<EOT
# Default Options
listen=YES
local_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
pam_service_name=vsftpd
ssl_enable=NO
#
# Custom Options
anonymous_enable=YES
write_enable=YES
anon_upload_enable=YES
anon_mkdir_write_enable=YES
anon_other_write_enable=YES
dirlist_enable=YES
force_dot_files=YES
anon_world_readable_only=NO
EOT

# (Re)enable and (re)start FTP server
sudo systemctl enable vsftpd.service
sudo systemctl restart vsftpd.service
