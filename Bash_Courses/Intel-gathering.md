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

# Tools
## arp-scan
find MAC with ARP-SCAN 
```bash
sudo arp-scan <ip-addr|net-ip/cidr> -I <network-interface> # for arp-scan to send packet through this int
sudo arp-scan -I <int> $(cat <list-addr-to-test.txt>) # scan based on a file
```

## rustscan
faster than nmap. Run it first to find which addresses of the network have open ports, then target them with nmap.
```bash
docker pull rustscan/rustscan:2.2.1
rustscan -a <network-ip/cidr> -g # -g for minimalist output
rustscan -a <network-ip/cidr> -r 1-1024 # range of ports to scan
```

## nmap
```bash
nmap -sV -p <port>,<port> <ip-adrr> #-sV to find version of services used in each ports
nmap <ip|website> <another> # fin MAC and open ports, 
nmap -sV -iL <file-of-addresses> --open | grep open --exclude <ip-address>
```

## netcat
`nc -zv <ip-addr> <first-port>-<end-of-range-ports>`
-z to not send data, -v for verbose


