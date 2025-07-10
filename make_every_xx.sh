#!/bin/bash

# Create files (will not overwrite) and add '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every15Sec.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every30Sec.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every05Min.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every15Min.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every30Min.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every60Min.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every02AM.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every03AM.sh' '#!/bin/bash'

# Add Instance Lock to Each File
sudo bash '/scripts/fcn_add_instance_lock.sh' '/scripts/0_Every15Sec.sh'
sudo bash '/scripts/fcn_add_instance_lock.sh' '/scripts/0_Every30Sec.sh'
sudo bash '/scripts/fcn_add_instance_lock.sh' '/scripts/0_Every01Min.sh'
sudo bash '/scripts/fcn_add_instance_lock.sh' '/scripts/0_Every05Min.sh'
sudo bash '/scripts/fcn_add_instance_lock.sh' '/scripts/0_Every15Min.sh'
sudo bash '/scripts/fcn_add_instance_lock.sh' '/scripts/0_Every30Min.sh'
sudo bash '/scripts/fcn_add_instance_lock.sh' '/scripts/0_Every60Min.sh'
sudo bash '/scripts/fcn_add_instance_lock.sh' '/scripts/0_Every02AM.sh'
sudo bash '/scripts/fcn_add_instance_lock.sh' '/scripts/0_Every03AM.sh'

# Schedule Files to Execute in crontab (if entries do not exist already)
sudo crontab -l | grep -q "/scripts/0_Every01Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/01 * * * * sh "/scripts/0_Every01Min.sh"') | sudo crontab -)
sudo crontab -l | grep -q "/scripts/0_Every05Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/05 * * * * sh "/scripts/0_Every05Min.sh"') | sudo crontab -)
sudo crontab -l | grep -q "/scripts/0_Every15Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/15 * * * * sh "/scripts/0_Every15Min.sh"') | sudo crontab -)
sudo crontab -l | grep -q "/scripts/0_Every30Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/30 * * * * sh "/scripts/0_Every30Min.sh"') | sudo crontab -)
sudo crontab -l | grep -q "/scripts/0_Every60Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/60 * * * * sh "/scripts/0_Every60Min.sh"') | sudo crontab -)
sudo crontab -l | grep -q "/scripts/0_Every02AM.sh" || $((sudo crontab -l 2>/dev/null; echo '0000 2 * * * sh "/scripts/0_Every02AM.sh"') | sudo crontab -)
sudo crontab -l | grep -q "/scripts/0_Every03AM.sh" || $((sudo crontab -l 2>/dev/null; echo '0000 3 * * * sh "/scripts/0_Every03AM.sh"') | sudo crontab -)

# Add Example Commands to Each Script
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every02AM.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every03AM.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every05Min.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every15Min.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every15Sec.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every30Min.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every30Sec.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every60Min.sh' '# sudo bash "/scripts/script.sh"'

# Add Commands to Select Scripts
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every15Min.sh' 'sudo bash "/scripts/FinalizeScripts.sh"'

# Sub 1 Minute Script Stuff
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' 'sudo bash "/scripts/0_Every15Sec.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' 'sudo bash "/scripts/0_Every30Sec.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' 'sleep 15'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' 'sudo bash "/scripts/0_Every15Sec.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' 'sleep 15'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' 'sudo bash "/scripts/0_Every15Sec.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' 'sudo bash "/scripts/0_Every30Sec.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' 'sleep 15'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' 'sudo bash "/scripts/0_Every15Sec.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' 'sleep 15'
