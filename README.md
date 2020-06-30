# sftp-jailed-users  

This repo contains necessary scripts to configure a Debian / Ubuntu 
server to create and delete jailed SFTP users / accounts with username / password authentification.  

Jailed users created will have access to their own and unique SFTP directory. These scripts doesn't allow 
to create multiple users for one same SFTP account.  

## Instructions  

You will need to run `./initialize` so you're server is configured to accept 
SSH connections from the jailed users (from a `sftpusers` group) using password Auth.  

```sh
./initialize.sh
```

### Create a user  

Create a unique jailed directory `/home/<username>/data` for the user on the server, and 
accessible via SSH with password Auth (or using GUI software like FileZilla).  
```sh 
./create_user <username> <password>
```

### Delete a user  

Remove the user from the server (including his data).  
```sh
./delete_user <username>
```
