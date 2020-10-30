# MySQL Tips
This is a collection of tips that are really only applicable to mysql.

## MySQL - "Forgiving" Mode
In MySQL 5.7, protections were added to help avoid queries that would enforce stricter MySQL standards.  This in turn resulted in old queries that used to work to now give the following errors:

```
Error Code: 1055. Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column ‘schema.table.table_column’ which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
```

We can fix this by adding in the following line under our `mysqld` section in our `my.cnf` file for our MySQL installation:

```
[mysqld]
sql_mode="STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
```
