library(elastic)
library(dplyr,warn.conflicts = F)

host_de = 'dn2meshd06.sae.com.hk'
port_de = '19200'
user_de ='pe'
pwd_de = '!*1Zx9'


WAFER = "9AD59"
mesTable ="bigtable"


get_Data_from_MES_big_table <- function(host_de,port_de,user_de,pwd_de,WAFER,mesTable,doc){
  con <- elastic::connect(host = host_de,port = port_de,user = user_de,pwd = pwd_de)
  doc =paste0(
    '{
    "query": 
      {"bool": 
        {"must": [
            {"term": {
                "WAFER": "',WAFER,'"
                }
              }
            ]
          }
      },
      "_source": [
                "WAFER+BLOCK+ROW",
                "WAFER+BLOCK",
                "WAFER",
                "SLIDER_NO",
                "Shift",
                "rowkey",
                "ROW",
                "PROJECT_NAME",
                "PROJECT_CODE",
                "PROJECT",
                "HEAD_SN",
                "BLOCK",
                "[DP].WPE(nm)-Wb",
                "[DP].WPE(nm)-Wa",
                "[DP].WPE(nm)-8T[2]",
                "[DP].WPE(nm)-8T",
                "[DP].WPE(nm)[2]",
                "[DP].WPE(nm)",
                "[DP].SSEB_MWWO(nm)-R2",
                "[DP].SSEB_MWWO(nm)-R1",
                "[DP].SSEB_MWWO(nm)",
                "[DP].SSEB_MWWI(nm)-R2",
                "[DP].SSEB_MWWI(nm)-R1",
                "[DP].SSEB_MWWI(nm)",
                "[DP].SSEB_MWW(nm)-R2",
                "[DP].SSEB_MWW(nm)-R1",
                "[DP].SSEB_MWW(nm)",
                "[DP].SSEB_EWO(nm)-R2",
                "[DP].SSEB_EWO(nm)-R1",
                "[DP].SSEB_EWO(nm)",
                "[DP].SSEB_EWI(nm)-R2",
                "[DP].SSEB_EWI(nm)-R1",
                "[DP].SSEB_EWI(nm)",
                "[DP].SSEB_EW(nm)-R2",
                "[DP].SSEB_EW(nm)-R1",
                "[DP].SSEB_EW(nm)",
                "[DP].SSEB_EBO(nm)-R2",
                "[DP].SSEB_EBO(nm)-R1",
                "[DP].SSEB_EBO(nm)",
                "[DP].SSEB_EBI(nm)-R2",
                "[DP].SSEB_EBI(nm)-R1",
                "[DP].SSEB_EBI(nm)",
                "[DP].SSEB_EB(nm)-R2",
                "[DP].SSEB_EB(nm)-R1",
                "[DP].SSEB_EB(nm)",
                "[DP].MWW(nm)-R2-Wb",
                "[DP].MWW(nm)-R2-Wa",
                "[DP].MWW(nm)-R2",
                "[DP].MWW(nm)-R1",
                "[DP].MWW(nm)",
                "[DP].EWAC(nm)-R2",
                "[DP].EWAC(nm)"
              ],
      "size": 100000
    }'
  )
  data1 <- Search(conn = con,index = mesTable,body = doc,
                 asdf = TRUE)$hits$hits  %>% select(contains("_source"))
  names(data1) <- sub("_source.","",names(data1))
  return(data1)
}



for (i in 1:length(WAFERList)) {
  WAFER <- WAFERList[i]
  waferdata <- get_Data_from_MES_big_table(host_de,port_de,user_de,pwd_de,WAFER,mesTable)
}



