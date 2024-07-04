#!/bin/bash

# Make boot.sh script
sudo ls "/Scripts/boot.sh" &>/dev/null || $(sudo tee -a "/Scripts/boot.sh" &>/dev/null <<EOT
#!/bin/bash

# USB Mounts
sudo bash /Scripts/mnt_USB.sh & wait

# Samba
sudo bash /Scripts/smb.sh & wait

# Start Docker
sudo systemctl start docker & wait

# LAN Mounts
sudo bash /Scripts/mnt_LAN.sh & wait
EOT
) &>/dev/null

# Add boot.sh script to crontab
sudo crontab -l | grep -q "/Scripts/boot.sh" || $((sudo crontab -l 2>/dev/null; echo '@reboot sh "/Scripts/boot.sh"') | sudo crontab -)
