#!/bin/bash

ID="example@mail.com"

if ! gpg --list-keys | grep uid | grep -q "${ID}"; then
    echo "Could not identify keys for ${ID}."
    exit 1
fi

while read -r passphrase; do
    echo "Bruteforcing with ${passphrase}..."
    if echo "${passphrase}" | gpg --batch \
                                  --yes \
                                  --pinentry-mode loopback \
                                  --passphrase-fd 0 \
                                  --output private.pgp \
                                  --armor \
                                  --export-secret-key "${ID}"; then 
        # --batch non interactive mode
        # --yes to all questions
        # --pinentry-mode uses stdin for passphrase entry
        # --passphrase-fd reads from stdin
        echo "Passphrase is : ${passphrase}"
        echo "Private key now located at private.pgp"
        exit 0
    fi
done < passphrase.txt # find a passphrase.txt to test, and run