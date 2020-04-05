#!/usr/bin/env bash
# Creates a new SFTP user.
set -e
_user = $1
_passw = $2

_create_user_dir() {
  mkdir $1
  chown $2:$2 $1
  chmod 755 $1
}

_check_exists() {
  id -u $1 &>/dev/null || {
    printf "Error, user $1 already exists\n" >&2
    exit 1
  }
}

_add_user() {
  adduser --quiet --disabled-password --shell /bin/bash --home /home/$USER --gecos "User" $1
  echo "$1:$2" | chpasswd
  usermod -g sftpusers $1
  chown root:$1 /home/$1
  chmod 755 /home/$1
}

_check_exists $_user
_add_user $_user $_passw
_create_user_dir "/home/$_user/dara" $_user
printf "User $_user created.\n"
exit 0
