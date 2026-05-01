# With netcat 
FILE_OF_ADDR="${1}"
PORT="${2}"

if [[ ! -f "${FILE_OF_ADDR}" ]]; then
    echo "Enter a valid file."
    exit 1
fi
if [[ $# -ne 2 ]]; then
    echo "${0} need two arguments : file and port."
    exit 1
fi
if [[ ! "${PORT}" =~ ^[0-9]+$ ]]; then
    echo "${PORT} is not a valid port."
    exit 1
fi

while read -r ip; do
    echo "Proceeding to a banner grab on port ${PORT}..."
    result=$(nc -v "${ip}" -w 1 "${PORT}" 2>&1)
    if [[ -n "${result}" ]]; then
        echo "Banner : ${result}"
done < "${FILE_OF_ADDR}"

# Whith curl
DEFAULT="80"

read -r -p "Enter an ip target : " ip
read -r -p "Enter a port target (if different than 80) : " port

# do same ip check as with netcat
if [[ -z "${port}" ]]; then
    port="${DEFAULT}"
fi

echo "proceeding to a banner grab on port ${port}..."
result=$(curl --head "${ip}":"${port}" | grep Server | awk -F' :' '{print $2}')
if [[ -n "${result}" ]]; then
    echo "Banner : ${result}" 
fi