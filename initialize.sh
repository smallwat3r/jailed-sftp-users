#!/bin/bash
# Author: Matthieu Petiteau <mpetiteau.pro@gmail.com>
# Initialize server to allow SSH access to jailed users from specific group.
set -e

# Creates a `sftpusers` group if doesn't exist yet.
if ! grep -q sftpusers /etc/group; then groupadd sftpusers; fi

# In case this script has already run before, remove and re-run.
# This adds a `## START_SFTP_CONFIG ##` and a `## END_SFTP_CONFIG ##`
# where the modifications has been applied.
sed "/## START_SFTP_CONFIG ##/,/## END_SFTP_CONFIG ##/d" \
    /etc/ssh/sshd_config >sshd_config.temp
cat sshd_config.temp >/etc/ssh/sshd_config
rm sshd_config.temp

# Comment out setting to disable SFTP (case if tabs and case if spaces).
sed -i "s/^Subsystem\tsftp\t\/usr\/lib\/openssh\/sftp-server/#Subsystem \
    sftp \/usr\/lib\/openssh\/sftp-server/" /etc/ssh/sshd_config
sed -i "s/^Subsystem sftp \/usr\/lib\/openssh\/sftp-server/#Subsystem \
    sftp \/usr\/lib\/openssh\/sftp-server/" /etc/ssh/sshd_config

# Append new SFTP settings at end of file.
printf "## START_SFTP_CONFIG ##
Subsystem sftp internal-sftp
\nMatch group sftpusers
\tChrootDirectory %%h
\tX11Forwarding no
\tPermitTunnel no
\tAllowAgentForwarding no
\tAllowTcpForwarding no
\tForceCommand internal-sftp
\tPasswordAuthentication yes
## END_SFTP_CONFIG ##" >>/etc/ssh/sshd_config

# Restart `sshd` for changes to apply.
systemctl restart sshd

printf "SFTP configuration is set-up.\n"
