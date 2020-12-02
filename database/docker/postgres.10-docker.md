# Introduction

This document will walk you through the use of a Postgres 10 Docker Image.

# Steps

1) sign up and register for docker hub

2) install docker

3) authenticate into docker. in a terminal:

`docker login`

4) start up the docker image/container:

`docker run -d -it --name postgres10 -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword postgres:10.15`

- if you need to have a shared volume, you can add the following parameter (pointing the filepath to a folder on your local machine where your backups are):
```
-v /Users/newFolder/db-backup:/backups
```

it would end up looking like this for the command:

`docker run -d -it --name postgres10 -P -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -v /Users/newFolder/db-backup:/backups postgres:10.15`

>**NOTE:** the `/Users/newFolder/db-backup` is a folder on your local machine that you share with the docker container.

- This command creates a `/backups` folder inside the postgres container.

- we are mapping ports 5432 to the same ports on your machine. `localPort:containerPort`

5) so you want to import from a backup?  if you created a shared volume (that already contains the backup, you can skip step c)

a. let's login to the container to access `psql` to create our databases

```
docker exec -it postgres10 psql -U postgres
```

b. from there, we can create our database name and grant it privileges to our main user `postgres`:

```
postgres=# create database database_name;
CREATE DATABASE
postgres=# GRANT ALL PRIVILEGES ON DATABASE database_name TO postgres;
GRANT
```

c. let's copy your backup into your postgres10 container. run the following command:

```
docker cp /path/to/dump/on/your/machine postgres10:/var/lib/postgresql/data
```

This command copies the database into the container's `/var/lib/postgresql/data` folder.

>**NOTE:** the `postgres10` is the name of our container.  obviously if you didnt name it this, you would use whatever you had named it. or the container id.

b. Once copied, we can then use the `pg_restore` command to import

```
docker exec postgres10 pg_restore -U postgres -d database_name -a -f /path/in/container/to/database.backup.sql
```

- so if you ran the `docker cp` command in step c, then the command would look like:

```
docker exec postgres10 pg_restore -U postgres -d database_name /var/lib/postgresql/data
```


- if you used a shared volume (as we talked about in step 4) instead and not the `docker cp` command, then your command would look like:

```
docker exec postgres10 pg_restore -U postgres -d database_name -a -f /backups/database.backup.sql
```

If for some reason `pg_restore` isn't working, we can try this:

```
docker exec postgres10 psql -U postgres -d database_name < /PATH/TO/database.backup.sql
```


6) Connect to the portal:

```
jdbc.default.driverClassName=org.postgresql.Driver
jdbc.default.url=jdbc:postgresql://localhost:5432/lportal
jdbc.default.username=postgres
jdbc.default.password=mysecretpassword
```

# Additional Notes

## Accessing `psql` in the container

if you need to access `psql` in the postgres container, you can run this command:

```
docker exec -it postgres10 psql -U postgres
```

this logs you into `psql` as the `postgres` user.  from there you can create databases, drop them, do all kinds of things.

## Creating a Role

1. Login to `psql`

2. Create role called <role-name>: `create role <role-name>;` (optional)

## Create a tablespace

1. login to `psql`

2. run the command: `create tablespace <tablespace-name> location 'C:\File'`

## The following is a generalized idea of what we performed:


### Find the name and id of the Docker container hosting the Postgres instance
Turn on Docker and run `docker ps` to see the list of containers and their names and ids.

### Find the volumes available in the Docker container
Run `docker inspect -f '{{ json .Mounts }}' <container_id> | python -m json.tool`

### Copy the dump from your host system to one of the volumes
Run docker cp </path/to/dump/in/host> <container_name>:<path_to_volume>

### Execute pg_restore via `docker exec` command
docker exec <container_name> pg_restore -U <database_owner> -d <database_name> <path_to_dump>