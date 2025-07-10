#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $(basename "$0") <path_to_script>"
  exit 1
else
  TARGET_FILE="$1"
fi

if [ ! -f "$TARGET_FILE" ]; then
  #echo "Error: File not found at '$TARGET_FILE'"
  exit 1
fi

LOCK_CODE='exec 9>"/tmp/$(basename "$0").lock"'

if grep -qF "$LOCK_CODE" "$TARGET_FILE"; then
  #echo "Lock already exists in '$TARGET_FILE'. No changes made."
  exit 0
fi

TEMP_FILE=$(mktemp)
{
  head -n 1 "$TARGET_FILE"
  echo
  echo "# Single Instance Lock"
  echo 'exec 9>"/tmp/$(basename "$0").lock" && flock -n 9 || { echo "Script is already running. Exiting."; exit 1; }'
  tail -n +2 "$TARGET_FILE"
} > "$TEMP_FILE"

if [ $? -eq 0 ]; then
  mv "$TEMP_FILE" "$TARGET_FILE"
  chmod --reference="$TARGET_FILE" "$TEMP_FILE" 2>/dev/null && mv "$TEMP_FILE" "$TARGET_FILE"
  chmod +x "$TARGET_FILE"
  #echo "Successfully added lock to '$TARGET_FILE'."
else
  rm -f "$TEMP_FILE"
  echo "Error: Failed to create temporary file for '$TARGET_FILE'."
  exit 1
fi
