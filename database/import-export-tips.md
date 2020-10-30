Using Database Tips
====
Hello.  Here are some database commands and steps I use when importing/exporting.

- [MySQL](#mysql)
  * [Create a Database](#create-a-database)
  * [Import a Dump](#import-a-dump)
  * [Export a Dump](#export-a-dump)
- [PostgreSQL](#postgresql)

  **Windows**
  * [Create a Database](#create-a-database-1)
  * [Import a Dump](#import-a-dump-1)
  * [Create a Role](#create-a-role)
  * [Alter a Role](#alter-a-role)
  
  **Ubuntu/Linux**
  * [Create a Database](#create-a-database-2)
  * [Import a Dump](#import-a-dump-2)
  * [Create a Role](#create-a-role-1)
  * [Alter a Role](#alter-a-role-1)
  * [Installing pgAdmin](#installing-pgadmin)

MySQL
-----
### Create a Database
1. Log into the MySQL Prompt.
2. Use the `create database` command to create:
* `create database dbName;`

### Import a Dump

1. Log into the MySQL Prompt.
2. Select the database to be used:

`use dbName`

3. Use `source` to import the dump into the selected database:

`source /file/path/to/dump`

### Export a Dump
The command, `mysqldump` is used to create dump files:

`mysqldump -u userName -p myPassword dbName > /file/path/to/backupfile.sql`

In case the packet sizes are too small for the export to complete:

`mysqldump -u userName -p myPassword --max_allowed_packet=2147483648 dbName > /file/path/to/backupfile.sql`

Note: There is **no** space between the `-p` flag and the password.

### Creating a User
`CREATE USER 'userName'@'localhost' IDENTIFIED BY 'password';`

### Grant Privileges to User
`GRANT ALL PRIVILEGES ON *.* TO 'userName'@'localhost' WITH GRANT OPTION;`


PostgreSQL
-----

## Windows Commands

### Create a Database
1. Open a command prompt and log into Postgres (psql.exe):
`psql.exe --username=postgres`
2. In the PSQL prompt:
`create database <database-name>;`

### Import a Dump
1. Open a command prompt and log into Postgres (psql.exe):

`psql.exe --username=postgres`

2. In the command prompt:

`psql.exe --username=postgres (database-name) < FilePathToDump.dmp`

Some imports may fail based on how the export was created.  In this case, the following are some alternatives that can be used for import attempts.

```
psql.exe -U postgres -d dbName -a -f fileName

pg_restore -U postgres -d dbName fileName
```

### Create a Role
During some imports, the logs may indicate that a role does not exist.  In this case, we will create a new role:

`create role <role-name>;`

> **NOTE:** We can also create a superuser to ensure the role has the proper permissions/commands:

`createuser --interactive`

### Alter a Role
Sometimes, roles may also require the proper login ability or other permissions.

> **NOTE:** This is done under the psql prompt.

- To give 'login' permission:
`alter role "<role-name>" with login;`

- To update a password: 
`ALTER USER postgres PASSWORD 'myPassword';`


## Ubuntu/Linux Commands

### Create a Database
1. Login as the `postgres` user for your terminal:
`sudo -i -u postgres`
2. Terminal prompt should update to show you are logged in as a `postgres` user - `postgres-#>`

3. Login to the Postgres SQL Prompt as `postgres` (this is a user IN the Postgres server):
`psql --username=postgres`

4. Create your database: 
`create database dbName`

### Import a Dump

1. Login as the `postgres` user for your terminal:
`sudo -i -u postgres`

2. Terminal prompt should update to show you are logged in as a `postgres` user - `postgres-#>`

3. In the prompt:
`psql --username=postgres dbName < fileName.sql`

> **NOTE:** Some imports may fail based on how the export was created.  In this case, the following are some alternatives that can be used for import attempts.

```
psql -U postgres -d dbName -a -f fileName

pg_restore -U postgres -d dbName fileName
```

### Create a Role

During some imports, the logs may indicate that a role does not exist.  In this case, we will create a new role.

1. Login as the `postgres` user for your terminal:
`sudo -i -u postgres`

2. Terminal prompt should update to show you are logged in as a `postgres` user - `postgres-#>`

3. Login to the Postgres SQL Prompt as `postgres` (this is a user IN the Postgres server):
`psql --username=postgres`

4. Create the role: 
`create role <role-name>;`

> **NOTE:** We can also create a superuser to ensure the role has the proper permissions/commands:

`createuser --interactive`

### Alter a Role

Sometimes, roles may also require the proper login ability or other permissions.  This is how you would alter a role with login.

1. Login as the `postgres` user for your terminal:
`sudo -i -u postgres`

2. Terminal prompt should update to show you are logged in as a `postgres` user - `postgres-#>`

3. Login to the Postgres SQL Prompt as `postgres` (this is a user IN the Postgres server):
`psql --username=postgres`

4. Alter the role:

- To give 'login' permission:
`alter role "<role-name>" with login;`

- To update a password: 
`ALTER USER postgres PASSWORD 'myPassword';`

### Installing pgAdmin

1) In a terminal, update and install pgadmin:

```
sudo apt update
sudo apt install pgadmin4 pgadmin4-apache2
```

2) Update the default user under the Postgres Server `postgres` with a password to connect.  See [Alter a Role](#alter-a-role-1).

#### Adding a Connection
1. Open PGADMIN
2. Add New Server:
- give it a name ‘localhost’
- click ‘Connection’ tab (keeping other values default):
  - hostname/ip: `localhost`
  - update the password with the recently changed `myPassword`
3. Save the connection.
