#!/bin/sh

# sudo bash "/Scripts/fcn_SyncThing_RevertLocal.sh" "abcdefghijk1234567890" "dirID"
# sudo bash "/Scripts/fcn_SyncThing_RevertLocal.sh" "abcdefghijk1234567890" "dirID" "8384"

apikey="${1}"
folder="${2}"
host=https://127.0.0.1:"${3:-8384}"

if ! curl -skH "X-API-Key: $apikey" "$host/rest/db/status?folder=$folder" | grep -q 'receiveOnlyChanged.*": [1-9]' ; then
exit 0
fi

curl -X POST -skH "X-API-Key: $apikey" "$host/rest/db/revert?folder=$folder"
