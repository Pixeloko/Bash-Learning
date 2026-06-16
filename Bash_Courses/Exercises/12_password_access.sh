#!/bin/bash

if [[ ! -r "/etc/passwd" ]]; then
    echo "Cannot access /etc/passwd"
    exit 1 # indicates an error
fi

while read -r line; do
    account=$(echo ${line} | awk -F':' '{print $1}')
    dir=$(echo ${line} | awk -F':' '{print $6}')

if echo "${dir}" | grep -q "^/home"; then
    if [[ -r "${dir}" ]]; then
        echo "Home directory ${dir} for ${account} found AND accessible."
    else
        echo "Home directory ${dir} for ${account} found but NOT accessible."
    fi
fi
done < <(cat "/etc/passwd")