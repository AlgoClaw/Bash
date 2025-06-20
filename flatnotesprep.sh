#!/bin/bash

# Example
# DIR="/path/to/flatnotes/config/"
# TITLE="Notes"
# sudo bash /scripts/flatnotesprep.sh ${DIR} ${TITLE}

DEBUG=0
BEAUTIFY=0
TESTCONTAINER=0

####

DIR="${1}"
TITLE="${2}"

NAME=FN_TEMP_CON_AUTO_DELETED
IMAG=dullage/flatnotes

if [ "${DEBUG}" == "1" ]; then
    echo "DEBUG ON"
    DIR="/docker/fn_DONOTUSEFORPROD_dir"
fi

if [ "${DIR}" == "" ]; then
    exit
fi

if [ "${TITLE}" == "" ]; then
    TITLE="Notes"
fi

# Add '/' after DIR
DIR="${DIR%/}/"

################
# Remove "/app-client-dist" Directory
sudo rm -rf "${DIR}app-client-dist"

################
# Make Directory
sudo mkdir -p "${DIR}"

################
# Fix permissions
sudo chown -R 1000:1000 "${DIR}"
sudo chmod -R 777 "${DIR}"

################
# Pull, stop, and remove
sudo docker pull ${IMAG}
sudo docker stop ${NAME}
sudo docker rm ${NAME}

################
# Start container with host directory "/app-client-dist" mapped to container directory "/app-client-dist_temp"
sudo docker run -dit \
--name ${NAME} \
--restart unless-stopped \
-v ${DIR}app-client-dist:/app-client-dist_temp \
-e FLATNOTES_AUTH_TYPE=none \
${IMAG}

################
# Fix permissions
sudo chown -R 1000:1000 "${DIR}"
sudo chmod -R 777 "${DIR}"

################
# Copy contents of container directory "/app/client/dist/." to container directory "/app-client-dist_temp"
sleep 2
docker exec -it ${NAME} cp -r /app/client/dist/. /app-client-dist_temp
sleep 2

################
# Fix permissions
sudo chown -R 1000:1000 "${DIR}"
sudo chmod -R 777 "${DIR}"

################
# Stop and Remove Container
sudo docker stop ${NAME}
sudo docker rm ${NAME}

###############################
###### UI MODIFICATIONS #######
###############################

###############
# Remove Icons:
find "${DIR}app-client-dist/" -type f -name "*.png" -exec rm {} \;
find "${DIR}app-client-dist/" -type f -name "*.ico" -exec rm {} \;
find "${DIR}app-client-dist/" -type f -name "*.svg" -exec rm {} \;

###############
# Rename Title:

FIND=flatnotes
RPLC="${TITLE}"
find "${DIR}app-client-dist/" -type f -name "index*" | xargs sed -i "s|${FIND}|${RPLC}|"

################
# Reduce Header Spacing:
# for some reason, this has to be done twice, otherwise one of the "3rem" instances remains.

FIND='margin-bottom:3rem'
RPLC='margin-bottom:0'
find "${DIR}app-client-dist/" -type f -name "index*.css" | xargs sed -i "s|${FIND}|${RPLC}|"
find "${DIR}app-client-dist/" -type f -name "index*.css" | xargs sed -i "s|${FIND}|${RPLC}|"

################
# Change Width:

FIND='max-width:1000px'
RPLC='max-width:80vw'
find "${DIR}app-client-dist/" -type f -name "index*.css" | xargs sed -i "s|${FIND}|${RPLC}|"

################
# Remove Header "f_" logo and "flatnotes" text (reduce width to "0")

FIND='width:"149"'
RPLC='width:"0"'
find "${DIR}app-client-dist/" -type f -name "index*.js" | xargs sed -i "s|${FIND}|${RPLC}|"

FIND='width:"36"'
RPLC='width:"0"'
find "${DIR}app-client-dist/" -type f -name "index*.js" | xargs sed -i "s|${FIND}|${RPLC}|"

###############
# Change search result item height

FIND='.mb-4{margin-bottom:1rem}'
RPLC='.mb-4{margin-bottom:0}'
find "${DIR}app-client-dist/" -type f -name "index*.css" | xargs sed -i "s|${FIND}|${RPLC}|"

###############
# Remove tags ("#search") from search results

FIND='.text-xs{font-size:.75rem;line-height:1rem}'
RPLC='.text-xs{font-size:0;line-height:1rem}'
find "${DIR}app-client-dist/" -type f -name "index*.css" | xargs sed -i "s|${FIND}|${RPLC}|"

###############
# Justify Text

FIND='.pb-4{padding-bottom:1rem}'
RPLC='.pb-4{padding-bottom:1rem;text-align:justify}'
find "${DIR}app-client-dist/" -type f -name "index*.css" | xargs sed -i "s|${FIND}|${RPLC}|"

###############
# For standard paragraphs, add spacing *before* (1rem), remove spacing *after* (0)

FIND='margin:0 0 1rem'
RPLC='margin:1rem 0 0'
find "${DIR}app-client-dist/" -type f -name "Note*.css" | xargs sed -i "s|${FIND}|${RPLC}|"

###############
# For bullet point lists, remove spacing before (0), increase spacing after (1rem)

FIND='f}.toastui-editor-contents ul,'
RPLC='f}.toastui-editor-contents ul{display:block;list-style-type:none;padding-left:24px;margin:0 0 1rem;color:#222}'
find "${DIR}app-client-dist/" -type f -name "Note*.css" | xargs sed -i "s|${FIND}|${RPLC}|"

###############
# For numbered lists, remove spacing before (0), increase spacing after (1rem)

FIND='.toastui-editor-contents ol,.toastui-editor-contents dir{d'
RPLC='.toastui-editor-contents ol{display:block;list-style-type:none;padding-left:24px;margin:0 0 1rem;color:#222}.toastui-editor-contents dir{d'
find "${DIR}app-client-dist/" -type f -name "Note*.css" | xargs sed -i "s|${FIND}|${RPLC}|"

###############
# Beautify

if [ "${BEAUTIFY}" == "1" ]; then

    sudo apt install -y jsbeautifier
    sudo apt install -y css-beautify
    
    find "${DIR}app-client-dist/" -type f -name "*.js" -exec js-beautify -r {} \;
    find "${DIR}app-client-dist/" -type f -name "*.css" -exec css-beautify -r {} \;
    
fi

#################################################
###### TEST OUTPUT (IF TESTCONTAINER = 1) #######
#################################################

if [ "${TESTCONTAINER}" == "1" ]; then

    sudo docker run -dit \
    --name ${NAME} \
    --restart unless-stopped \
    -e FLATNOTES_PATH=/notes \
    -v ${DIR}notes/:/notes/ \
    -v ${DIR}app-client-dist/:/app/client/dist/ \
    -e FLATNOTES_AUTH_TYPE=none \
    -p 12345:8080 \
    ${IMAG}

fi
