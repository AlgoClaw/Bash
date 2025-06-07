#!/bin/bash

# sudo bash /scripts/map_conf_checker.sh

file="/docker/SWAG/nginx/map.conf" 

###

# Define "copy" filename (appending "_copy" to $file)
copy="${file%.*}_copy.${file##*.}"

# If the files are the same, exit.
sudo cmp --silent ${file} ${copy} && exit || \

# If the files are different, do the following:
# Copy $file to $copy, including overwriting.
sudo cp ${file} ${copy}

# Restart nginx
sudo docker exec SWAG nginx -s reload
