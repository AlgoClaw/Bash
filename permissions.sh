#!/bin/bash

# Single Instance Lock
exec 9>"/tmp/$(basename "$0").lock" && flock -n 9 || { echo "Script is already running. Exiting."; exit 1; }

# Define DIRECTORIES Array
DIRECTORIES="/tmp/ /docker/ /scripts/ /Docker/ /Scripts/"

# Iterate Through and Execute
for dir in $DIRECTORIES; do
    sudo /usr/bin/chmod -R 777 "$dir" >/dev/null 2>&1
    sudo /usr/bin/chown -R 1000:1000 "$dir" >/dev/null 2>&1
done
