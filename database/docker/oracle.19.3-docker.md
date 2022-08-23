# Oracle 19.3c Database
This is a quick guide to get an image built up and running for Oracle 19.3 for testing.  This is based off instructions found here:

https://github.com/oracle/docker-images/tree/main/OracleDatabase/SingleInstance#oracle-database-container-images 
https://liferay.atlassian.net/wiki/spaces/KB/pages/2044330461/Oracle+Database+-+Standalone+Docker+Setup

# Prerequesites
- Oracle Account (for downloads)
- Oracle SQL Developer Application (for browsing)
- Docker and Docker Hub Account
- At least 10GB+ of file space

# Setup

1. Setup the repo
- make a new directory (/docker/oracle)
- navigate into directory (`cd /docker/oracle`)
- Clone the `orcale/docker-images` repo - https://github.com/oracle/docker-images (`git clone https://github.com/oracle/docker-images`)

2. Download the oracle database binaries: https://www.oracle.com/database/technologies/oracle-database-software-downloads.html
- you may have to register an oracle account
- extract the .zip into the filepath (`/docker/oracle/docker-images/OracleDatabase/SingleInstance/dockerfiles/19.3.0`)

3. Navigate one level higher of where the binaries were extracted
- `cd /docker/oracle/docker-images/OracleDatabase/SingleInstance/dockerfiles/19.3.0`

4. Build out the image. Note: remember, you will need about 10GB+ of space.
- before building out, make sure you are logged into docker `docker login`
- `./buildContainerImage.sh -v 19.3.0 -t oracle19c:19.3.0ee -e`

# Startup/Configuring the Database

## Running the container
A quick sample setup can be found below:
```
docker run --name o19c -d \
-p 1521:1521 -p 5500:5500 \
-e ORACLE_SID=ORCL \
-e ORACLE_PDB=lportal \
-e ORACLE_PWD=liferay \
-e ORACLE_EDITION=enterprise \
-e ENABLE_ARCHIVELOG=true \
-v /docker/oracle/19.3/oradata:/u01/app/oracle/oradata \
oracle19c:19.3.0ee
```

We are creating a container named `o19c` using the built imgage from Setup Step #4, `oracle19c:19.3.0ee`

Ports are setup to mirror standard oracle setup. 1521 and 5500.

we are also making a volume at `/docker/oracle/19.3/oradata` on your local machine and mapping it to where it normally can be found in oracle.  the `/docker/oracle/19.3/oradata` location can always be changed.

Remember, its localValue:containerValue. 

## Updating Oracle DB Configs

1. we need to access the container
- `docker exec -it o19c /bin/bash`

2. now that we're logged into the container, let's log into sqlplus
- `sqlplus system/liferay@//localhost:1521/ORCL`

3. disable restricted sessions (so we can connect easily with other sessions)
```
SQL> alter system disable restricted session;
SQL> commit;
SQL> exit
```

4. restart the listener for the database
```
/bin/bash$ lsnrctl reload
```

# Connecting to the database

## SQL Developer Tool
using oracle's sql developer tool, you can now connect:

name: oracle 19.3
database type: oracle

Username: system
Password: liferay

Connection Details:
hostname: localhost
port: 1521
SID: orcl

## Liferay Connection

```
jdbc.default.driverClassName=oracle.jdbc.OracleDriver
jdbc.default.url=jdbc:oracle:thin:@localhost:1521/lportal
jdbc.default.username=system
jdbc.default.password=liferay
```