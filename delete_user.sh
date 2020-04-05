# #!/usr/bin/env bash
# Delete a user from sftp access
set -e
_user = $1

_check_exists() {
  id -u $1 &>/dev/null || {
    printf "Error, user $1 doesn't exists\n" >&2
    exit 1
  }
}

_delete_user() {
  rm -rf "/home/$1"
  userdel $1
  groupdel $1
}

_check_exists $_user
_delete_user $_user
printf "User $_user has been removed.\n"
exit 0
