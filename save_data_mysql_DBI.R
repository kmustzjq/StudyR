library(methods,warn.conflicts = F)
library(DBI,warn.conflicts = F)
library(RMariaDB,warn.conflicts = F)
library(dplyr,warn.conflicts = F)
# library(iterators)
# library(parallel)
# library(foreach)
# library(doParallel)

db_user = 'de'
db_password = '$Dk9Ls66'
db_name = 'mes_de'
db_host = '10.10.1.28'
db_port = 3306
con <-  dbConnect(RMariaDB::MariaDB(), user = db_user, password = db_password,
                  dbname = db_name, host = db_host, port = db_port)
dbWriteTable(conn = con,name = "ML_AI_BMWW_measure",value = BMWW_measure,append=T,row.names=F)
dbDisconnect(conn = con)

