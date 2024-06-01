#!/bin/bash

# sudo bash fcn_sync1way_versioning.sh "/path/to/source" "/path/to/destination"

DIR1=${1%/}/
DIR2=${2%/}/

sudo mkdir -p "${DIR1}"
sudo mkdir -p "${DIR2}"

updates_file="onewaysyncupdatefile.txt"

#### cleanup
sudo rm -f "${updates_file}"

#### install dependencies
sudo DEBIAN_FRONTEND=noninteractive apt install -y rsync
sudo pacman -Sy --noconfirm rsync

#### generate list of files to update (files on destination that would be modified/overwritten)
sudo rsync --append-verify --partial --archive --relative --update --itemize-changes --dry-run "${DIR1}./" "${DIR2}" > "${updates_file}"

#### remove lines that include "sending incremental file list"
sed -i '/^sending incremental file list/d' "${updates_file}"

#### remove lines that include "f+++++++++"
sed -i '/^>f+++++++++/d' "${updates_file}"

#### remove lines that end with "/" (directories)
sed -i '/\/$/d' "${updates_file}"

#### remove everything up to (and including) first space in each line
sed -i 's/[^ ]* //' "${updates_file}"

#### "${updates_file}" should now be an easily readable list of files that would be overwritten on the destination

#### rename files, on the destination, that would be overwritten
while IFS= read -r file
do
	unixdatetime=$(date -r "${DIR2}${file}" +%s)
	oldfilename="${DIR2}${file}"
	newfilename="${DIR2}${file}_${unixdatetime}"
 
	mv "${oldfilename}" "${newfilename}"
done < "${updates_file}"

#### copy files from source to destination
sudo rsync --append-verify --partial --archive --relative --update "${DIR1}./" "${DIR2}"

#### cleanup
sudo rm -f "${updates_file}"
