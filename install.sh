sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/update_scripts.sh --create-dirs -o "/update_scripts.sh"

sudo bash "/update_scripts.sh"

sudo crontab -l | grep -q "update_scripts.sh" || $((sudo crontab -l 2>/dev/null; echo '@reboot sh "/update_scripts.sh"') | sudo crontab -)

sudo bash make_boot.sh

sudo bash make_every_xx.sh

sudo bash users_to_sudoers.sh

sudo bash users_to_hosts.sh

sudo bash disable_login_spam.sh
