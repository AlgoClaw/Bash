#!/bin/bash

########
######## 05
########

# Make 0_Every05Min.sh script
sudo ls "/Scripts/0_Every05Min.sh" &>/dev/null || $(sudo tee -a "/Scripts/0_Every05Min.sh" &>/dev/null <<EOT
#!/bin/bash

# sudo bash /Scripts/script.sh
EOT) &>/dev/null

# Add 0_Every05Min.sh script to crontab
sudo crontab -l | grep -q "/Scripts/0_Every05Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/05 * * * * sh "/Scripts/0_Every05Min.sh"') | sudo crontab -)

########
######## 15
########

# Make 0_Every15Min.sh script
sudo ls "/Scripts/0_Every15Min.sh" &>/dev/null || $(sudo tee -a "/Scripts/0_Every15Min.sh" &>/dev/null <<EOT
#!/bin/bash

# sudo bash /Scripts/script.sh
EOT) &>/dev/null

# Add 0_Every05Min.sh script to crontab
sudo crontab -l | grep -q "/Scripts/0_Every15Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/05 * * * * sh "/Scripts/0_Every15Min.sh"') | sudo crontab -)

########
######## 30
########

# Make 0_Every30Min.sh script
sudo ls "/Scripts/0_Every30Min.sh" &>/dev/null || $(sudo tee -a "/Scripts/0_Every30Min.sh" &>/dev/null <<EOT
#!/bin/bash

# sudo bash /Scripts/script.sh
EOT) &>/dev/null

# Add 0_Every05Min.sh script to crontab
sudo crontab -l | grep -q "/Scripts/0_Every30Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/05 * * * * sh "/Scripts/0_Every30Min.sh"') | sudo crontab -)

########
######## 60
########

# Make 0_Every60Min.sh script
sudo ls "/Scripts/0_Every60Min.sh" &>/dev/null || $(sudo tee -a "/Scripts/0_Every60Min.sh" &>/dev/null <<EOT
#!/bin/bash

# sudo bash /Scripts/script.sh
EOT) &>/dev/null

# Add 0_Every05Min.sh script to crontab
sudo crontab -l | grep -q "/Scripts/0_Every60Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/05 * * * * sh "/Scripts/0_Every60Min.sh"') | sudo crontab -)
