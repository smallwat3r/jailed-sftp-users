#!/bin/bash
# Creates a new user to access a jailed SFTP.

create_folder_user() {
    mkdir $1
    chown $2:$2 $1
    chmod 755 $1
}

set -e
USER=$1
PASSW=$2

# Check if user exists already
getent passwd $USER >/dev/null
if [ getent passwd $USER ] >/dev/null; then
    printf "Error, user already exists.\n"
    exit 1
fi

# User creation
adduser --quiet --disabled-password --shell /bin/bash --home /home/$USER --gecos "User" $USER
echo "$USER:$PASSW" | chpasswd
usermod -g sftpusers $USER

# User access
chown root:$USER /home/$USER
chmod 755 /home/$USER

# Create dir
create_folder_user "/home/$USER/data" $USER

printf "SFTP user $USER created successfully\n."
exit 0
