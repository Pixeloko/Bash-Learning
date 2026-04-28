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
            sudo sendemail -f "${FROM}" \
                -t "${TO}" \
                -u "ARP scan found new host" \
                -m "New host detected : ${host}" \
                -xu "${FROM}" \
                -xp "key" \
                -s "smtp.gmail.com:587" \
                -o tls=yes
        fi
    done
    sleep 10
done
```