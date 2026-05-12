#!/bin/bash

RESULT_FILE="${1}"

for ip in "$@"; do
    result=$(nuclei -u "${ip}" -silent -severity high,critical)
    if [[ -n "${result}" ]]; then
        while read line; do
            echo "Proceeding to an analysis of the nuclei scan for ${ip}..."
            template=$(echo "${line}" | awk '{print $1}')
            url=$(echo "${line}" | awk '{print $4}')
            echo "Writing the results in ${RESULT_FILE}..."
            echo "${template} - ${url}" >> "${RESULT_FILE}"
        done <<< "${result}"
    fi
done