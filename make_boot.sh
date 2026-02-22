#!/bin/bash

# Make boot.sh script (Non-destructive)
if [ ! -f "/scripts/boot.sh" ]; then
    sudo tee "/scripts/boot.sh" >/dev/null <<EOT
#!/bin/bash

# USB Mounts
sudo bash /scripts/mnt_drives.sh

# Start Docker
sudo systemctl start docker

# LAN Mounts
sudo bash /scripts/mnt_LAN.sh

# Virtual Mounts
sudo bash /scripts/mnt_virtual.sh

EOT
    # Make executable
    sudo chmod +x "/scripts/boot.sh"
fi

# Add boot.sh script to crontab
sudo crontab -l | grep -q "/scripts/boot.sh" || ( (sudo crontab -l 2>/dev/null; echo '@reboot /bin/bash "/scripts/boot.sh"') | sudo crontab - )
