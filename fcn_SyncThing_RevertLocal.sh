#!/bin/sh

# sudo bash "/Scripts/fcn_SyncThing_RevertLocal.sh" "8384" "abcdefghijk1234567890" "dirID"

host=https://localhost:"${1}"
apikey="${2}"
folder="${3}"

if ! curl -skH "X-API-Key: $apikey" "$host/rest/db/status?folder=$folder" | grep -q 'receiveOnlyChanged.*": [1-9]' ; then
exit 0
fi

curl -X POST -skH "X-API-Key: $apikey" "$host/rest/db/revert?folder=$folder"
