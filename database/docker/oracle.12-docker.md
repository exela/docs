# Introduction

This document will walk you through the creation of an Oracle 12 Docker Image and setting it up to utilize utf-8.

# Steps

1a) sign up and register for docker hub

1b) sign up and register to use the official oracle docker image. you must be logged in and click 'checkout':

https://hub.docker.com/_/oracle-database-enterprise-edition

2) install docker

3) authenticate into docker. in a terminal:

`docker login`

4) in any folder, create a new file 'ora.conf' with the following:

```
####################################################################
## Copyright(c) Oracle Corporation 1998,2016. All rights reserved.##
##                                                                ##
##                   Docker OL7 db12c dat file                    ##
##                                                                ##
####################################################################
 
##------------------------------------------------------------------
## Specify the basic DB parameters
##------------------------------------------------------------------
 
## db sid (name)
## cannot be longer than 8 characters
 
DB_SID=ORCLCDB
 
## db passwd
## default : Oracle
 
DB_PASSWD=Oradoc_db1
 
## db domain
## default : localdomain
 
DB_DOMAIN=localdomain
 
## db bundle
## default : basic
## valid : basic / high / extreme
## (high and extreme are only available for enterprise edition)
 
DB_BUNDLE=basic

DB_MEMORY="6gb"
 
## end
```

5) in that same folder where you created the ora.conf start up the docker image/container (you can also just put the filepath in for the `ora.conf`):

`docker run -d -it --name oracle12 -P --env-file ora.conf -p 1521:1521 -p 5500:5500 store/oracle/database-enterprise:12.2.0.1`

- if you need to have a shared volume, you can add the following parameter:
```
-v /Users/newFolder/db-backup:/ORCL
```

it would end up looking like this for the command:

`docker run -d -it --name oracle12 -P --env-file ora.conf -p 1521:1521 -p 5500:5500  -v /Users/newFolder/db-backup:/ORCL store/oracle/database-enterprise:12.2.0.1`

>**NOTE:** the `/Users/newFolder/db-backup` is a folder on your local machine that you share with the docker container.

- we are mapping ports 1521 and 5500 to the same ports on your machine. `localPort:containerPort`
- we are using oracle 12.2 - yes, you can use it for oracle 12. yes 12.2 is a minor version

6) Next, we will be running several oracle commands.  We can do it either via the SQL*Plus command line or via SQL Developer.

>**NOTE:** To connect via the SQL*Plus command line use the docker command: 

> `docker exec -it oracle12 bash -c "source /home/oracle/.bashrc; sqlplus /nolog"`

> Once connected, login as the sysdba `connect / as sysdba`


With SQL Developer, connect to the docker image.

These are the login credentials for the sysdba role:

```
user: sys
pw: Oradoc_db1
SID: ORCLCDB
```

7) Once connected to SQL*Plus, run the following commands:

```
alter session set "_ORACLE_SCRIPT"=true;
create tablespace lportal datafile 'lportal.dbf' size 64m autoextend on next 32m maxsize unlimited;
create user lportal identified by liferay default tablespace lportal;
grant dba to lportal;
```

- this creates a new user, `lportal` with the password `liferay`
- we gave it `dba` privileges

>**NOTE:** The first line is important! It allows us to run the creation of a user without using a c## prefix. (ORA-65096) it does mean that a pluggable/container database will not work.  (we don't really care about that since we're just using it as a dev environment)


8) Connect to the portal:

```
jdbc.default.driverClassName=oracle.jdbc.OracleDriver
jdbc.default.url=jdbc:oracle:thin:@localhost:1521:orclcdb
jdbc.default.username=lportal
jdbc.default.password=liferay
```

9) so you want to import?  Make sure in Step 5, that you have setup shared volumes.

a. let's get into the terminal of your container. run the following command:

```
docker exec -it oracle12 bash -c "source /home/oracle/.bashrc; /bin/bash"
```

b. Create a directory for your dump to be placed into. (do this in SQL Developer or through SQL*Plus)

```
create directory dump as '/ORCL/dump'
```

c. put your dump into your shared volume that has /dump in there.

d. now import your thing.

```
impdp lportal/liferay directory=dump dumpfile=yourDump.dmp nologfile=yes full=y
```

