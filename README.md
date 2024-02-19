1) Create and execute "/update_scripts.sh"

   sudo rm -f "/update_scripts.sh"

   sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/update_scripts.sh --create-dirs -o "/update_scripts.sh"

   sudo bash "/update_scripts.sh"
   
-------------------------------

2) Automatically execute "/update_scripts.sh" on boot
   
   sudo crontab -l | grep -q '@reboot sh "/update_scripts.sh"' || $((sudo crontab -l 2>/dev/null; echo '@reboot sh "/update_scripts.sh"') | sudo crontab -)
