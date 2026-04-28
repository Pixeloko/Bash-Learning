## Subdomains
Generate list of subdomains for a domain. Wordlist of subdomains required
```bash
DOMAIN="${1}"
WORDLIST="${1}"

while read -r subdomain; do
    echo "${subdomain}.${DOMAIN}"
done < "${FILE}" # first executed to open the file
```
Execute with `./script.sh domain.com ~/wordlist`

## Host
Find hosts (in up status) with a file of generated [addresses](/Bash_Courses/Loop.md#generate-a-list-of-ip-addresses)
```bash
FILE="${1}"

while read -r host; do
	if ping -c 1 -W 1 -w 1 "${host}" &> /dev/null;then
		echo "${host} is up"
	fi
done < "${FILE}" 
```
or do `nmap -sn <network-address/cidr>` (-sn = ping sweep)

find MAC with ARP-SCAN 
```bash
sudo arp-scan <ip-addr|net-ip/cidr> -I <network-interface> # for arp-scan to send packet through this int
sudo arp-scan -I <int> $(cat <list-addr-to-test.txt>) # scan based on a file
```