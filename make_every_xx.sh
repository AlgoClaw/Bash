#!/bin/bash

# This File is NON-destructive.
# If modified versions of 0_EveryXX files already exist, this script will NOT overwrite those modifications.

# Create files (will not overwrite) and add '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every15Sec.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every30Sec.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every05Min.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every15Min.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every30Min.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every60Min.sh' '#!/bin/bash'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every12Hrs.sh' '#!/bin/bash'
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
sudo bash '/scripts/fcn_add_instance_lock.sh' '/scripts/0_Every12Hrs.sh'
sudo bash '/scripts/fcn_add_instance_lock.sh' '/scripts/0_Every02AM.sh'
sudo bash '/scripts/fcn_add_instance_lock.sh' '/scripts/0_Every03AM.sh'

# Schedule Files to Execute in crontab (if entries do not exist already)
sudo crontab -l | grep -q "/scripts/0_Every01Min.sh" || ( (sudo crontab -l 2>/dev/null; echo '*/1 * * * * /bin/bash "/scripts/0_Every01Min.sh"') | sudo crontab - )
sudo crontab -l | grep -q "/scripts/0_Every05Min.sh" || ( (sudo crontab -l 2>/dev/null; echo '*/5 * * * * /bin/bash "/scripts/0_Every05Min.sh"') | sudo crontab - )
sudo crontab -l | grep -q "/scripts/0_Every15Min.sh" || ( (sudo crontab -l 2>/dev/null; echo '*/15 * * * * /bin/bash "/scripts/0_Every15Min.sh"') | sudo crontab - )
sudo crontab -l | grep -q "/scripts/0_Every30Min.sh" || ( (sudo crontab -l 2>/dev/null; echo '*/30 * * * * /bin/bash "/scripts/0_Every30Min.sh"') | sudo crontab - )
sudo crontab -l | grep -q "/scripts/0_Every60Min.sh" || ( (sudo crontab -l 2>/dev/null; echo '0 * * * * /bin/bash "/scripts/0_Every60Min.sh"') | sudo crontab - )
sudo crontab -l | grep -q "/scripts/0_Every12Hrs.sh" || ( (sudo crontab -l 2>/dev/null; echo '0 */12 * * * /bin/bash "/scripts/0_Every12Hrs.sh"') | sudo crontab - )
sudo crontab -l | grep -q "/scripts/0_Every02AM.sh" || ( (sudo crontab -l 2>/dev/null; echo '0 2 * * * /bin/bash "/scripts/0_Every02AM.sh"') | sudo crontab - )
sudo crontab -l | grep -q "/scripts/0_Every03AM.sh" || ( (sudo crontab -l 2>/dev/null; echo '0 3 * * * /bin/bash "/scripts/0_Every03AM.sh"') | sudo crontab - )

# Add Example Commands to Each Script
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every01Min.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every05Min.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every15Min.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every15Sec.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every30Min.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every30Sec.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every60Min.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every12Hrs.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every02AM.sh' '# sudo bash "/scripts/script.sh"'
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every03AM.sh' '# sudo bash "/scripts/script.sh"'

# Add Commands to Select Scripts
sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every15Min.sh' 'sudo bash "/scripts/FinalizeScripts.sh"'
#sudo bash '/scripts/fcn_str2file.sh' '/scripts/0_Every60Min.sh' 'sudo bash "/scripts/Update_DDClient.sh"'

# Sub 1 Minute Script Stuff
TARGET_FILE="/scripts/0_Every01Min.sh"

read -r -d '' COMMAND_BLOCK <<'EOF'
sudo bash "/scripts/0_Every15Sec.sh"
sudo bash "/scripts/0_Every30Sec.sh"
sleep 15
sudo bash "/scripts/0_Every15Sec.sh"
sleep 15
sudo bash "/scripts/0_Every15Sec.sh"
sudo bash "/scripts/0_Every30Sec.sh"
sleep 15
sudo bash "/scripts/0_Every15Sec.sh"
EOF

# Read file content using sudo (to bypass permission limits)
FILE_CONTENT=$(sudo cat "$TARGET_FILE")

# Compare content using Bash pattern matching
if [[ "$FILE_CONTENT" != *"$COMMAND_BLOCK"* ]]; then
  # Append using sudo tee (to bypass permission limits)
  echo "" | sudo tee -a "$TARGET_FILE" > /dev/null
  echo "$COMMAND_BLOCK" | sudo tee -a "$TARGET_FILE" > /dev/null
fi
