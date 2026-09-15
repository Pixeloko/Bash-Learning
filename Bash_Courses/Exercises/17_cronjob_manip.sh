#!/bin/bash

# 1 modify sudo configuration to grand new user permissions
useradd -m user-test # create a home directory for user
echo "user-test ALL=(ALL:ALL)" >> /etc/sudoers.d/add-sudo*

# 2 grant permission over /var/log
setfacl -m u:user-test:rwx /var/log

# 3 Copy home content of another user
mkdir /home/user-test/found
cp -r /home/jmartinez/. /home/user-test/found   
chmod u+r /home/user-test/found 