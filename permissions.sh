#!/bin/bash

# Single Instance Lock
exec 9>"/tmp/$(basename "$0").lock" && flock -n 9 || { echo "Script is already running. Exiting."; exit 1; }

sudo chown -R 1000:1000 /tmp/
sudo chmod -R 777 /tmp/

sudo chown -R 1000:1000 /docker/
sudo chmod -R 777 /docker/

sudo chown -R 1000:1000 /scripts/
sudo chmod -R 777 /scripts/

# Future Removal

sudo chown -R 1000:1000 /Docker/
sudo chmod -R 777 /Docker/

sudo chown -R 1000:1000 /Scripts/
sudo chmod -R 777 /Scripts/
