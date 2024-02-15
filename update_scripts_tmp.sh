#### Define Default Script Directory Location
DEFSCRDIR="/usr/local/bin"
#
#### Define Custom Script Directory Location
SCRIPTDIR="/Scripts"
#
#### Create Directories, if they do not exist
sudo mkdir -p "${SCRIPTDIR}"
#
#### Download Latest Scripts from GitHub
sudo apt install -y git
sudo rm -r /"${SCRIPTDIR}"_tmp > /dev/null 2>&1
sudo git clone https://github.com/AlgoClaw/Bash /"${SCRIPTDIR}"_tmp > /dev/null 2>&1
sudo rm -r /"${SCRIPTDIR}"_tmp/.git
sudo rm -f /"${SCRIPTDIR}"_tmp/README.md
sudo cp -RTf /"${SCRIPTDIR}"_tmp "${SCRIPTDIR}"
sudo rm -r /"${SCRIPTDIR}"_tmp
#
#### Unmount Anything Mapped to Custom and Default Script Directories
while [[ $(findmnt "${SCRIPTDIR}") != "" ]]; do sudo umount --all-targets -l "${SCRIPTDIR}"; done
#
while [[ $(findmnt "${DEFSCRDIR}") != "" ]]; do sudo umount --all-targets -l "${DEFSCRDIR}"; done
#
#### Copy Existing Contents of Default Script Directory to the custom script directory
sudo cp -RTn "${DEFSCRDIR}" "${SCRIPTDIR}"
#
#### Delete Contents of Default Script Directory
sudo rm "${DEFSCRDIR}"/* > /dev/null 2>&1
#
#### Merge All Subdirectories in $SCRIPTDIR to $DEFSCRDIR
sudo apt install -y mergerfs > /dev/null 2>&1
sudo mergerfs -o nonempty,allow_other "${EXSTNGDIR}"/ "${DEFSCRDIR}"/
#
# Make All of the Files Linux Readable
sudo apt install -y dos2unix > /dev/null 2>&1
shopt -s globstar
#
sudo dos2unix "${SCRIPTDIR}"/**/* > /dev/null 2>&1
sudo chmod +x "${SCRIPTDIR}"/**/* > /dev/null 2>&1
#
sudo dos2unix "${DEFSCRDIR}"/**/* > /dev/null 2>&1
sudo chmod +x "${DEFSCRDIR}"/**/* > /dev/null 2>&1
