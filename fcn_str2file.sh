#!/bin/bash

# Usage example:
# fcn_str2file.sh "/path/to/file" "string to append"

FILE="${1}"
STR="${2}"

# 1. Validation: Exit if variables are empty
if [ -z "${FILE}" ] || [ -z "${STR}" ]; then
    echo "Error: Missing file or string arguments."
    exit 1
fi

# 2. Ensure File Exists
# using 'test -f' is cleaner than 'ls', but we need sudo for root-owned dirs
if ! sudo test -f "${FILE}"; then
    sudo touch "${FILE}"
fi

# 3. Idempotency Check
# grep -F: Treat string as literal (ignoring regex special chars like . * [ ] )
# grep -x: Match the entire line exactly
# grep -q: Quiet mode (don't output the line, just return true/false)
if sudo grep -Fxq "${STR}" "${FILE}"; then
    # String already exists; do nothing
    :
else
    # String is missing; append it
    echo "${STR}" | sudo tee -a "${FILE}" > /dev/null
    # echo "Added entry to ${FILE}" # Optional feedback
fi
