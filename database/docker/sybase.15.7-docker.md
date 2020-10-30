1. install docker
2. Once installed, in terminal, use the following command:

`docker run -i -t --name sybase157 -p 5010:5000 -h dksybase -d ifnazar/sybase_15_7 bash /sybase/start`

>**NOTE:** This creates a docker container using the ifnazar/sybase_15_7 image.  Setting ports of the container 5000 to ports 5010 on your local machine.  The container's server name is `DKSYBASE`.

3. Make sure to start the docker container:
`docker start sybase157`

4. Log into the sybase server as admin (so we can start running commands):
`docker exec -i -t sybase157 bash /sybase/isql`

6. Run these sybase commands to build out a `lportal` database that allows for nulls and is utf8:

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
sp_configure 'default sortorder id', 50, 'utf8'
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

7. Connect to Liferay with the following properties:

```
jdbc.default.driverClassName=com.sybase.jdbc4.jdbc.SybDriver
jdbc.default.url=jdbc:sybase:Tds:localhost:5010/lportal

jdbc.default.username=sa
jdbc.default.password=myPassword

hibernate.dialect=com.liferay.portal.dao.orm.hibernate.SybaseASE157Dialect

custom.sql.function.isnull=CONVERT(VARCHAR,?) IS NULL
custom.sql.function.isnotnull=CONVERT(VARCHAR,?) IS NOT NULL
```
