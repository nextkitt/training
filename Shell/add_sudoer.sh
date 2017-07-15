#!/bin/bash

username="$1"

if [[ "x$username" == "x" ]]; then
    echo -e "\"$username\" is invalid";
    exit 1
fi

awk -F':' '{print $1}' /etc/passwd  | grep -w "$username"  > /dev/null
if [[ $? -ne 0 ]]; then
    echo -e "\"$username\" is invalid";
    exit 1
fi

awk -F':' '{print $1}' /etc/sudoers | grep -w "$username"  > /dev/null
if [[ $? -eq 0 ]]; then
    echo  "$username  SUCCESS";
    exit 1
fi

cd /etc
chmod u+w sudoers
echo "$username        ALL=(ALL)        NOPASSWD: ALL" >> /etc/sudoers
chmod u-w sudoers

echo  "$username  SUCCESS";
