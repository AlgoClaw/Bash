#!/bin/bash

# sudo bash fcn_sync1way_versioning.sh "/path/to/source" "/path/to/destination"

DIR1=${1%/}/
DIR2=${2%/}/

datetimefile=$(date +%F_%H-%M-%S)
updates_file="updates"

#### Install Dependencies
sudo DEBIAN_FRONTEND=noninteractive apt install -y rsync
sudo pacman -Sy --noconfirm rsync

#### Generate List of Files to Update
sudo rsync --append-verify --partial --archive --relative --update --itemize-changes --dry-run "${DIR1}./" "${DIR2}" > "${updates_file}"

#### Remove Lines That Include "sending incremental file list"
sed -i '/^sending incremental file list/d' "${updates_file}"

#### Remove Lines That Include "f+++++++++"
sed -i '/^>f+++++++++/d' "${updates_file}"

#### Remove Lines That Ending With "/" (directories)
sed -i '/\/$/d' "${updates_file}"

#### Remove Everything Up to (and including) First Space in Each Line
sed -i 's/[^ ]* //' "${updates_file}"

#### "${updates_file}" should now be an easily readable list of files that would be overwritten

#### Copy "${updates_file}"
cp "${updates_file}" "${updates_file}_datestring”

#### Add Date String to List of Files
#sed -i "s/$/_${datetimefile}/" "${updates_file}_datestring”

#### Rename Existing Files in Backup Location
while IFS= read -r file; do mv "${DIR2}${file}" "${DIR2}${file}_${datetimefile}"; done < "${updates_file}"

#### Copy Over Files
sudo rsync --append-verify --partial --archive --relative --update "${DIR1}./" "${DIR2}"
