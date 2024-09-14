#!/bin/bash

touch ~/.hushlogin # this hides all login messages

sudo pro config set apt_news=false

sudo systemctl mask apt-news.service
sudo systemctl mask esm-cache.service
