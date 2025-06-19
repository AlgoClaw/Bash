#!/bin/bash

sudo rm -rf /tmp >/dev/null 2>&1
sudo rm -rf /boot.bak >/dev/null 2>&1
sudo rm -rf /var/tmp >/dev/null 2>&1
sudo docker system prune -f >/dev/null 2>&1
sudo rm -f /docker/Unifi/data/db/_tmp* >/dev/null 2>&1
sudo rm -f /var/log/auth.log.* >/dev/null 2>&1
sudo rm -f /var/mail/mail >/dev/null 2>&1

sudo mkdir -p /tmp >/dev/null 2>&1
sudo chown -R 1000:1000 /tmp/ >/dev/null 2>&1
sudo chmod -R 777 /tmp/ >/dev/null 2>&1
