#!/bin/bash

TARGET = ("$@")

if [[ ${#TARGET[@]} -eq 0 ]]; then
    echo "One or more IP addresses are required."
    exit 1
fi

for target in "${TARGET[$@]}"; do
    while read -r port; do 
        if timeout 1 nc -i 1 "${target}" -v "${port}" 2>&1 | grep -q "Connected to"; then
            echo "IP: ${target}"
            echo "PORT: ${port}"
            echo "SERVICE: $(grep -w "${port}/tcp" /etc/services | awk '{print $1}')"
        fi
    done < < (grep "/tcp" /etc/services | awk '{print $2}' | tr -d '/tcp')
done 