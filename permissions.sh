#!/bin/bash

# Single Instance Lock
exec 9>"/tmp/$(basename "$0").lock" && flock -n 9 || { echo "Script is already running. Exiting."; exit 1; }

sudo chown -R 1000:1000 /tmp/ >/dev/null 2>&1
sudo chmod -R 777 /tmp/ >/dev/null 2>&1

sudo chown -R 1000:1000 /docker/ >/dev/null 2>&1
sudo chmod -R 777 /docker/ >/dev/null 2>&1

sudo chown -R 1000:1000 /scripts/ >/dev/null 2>&1
sudo chmod -R 777 /scripts/ >/dev/null 2>&1

# Future Removal

sudo chown -R 1000:1000 /Docker/ >/dev/null 2>&1
sudo chmod -R 777 /Docker/ >/dev/null 2>&1

sudo chown -R 1000:1000 /Scripts/ >/dev/null 2>&1
sudo chmod -R 777 /Scripts/ >/dev/null 2>&1
