library(methods,warn.conflicts = F)
library(DBI,warn.conflicts = F)
library(RMariaDB,warn.conflicts = F)
library(dplyr,warn.conflicts = F)
db_user = 'de'
db_password = '$Dk9Ls66'
db_name = 'mes_de'
db_host = '10.10.1.28'
db_port = 3306

for (i in 1:394) {
  print(i)
  start1 <- (i-1)*1000+1
  stop1 <- i*1000
  if (stop1 > nrow(result_MG09_3)) {
    stop1 <-  nrow(result_MG09_3)
  }
  data1 <- result_MG09_3[start1:stop1,]
  con <-  dbConnect(RMariaDB::MariaDB(), user = db_user, password = db_password,
                    dbname = db_name, host = db_host, port = db_port)
  dbWriteTable(conn = con,name = "MG09_1P_WIR_AI_Train_Data",value = data1,append=T,row.names=F)
  dbDisconnect(conn = con)
}


con <-  dbConnect(RMariaDB::MariaDB(), user = db_user, password = db_password,
                  dbname = db_name, host = db_host, port = db_port)
MG09_1P_WIR_AI_Train_Data <- tbl(con,"MG09_1P_WIR_AI_Train_Data") %>% collect()
dbDisconnect(conn = con)
