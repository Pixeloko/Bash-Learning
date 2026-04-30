# required : file of hosts IP addr
#!/bin/bash

FILE="addresses-samples.txt"
REPORT=$(nmap -iL ${FILE} --open | grep "Nmap report for\|tcp open")

while read -r line; do
    if echo "${line}" | grep -q "report for "; then # -q for quiet mode
        ip=$(echo "${line}" | awk -F 'for ' '{print $2}') # separate the line at 'for ', take what comes after
    else
        port=$(echo "${line}" | grep open | awk -F '/' '{print $1}')
        file="port-${port}.txt"
        echo "${ip}" >> "${file}"
    fi
done <<< "${REPORT}"