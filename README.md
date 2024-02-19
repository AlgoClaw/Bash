1) Create and execute "/update_scripts.sh"

   sudo rm -f "/update_scripts.sh"

   sudo tee -a "/update_scripts.sh" > /dev/null <<EOT

   #!/bin/bash
   
   sudo DEBIAN_FRONTEND=noninteractive apt-get install -y git > /dev/null 2>&1
   
   sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/update_scripts_tmp.sh --create-dirs -o /update_scripts_tmp.sh > /dev/null 2>&1
   
   sudo bash /update_scripts_tmp.sh || sudo bash /Scripts/update_scripts_tmp.sh > /dev/null 2>&1
   
   sudo rm -f /update_scripts_tmp.sh > /dev/null 2>&1
   
   EOT

   sudo bash /update_scripts.sh
   
-------------------------------

2) Automatically execute "/update_scripts.sh" on boot
   
   sudo crontab -l | grep -q '@reboot sh "/update_scripts.sh"' || $((sudo crontab -l 2>/dev/null; echo '@reboot sh "/update_scripts.sh"') | sudo crontab -)
