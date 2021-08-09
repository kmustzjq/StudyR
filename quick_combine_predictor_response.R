rm(list = ls())
gc()
library(readr)
library(dplyr,warn.conflicts = F)



setwd("D:/data_Engineer/walter/MG09_BTSAQ0_1P_OSR_AI/data/20210726/")
fnames1 <- list.files()
csv1 <- lapply(fnames1, read_csv)
MG09_BTSAQ0_1P_OSR_AI_data <- do.call(rbind, csv1)


setwd("D:/data_Engineer/walter/MG09_BTSAQ0_1P_OSR_AI/DP/20210727/")
fnames2 <- list.files()
csv2 <- lapply(fnames2, read_csv)
MG09_BTSAQ0_1P_OSR_AI_DP <- do.call(rbind, csv2)

rm(fnames1,csv1,fnames2,csv2)
gc()


MG09_BTSAQ0_1P_OSR_AI_DP <- MG09_BTSAQ0_1P_OSR_AI_DP %>% rename(
  "SSEB_EWI" = `SSEB_EWI(nm)-R2`)


MG09_BTSAQ0_1P_OSR_AI_raw_data <- MG09_BTSAQ0_1P_OSR_AI_data %>% 
  mutate(HEAD_SN = paste0(WAFER,ROW,BLOCK,COLUMN)) %>% 
  left_join(MG09_BTSAQ0_1P_OSR_AI_DP,by="HEAD_SN") %>% 
  filter(SSEB_EWI<130 & SSEB_EWI>20) 

setwd("D:/data_Engineer/walter/MG09_BTSAQ0_1P_OSR_AI/")
save(MG09_BTSAQ0_1P_OSR_AI_raw_data,file = "Rdata/MG09_BTSAQ0_1P_OSR_AI_raw_data.Rdata")