1) Create "/update_scripts.sh"

  sudo rm -f "/update_scripts.sh"
  
  sudo tee -a "/update_scripts.sh" > /dev/null <<EOT
  #!/bin/bash
  
  sudo DEBIAN_FRONTEND=noninteractive apt install -y git > /dev/null 2>&1
  
  sudo curl https://raw.githubusercontent.com/AlgoClaw/Bash/main/update_scripts_tmp.sh --create-dirs -o /update_scripts_tmp.sh > /dev/null 2>&1
  
  sudo bash /update_scripts_tmp.sh > /dev/null 2>&1
  
  sudo rm -f /update_scripts_tmp.sh > /dev/null 2>&1
  EOT
  
  sudo bash /update_scripts.sh

-------------------------------

2) Run "/update_scripts.sh" on boot
   sudo crontab -e
   --- paste in ----
   @reboot sh "/update_scripts.sh"
   --- save & exit ----
