# Download update_scripts.sh to root directory

sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/update_scripts.sh --create-dirs -o "/update_scripts.sh"

# Execute update_scripts.sh

sudo bash "/update_scripts.sh"

# Add update_scripts.sh to crontab to execute on boot

sudo crontab -l | grep -q "update_scripts.sh" || $((sudo crontab -l 2>/dev/null; echo '@reboot sh "/update_scripts.sh"') | sudo crontab -)

# Other crontab edits and scripts

sudo bash make_boot.sh

sudo bash make_every_xx.sh
