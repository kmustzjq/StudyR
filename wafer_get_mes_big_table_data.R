library(elastic)
library(dplyr,warn.conflicts = F)

host_de = 'dn2meshd06.sae.com.hk'
port_de = '19200'
user_de ='pe'
pwd_de = '!*1Zx9'

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
                  "HEAD_SN",
                  "WAFER","[DP].RESULT","[DP].MARKING","[QST].MRR","[QST].R2_MRR",
                  "[QST].AMP","[DP].SSEB_EBI(nm)-R2","[DP].SSEB_EWI(nm)-R2",
                  "[DP].MT50(nm)-R2","[DP].OW2(dB)-R1","[DP].OW2(dB)-R2","[DP].TAAL(mV)-R1",
                  "[DP].BER(dec)-R1","[DP].Sqz.BER(dec)-R1","[DP].Sqz.BER(dec)-R2",
                  "[QST].NRMS","[DP].MT50(nm)-R1","[QST].R2_AMP","[DP].Pasym(%)-R2",
                  "[DP].TAAL(mV)-R2","[QST].R2_NRMS","[DP].BER(dec)-R2","[DP].RESM(%)-R2",
                  "[DP].RESM(%)-R1","[DP].Pasym(%)-R1","[QST].DMRR","[DP].TAAM(mV)-R2",
                  "[DP].NLD(%)-R2","[QST].NPEAK","[DP].NLD(%)-R1","[QST].R2_TCR2",
                  "[DP].MT10(nm)-R1","[QST].R2_DMRR","[DP].MT10(nm)-R2"
              ],
      "size": 100000
    }'
  )
  data1 <- Search(conn = con,index = mesTable,body = doc,
                  asdf = TRUE)$hits$hits  %>% select(contains("_source"))
  if (nrow(data1)>0) {
    names(data1) <- sub("_source.","",names(data1))
    output = data1[,c("HEAD_SN",
                      "WAFER",
                      "[DP].RESULT",
                      "[DP].MARKING",
                      "[QST].MRR",
                      "[QST].R2_MRR",
                      "[QST].AMP",
                      "[DP].SSEB_EBI(nm)-R2",
                      "[DP].SSEB_EWI(nm)-R2",
                      "[DP].MT50(nm)-R2",
                      "[DP].OW2(dB)-R1",
                      "[DP].OW2(dB)-R2",
                      "[DP].TAAL(mV)-R1",
                      "[DP].BER(dec)-R1",
                      "[DP].Sqz.BER(dec)-R1",
                      "[DP].Sqz.BER(dec)-R2",
                      "[QST].NRMS",
                      "[DP].MT50(nm)-R1",
                      "[QST].R2_AMP",
                      "[DP].Pasym(%)-R2",
                      "[DP].TAAL(mV)-R2",
                      "[QST].R2_NRMS",
                      "[DP].BER(dec)-R2",
                      "[DP].MT10(nm)-R2",
                      "[DP].RESM(%)-R2",
                      "[DP].RESM(%)-R1",
                      "[DP].Pasym(%)-R1",
                      "[QST].DMRR",
                      "[DP].TAAM(mV)-R2",
                      "[DP].NLD(%)-R2",
                      "[QST].NPEAK",
                      "[DP].NLD(%)-R1",
                      "[QST].R2_TCR2",
                      "[DP].MT10(nm)-R1",
                      "[QST].R2_DMRR")]
    names(output) <- c("HEAD_SN",
                       "WAFER",
                       "D_RESULT",
                       "D_MARKING",
                       "BQ_MRR_2",
                       "BQ_MRR_2_R2",
                       "BQ_AMP_2",
                       "SSEB_EB_R2",
                       "SSEB_EW_R2",
                       "UMRW_R2",
                       "OW",
                       "OW_R2",
                       "LF_HGA_TAA",
                       "SOVABER",
                       "SQZ_SOVABER",
                       "SQZ_SOVABER_R2",
                       "BQ_NRMS_2",
                       "UMRW",
                       "BQ_AMP_2_R2",
                       "TAA_ASYM_R2",
                       "LF_HGA_TAA_R2",
                       "BQ_NRMS_2_R2",
                       "SOVABER_R2",
                       "UMRW2_R2",
                       "RESM_R2",
                       "RESM",
                       "TAA_ASYM",
                       "BQ_DMRR2",
                       "MF_TAA_MV__R2",
                       "P_SPECTNLD_R2",
                       "BQ_NPEAK_2",
                       "P_SPECTNLD",
                       "BQ_TCR2_2_R2",
                       "UMRW2",
                       "BQ_DMRR2_R2")
  } else {output <-  data.frame()}
  return(output)
}

# WAFERList <- data2$WAFER %>% unique()
# setwd("D:/data_Engineer/kristy/MG08_ADC_parameter")
# for (i in 1:length(WAFERList)) {
#   print(i)
#   WAFER <- WAFERList[i]
#   waferdata <- get_Data_from_MES_big_table(host_de,port_de,user_de,pwd_de,WAFER,mesTable)
#   write.csv(x = waferdata,file = paste0("result/",WAFER,"_MG08_ADC_parameter_wafer_data_20200807.csv"),row.names = F)
# }


setwd("D:/data_Engineer/kristy/MG08_ADC_parameter")
for (i in 1:length(b)) {
  print(i)
  WAFER <- b[i]
  waferdata <- get_Data_from_MES_big_table(host_de,port_de,user_de,pwd_de,WAFER,mesTable)
  write.csv(x = waferdata,file = paste0("result1/",WAFER,"_MG08_ADC_parameter_wafer_data_20200807.csv"),row.names = F)
}

