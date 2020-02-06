#!/bin/bash
# Delete a user from sftp access
set -e
USER=$1

# Check if user exists
getent passwd $USER > /dev/null
if [ $? -eq 0 ]; then
    # Delete user (including data)
    rm -rf "/home/$USER"
    userdel $USER
    groupdel $USER

    printf "The user $USER has been removed.\n"
    exit 0
else
    printf "Error, the user doesn't exists\n"
    exit 1
fi
