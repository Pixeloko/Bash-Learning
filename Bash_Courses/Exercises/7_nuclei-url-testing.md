## Test nuclei and save to a file
```
#!/bin/bash

RESULT_FILE="${1}"
read -p "Enter a target url" target

echo "Proceeding to nuclei scan for ${target}..."
result=$(nuclei -u "${target}" -silent -severity high,critical jq '.template + " - " + .matched-at')
if [[ -n "${result}" ]]; then
    echo "Results found, writing in ${RESULT_FILE}..."
    echo "${result}" >> "${RESULT_FILE}"
fi
```  

## Automated vulnerability finder
Made to discover ftp vulnerailities on an address with rustscan and nuclei
```bash
TARGET="${1}"
FILE="result.html"

if [[ -z "${TARGET}" ]]; then
    echo "Enter a target's address and a tag for nuclei scan"
    exit 1
fi

echo "Proceeding to the port scan of ${TARGET}..."
port_scan=$(rustscan -a "${TARGET}" 21)
if [[ -n "${port_scan}" ]]; then
    echo "Proceeding to the ftp-vulnerabilities scan for ${TARGET}..."
    ftp_scan=$(nuclei -tags ftp -u "${TARGET}")
    if [[ -n "${ftp_scan}" ]]; then
        echo "Proceeding to the ultimate nmap scan on ${TARGET}..."
        nmap_scan=$(nmap --scripts=ftp-anon "${TARGET}" -oN temp.txt)
        echo "Writing results..."
        while read -r line; do
        if echo "${line}" | grep -q "report for"; then
            ip=$(echo "${line}" | awk -F'report for' '{print $2}')
        fi  
        if echo "${line}" | grep -q "open"; then
            port=$(echo "${line}" | awk -F'/tcp open' '{print $1}')
        fi  
        if echo "${line}" | grep -q "Starting Nmap"; then
            timestamp=$(echo "${line}" | awk -F'at ' '{print $2}')
        fi  
        done < temp.txt # input redirection

        echo -e "<html><h3>FTP vulnerabilities discovery results</h3>\
        <p>Vulnerability description</p>
        <table><tr><th>IP</th><th>PORT</th><th>TOOL</th><th>TIME</th></tr>\
        <tr><td>${ip}</td><td>${port}</td><td>nuclei</td><td>${timestamp}</td></tr>\
        </table></html>" >> "${FILE}"
    fi
fi
    echo "All scans have been ran, find resulted table in ${FILE}..." 
```