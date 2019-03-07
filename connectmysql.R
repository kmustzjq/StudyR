mysqlconnection = dbConnect(MySQL(), user='root', password='', dbname='sakila', host='localhost')
dbListTables(mysqlconnection)