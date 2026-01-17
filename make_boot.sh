#!/bin/bash

# Make boot.sh script
sudo ls "/scripts/boot.sh" &>/dev/null || $(sudo tee -a "/scripts/boot.sh" &>/dev/null <<EOT
#!/bin/bash

# USB Mounts
sudo bash /scripts/mnt_USB.sh

# Samba
sudo bash /scripts/smb.sh

# Start Docker
sudo systemctl start docker

# LAN Mounts
sudo bash /scripts/mnt_LAN.sh

# Virtual Mounts
sudo bash /scripts/mnt_virtual.sh

EOT
) &>/dev/null

# Add boot.sh script to crontab
sudo crontab -l | grep -q "/scripts/boot.sh" || $((sudo crontab -l 2>/dev/null; echo '@reboot sh "/scripts/boot.sh"') | sudo crontab -)
