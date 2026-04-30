## Create port-named files and subscribe IP having those open
required : file of hosts IP addr

```bash
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
```

## Listen to one IP address port + write data when openned
```bash
#!/bin/bash
LOG_FILE="watchdog.log"
ADDR="${1}"
PORT="${2}"

service_discovery(){
    local host
    local port
    host="${1}"
    port="${2}"
    nmap -sV "${host}" -p "${port}" >> "${LOG_FILE}"
}

while true; do
    port_scan=$(sudo docker run --network=host rustscan/rustscan:2.1.1 -a "${ADDR}" -p "${PORT}" -g) # use the host's network to reach the target 
    if [[ -n "${port_scan}" ]]; then
        echo "${ADDR} has its port ${PORT} open, proceeding to a service discovery..."
        service_discovery "${ADDR}" "${PORT}"
        echo "Wrote data in the file ${LOG_FILE}"
        break
    else
        echo "Nothing found yet, turning into sleep mode for 5 seconds..."
        sleep 5
    fi
done
```
instead of docker run... do rustscan if the tool is installed