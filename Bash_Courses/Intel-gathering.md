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
## nuclei
[find official templates](https://github.com/projectdiscovery/nuclei-templates/tree/main)

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
nmap -0 <ip> # operating system detection
nmap --script=<name-script> <ip-targetted> # list found at /usr/share/nmap/scripts
```

## netcat
`nc -zv <ip-addr> <first-port>-<end-of-range-ports>`
-z to not send data, -v for verbose

banner grab 
```bash
nc <ip> -v port 
curl --head <ip>:<port> # use curl for HTTP/HTTPS ports (more effetive and rich)
nikto -host <ip> # banner grab and security check and find dir/file
```

## curl
```bash
curl -w "<format>" url # get info on the response
```
format :
* `%{http_code}`
* `%{size_download}`
* `%{speed_download}`
* `%{time_total}`
We can also use a file for format
```bash
curl -w @format.txt -o /dev/null -s url # -o output -s silence
curl -H <metadata> <url> # to specify (ex: Content type)
```

## whatweb
```bash
whatweb <ip> <ports> --log-json=<localization> --quiet | jq # services used on the we server, ouput in json format
jq '[0].key.key.[0]' # navigation key/value with jq
```

# File system
## dirsearch 
```bash
dirsearch -u http://<ip> # more efficient than nikto to find hidden dir/file (brute-forcing)
```
if found .git -> download repositories
```bash
gitjacker http://<ip>/path/file.git -o <new-dir> 
```
cd to the new directory and `git log` to show commit info (author name and email)
if multiple contributors/commits : 
```bash
git log --pretty-format="%an%ae" # an=author's name ae=email
```

# Network
```bash
hostname -I # os ip
```