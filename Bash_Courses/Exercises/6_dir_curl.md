## Scan file of urls and download their repertories/files
```bash
#!/bin/bash

FILE="${1}"
OUTPUT="${2}"

if [[ ! -s "${FILE}" ]]; then
    echo "Must be an existing file"
    exit 1
fi

if [[ -z "${OUTPUT}" ]];then
    OUTPUT="curl_result"
fi


while read -r line; do
    url=$(echo $line | xargs) # trim space
    if [[ -n "${url}" ]]; then
        echo "Scanning directories for ${url}..."
        if curl -L -s "${url}" | grep -e "Index of /" -e "\[PARENTDIR\]"; then
            echo "Found directory, begin download and saving to ${OUTPUT} directory ..."
            mkdir -p "${OUTPUT}"
            wget -q -r -np -R "index.html*" -P "${url}" "${OUTPUT}"
            # -r recursive (all files and children dir) -np no ascending to parent, -R reject
        fi
    fi
done < "${FILE}"
```

## Find directions and print returned HTTP code
```bash
TARGET="<ip>"
FILE="robots.txt" # given directions for web crawlers

while read -r line; do
    path=$(echo "${line}" | awk -F'Disallow: ' '{print $2}')
    if [[ -n "${path}" ]]; then
        url="${TARGET}/${path}"
        status=$(curl -s -o /dev/null -w "%{http_code}" "${url}")
        echo "URL : ${path} --> CODE = ${status}"
    fi
done < <(curl -s "${TARGET}/${FILE}") # space between < because not here document
```