# Host scan and email alert 
## Recap
1. Set up [smtp](/Bash_Courses/bash-scripting.md#send-email-in-the-terminal-with-sendemail)
2. Find the target network and its interface 
3. Execute the following script
```bash
#!/bin/bash

INTERFACE="en0"
NETWORK="net-addr/cidr"
KNOWN_HOSTS="addresses-samples.txt"
FROM="sender@gmail.com"
TO="receiver"

while true; do
    echo "performing an arp scan against ${NETWORK}"

    sudo arp-scan -I ${INTERFACE} ${NETWORK} | while read -r line; do # read the line of the scan result
    	host=$(echo "${line}" | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}') # -o = only the searched extended regex (-E)
        if ! grep -q "${host}" "${KNOWN_HOSTS}"; then # quiet grep
            echo "Found a new host : ${host}."
            echo "${host}" >> "${KNOWN_HOSTS}"
            sudo sendemail -f "${FROM}" \ # can use another method (see below)
                -t "${TO}" \
                -u "ARP scan found new host" \
                -m "New host detected : ${host}" \
                -xu "${FROM}" \
                -xp "key" \
                -s "smtp.gmail.com:587" \
                -o tls=yes
        fi
    done
    sleep 10 # interval between each scan
done
```
Now that we know our host IP, let's find their [open ports](./3_scan_new_ports.sh)

send Discord notification
```bash
curl -H "Content-Type : application/json" \ # -H = Header of HTTP request
-X POST \
-d "{\"content\":\"New host found : ${host}\"}" \
"<discord-server-webhook-url>"
```

## Banner grabbing
Scan IP on a given port and grab the banner of the service on that port.
required : port + a list of host IP addresses
```bash
#!/bin/bash
LIST="${1}"
PORT="${2}"

# condition before executing
if [[ $# -ne 2 ]]; then # argument input
    echo "${0} need two arguments <list> and <port>"
    exit 1
fi
if [[ ! -f ${LIST} ]]; then
    echo "${LIST} has not been found"
    exit 1
fi
if [[ ! "${PORT}" =~ ^[0-9]+$ ]]; then
    echo "${PORT} is not a valid port"
    exit 1
fi

# start the banner grabbing
while read -r ip; do
    echo "Processing to a port scanning on address ${ip}"
    result=$(nc -v "${ip}" -w 1 "${PORT}" 2>/dev/null)
    if [[ -n "${result}" ]]; then
        echo "==========="
        echo "IP : ${ip}"
        echo "Banner : ${result}"
        echo "==========="
    fi
done < "${LIST}"
```