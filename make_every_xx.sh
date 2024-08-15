#!/bin/bash

# Create files (will not overwrite) and add '#!/bin/bash'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every15Sec.sh' '#!/bin/bash'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every30Sec.sh' '#!/bin/bash'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every01Min.sh' '#!/bin/bash'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every05Min.sh' '#!/bin/bash'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every15Min.sh' '#!/bin/bash'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every30Min.sh' '#!/bin/bash'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every60Min.sh' '#!/bin/bash'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every02AM.sh' '#!/bin/bash'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every03AM.sh' '#!/bin/bash'

# Schedule Files to Execute in crontab (if entries do not exist already)
sudo crontab -l | grep -q "/Scripts/0_Every01Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/01 * * * * sh "/Scripts/0_Every01Min.sh"') | sudo crontab -)
sudo crontab -l | grep -q "/Scripts/0_Every05Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/05 * * * * sh "/Scripts/0_Every05Min.sh"') | sudo crontab -)
sudo crontab -l | grep -q "/Scripts/0_Every15Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/15 * * * * sh "/Scripts/0_Every15Min.sh"') | sudo crontab -)
sudo crontab -l | grep -q "/Scripts/0_Every30Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/30 * * * * sh "/Scripts/0_Every30Min.sh"') | sudo crontab -)
sudo crontab -l | grep -q "/Scripts/0_Every60Min.sh" || $((sudo crontab -l 2>/dev/null; echo '*/60 * * * * sh "/Scripts/0_Every60Min.sh"') | sudo crontab -)
sudo crontab -l | grep -q "/Scripts/0_Every02AM.sh" || $((sudo crontab -l 2>/dev/null; echo '0000 2 * * * sh "/Scripts/0_Every02AM.sh"') | sudo crontab -)
sudo crontab -l | grep -q "/Scripts/0_Every03AM.sh" || $((sudo crontab -l 2>/dev/null; echo '0000 3 * * * sh "/Scripts/0_Every03AM.sh"') | sudo crontab -)

# Add Example Commands to Each Script (1 minute and above)
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every01Min.sh' '# sudo bash "/Scripts/script.sh"'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every05Min.sh' '# sudo bash "/Scripts/script.sh"'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every15Min.sh' '# sudo bash "/Scripts/script.sh"'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every30Min.sh' '# sudo bash "/Scripts/script.sh"'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every60Min.sh' '# sudo bash "/Scripts/script.sh"'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every02AM.sh' '# sudo bash "/Scripts/script.sh"'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every03AM.sh' '# sudo bash "/Scripts/script.sh"'

# Add Commands to Select Scripts
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every15Min.sh' 'sudo bash "/Scripts/FinalizeScripts.sh"'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every60Min.sh' 'sudo bash "/Scripts/Update_DDClient.sh"'

# Sub 1 Minute Script Stuff
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every01Min.sh' '	'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every01Min.sh' 'for (( i=1; i<=4; i++ )); do'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every01Min.sh' '	sudo bash "/Scripts/0_Every15Sec.sh"'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every01Min.sh' '	if [ i = 1 ] || [ i = 3 ]; then'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every01Min.sh' '		sudo bash "/Scripts/0_Every30Sec.sh"'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every01Min.sh' '	fi'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every01Min.sh' '	sleep 15'
sudo bash '/Scripts/fcn_str2file.sh' '/Scripts/0_Every01Min.sh' 'done'
