#!/bin/bash

########
######## Every 01 Min
########

# Make 0_Every01Min.sh script
sudo ls "/Scripts/0_Every01Min.sh" &>/dev/null || $(sudo tee -a "/Scripts/0_Every01Min.sh" &>/dev/null <<EOT
#!/bin/bash

# sudo bash /Scripts/script.sh
EOT) &>/dev/null

# Add 0_Every01Min.sh script to crontab
sudo crontab -l | grep -q "/Scripts/0_Every01Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/01 * * * * sh "/Scripts/0_Every01Min.sh"') | sudo crontab -)

########
######## Every 05 Min
########

# Make 0_Every05Min.sh script
sudo ls "/Scripts/0_Every05Min.sh" &>/dev/null || $(sudo tee -a "/Scripts/0_Every05Min.sh" &>/dev/null <<EOT
#!/bin/bash

# sudo bash /Scripts/script.sh
EOT) &>/dev/null

# Add 0_Every05Min.sh script to crontab
sudo crontab -l | grep -q "/Scripts/0_Every05Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/05 * * * * sh "/Scripts/0_Every05Min.sh"') | sudo crontab -)

########
######## Every 15 Min
########

# Make 0_Every15Min.sh script
sudo ls "/Scripts/0_Every15Min.sh" &>/dev/null || $(sudo tee -a "/Scripts/0_Every15Min.sh" &>/dev/null <<EOT
#!/bin/bash

# sudo bash /Scripts/script.sh
EOT) &>/dev/null

# Add 0_Every15Min.sh script to crontab
sudo crontab -l | grep -q "/Scripts/0_Every15Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/15 * * * * sh "/Scripts/0_Every15Min.sh"') | sudo crontab -)

########
######## Every 30 Min
########

# Make 0_Every30Min.sh script
sudo ls "/Scripts/0_Every30Min.sh" &>/dev/null || $(sudo tee -a "/Scripts/0_Every30Min.sh" &>/dev/null <<EOT
#!/bin/bash

# sudo bash /Scripts/script.sh
EOT) &>/dev/null

# Add 0_Every30Min.sh script to crontab
sudo crontab -l | grep -q "/Scripts/0_Every30Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/30 * * * * sh "/Scripts/0_Every30Min.sh"') | sudo crontab -)

########
######## Every 60 Min
########

# Make 0_Every60Min.sh script
sudo ls "/Scripts/0_Every60Min.sh" &>/dev/null || $(sudo tee -a "/Scripts/0_Every60Min.sh" &>/dev/null <<EOT
#!/bin/bash

sudo bash /Scripts/Update_DDClient.sh
EOT) &>/dev/null

# Add 0_Every60Min.sh script to crontab
sudo crontab -l | grep -q "/Scripts/0_Every60Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/60 * * * * sh "/Scripts/0_Every60Min.sh"') | sudo crontab -)

########
######## Every 02 AM
########

# Make 0_Every02AM.sh script
sudo ls "/Scripts/0_Every02AM.sh" &>/dev/null || $(sudo tee -a "/Scripts/0_Every02AM.sh" &>/dev/null <<EOT
#!/bin/bash

EOT) &>/dev/null

# Add 0_Every02AM.sh script to crontab
sudo crontab -l | grep -q "/Scripts/0_Every02AM.sh.sh" || $((sudo crontab -l 2>/dev/null; echo '*/0 2 * * * sh "/Scripts/0_Every02AM.sh"') | sudo crontab -)
