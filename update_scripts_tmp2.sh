#### Define Default Script Directory Location
DEFSCRDIR="/usr/local/bin"
#
#### Define Custom Script Directory Locations
SCRIPTDIR="/Scripts"
GITHUBDIR="${SCRIPTDIR}/github"
CUSTOMDIR="${SCRIPTDIR}/custom"
EXSTNGDIR="${SCRIPTDIR}/existing"
#
#### Create Directories, if they do not exist
sudo mkdir -p "${SCRIPTDIR}"
sudo mkdir -p "${GITHUBDIR}"
sudo mkdir -p "${EXSTNGDIR}"
sudo mkdir -p "${CUSTOMDIR}"
#
#### Download Latest Script from GitHub
sudo rm -r /"${GITHUBDIR}"_tmp > /dev/null 2>&1
sudo git clone https://github.com/AlgoClaw/Bash /"${GITHUBDIR}"_tmp > /dev/null 2>&1
sudo rm -r /"${GITHUBDIR}"_tmp/.git
sudo rm -f /"${GITHUBDIR}"_tmp/README.md
sudo cp -RTf /"${GITHUBDIR}"_tmp "${GITHUBDIR}"
sudo rm -r /"${GITHUBDIR}"_tmp
#
#### Unmount Anything Mapped to Default Script Directory
while [[ $(findmnt "${SCRIPTDIR}") != "" ]]; do sudo umount --all-targets -l "${SCRIPTDIR}"; done
while [[ $(findmnt "${DEFSCRDIR}") != "" ]]; do sudo umount --all-targets -l "${DEFSCRDIR}"; done
#
#### Copy Existing Contents of Default Script Directory to $EXSTNGDIR
sudo cp -RTn "${DEFSCRDIR}" "${EXSTNGDIR}"
#
#### Delete Contents of Default Script Directory
sudo rm "${DEFSCRDIR}"/* > /dev/null 2>&1
#
#### Merge All Subdirectories in $SCRIPTDIR to $DEFSCRDIR
sudo apt install -y mergerfs > /dev/null 2>&1
sudo mergerfs -o nonempty,allow_other "${GITHUBDIR}"/:"${CUSTOMDIR}"/:"${EXSTNGDIR}"/ "${DEFSCRDIR}"/
#
# Make All of the Files Linux Readable
sudo apt install -y dos2unix > /dev/null 2>&1
shopt -s globstar
sudo dos2unix "${SCRIPTDIR}"/**/* > /dev/null 2>&1
sudo chmod +x "${SCRIPTDIR}"/**/* > /dev/null 2>&1
#
sudo dos2unix "${DEFSCRDIR}"/**/* > /dev/null 2>&1
sudo chmod +x "${DEFSCRDIR}"/**/* > /dev/null 2>&1
