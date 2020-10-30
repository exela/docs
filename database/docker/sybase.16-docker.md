1. install docker
2. Once installed, in terminal, use the following command:

`docker run -t -p 5000:5000 -p 5001:5001 --name sybase nguoianphu/docker-sybase:latest`

>**NOTE:** This creates a docker container using the nguoianphu/docker-sybase image.  Setting ports of the container 5000/5001 to ports 5000/5001 on your local machine.

3. Navigate into the container's bash shell:
`docker exec -it sybase /bin/bash`

4a. Ensure that the latest configuration is being used:
`source /opt/sybase/SYBASE.sh`

4b. Install UTF-8 Character Set

```
# Add UTF-8 Character Set

cd /opt/sybase/ASE-16_0/bin

./charset -Usa -PmyPassword -SMYSYBASE binary.srt utf8
```

5. Log into the sybase server as admin (so we can start running commands):
`isql -U sa -P myPassword -S MYSYBASE`

6a. Run these sybase commands to build out a `lportal` database that allows for nulls and is utf8:

```
drop database lportal
go

use master
go

disk resize name='master', size='2000M'
go

create database lportal on default=1400 with override
go

exec sp_dboption 'lportal', 'allow nulls by default', true
go
exec sp_dboption 'lportal', 'select into/bulkcopy/pllsort', true
go

sp_configure 'select for update', 1
go
sp_configure 'default character set', 190
go
sp_configure 'default sortorder id', 50, 'utf8bin'
go
sp_logiosize '16'
go
set char_convert off
go

use lportal
go

sp_logiosize '16'
go
```

6b. TIME TO RESTART. THIS IS IMPORTANT. In a NEW terminal.
```
# Restart Docker

docker restart sybase

docker stop sybase

docker start sybase

docker restart sybase

docker stop sybase

docker start sybase
```

Yes, its excessive, but I do it to make sure that the settings we have works.

6c. Verify that you are now using utf8:

```
docker exec -it sybase /bin/bash

isql -Usa -PmyPassword -SMYSYBASE

sp_helpsort
go
```

This should list it out as UTF8.  Now you can start connecting with Liferay.


7. Connect to Liferay with the following properties:

```
jdbc.default.driverClassName=com.sybase.jdbc4.jdbc.SybDriver
jdbc.default.url=jdbc:sybase:Tds:localhost:5000/lportal

jdbc.default.username=sa
jdbc.default.password=myPassword

hibernate.dialect=com.liferay.portal.dao.orm.hibernate.SybaseASE157Dialect

custom.sql.function.isnull=CONVERT(VARCHAR,?) IS NULL
custom.sql.function.isnotnull=CONVERT(VARCHAR,?) IS NOT NULL
```
