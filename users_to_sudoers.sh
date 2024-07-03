#!/bin/bash

sudo bash fcn_usr2sudoers.sh root
sudo bash fcn_usr2sudoers.sh "${SUDO_USER}"
sudo bash fcn_usr2sudoers.sh "${USER}"
