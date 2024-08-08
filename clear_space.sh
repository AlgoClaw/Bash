#!/bin/bash

sudo rm -r /tmp
sudo rm -r /boot.bak
sudo rm -r /var/tmp
sudo docker system prune -f
sudo rm -r /Docker/Unifi/data/db/_tmp*
