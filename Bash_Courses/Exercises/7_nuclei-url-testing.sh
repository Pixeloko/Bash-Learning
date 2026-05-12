#!/bin/bash

RESULT_FILE="${1}"
read -p "Enter a target url" target

echo "Proceeding to nuclei scan for ${target}..."
result=$(nuclei -u "${target}" -silent -severity high,critical jq '.template + " - " + .matched-at')
if [[ -n "${result}" ]]; then
    echo "Results found, writing in ${RESULT_FILE}..."
    echo "${result}" >> "${RESULT_FILE}"
fi
    