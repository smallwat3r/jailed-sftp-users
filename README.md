# sftp-jailed-users  

This repo contains scripts that allow to configure a Debian / Ubuntu 
server to create and delete jailed SFTP users with username / password authentification.  

All users created will have access to their own SFTP directory. These scripts doesn't allow 
to create multiple users for one same directory.  

## Instructions  

Make sure all scripts are executables.  
```sh
chmod +x initialize.sh create_user.sh delete_user.sh
```

You will need to run `initialize.sh` so you're server is configured to accept 
SSH connections from the jailed users (from a `sftpusers` group) using password Auth.  

```sh
./initialize.sh
```

### Create a user  

Create a unique jailed directory `<username>/data` for the user on the server, and 
accessible via SSH with password Auth (or using GUI software like FileZilla).  
```sh 
./create_user.sh <username> <password>
```

### Delete a user  

Remove the user from the server (including his data).  
```sh
./delete_user.sh <username> <password>
```
