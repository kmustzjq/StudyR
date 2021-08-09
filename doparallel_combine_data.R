read_important_data_from_filelist <-function(i,fileList){
  data1 <- read_csv(paste0("csv/check_one_wafer_20201028/",fileList[i]))
  if (nrow(data1)>0) {
    data2 <- data1 %>% filter(BLOCK %in% c("J","K"))
    rm(data1)
    gc()
    return(data2)
  }else{
    rm(data1)
    gc()
    return(data.frame())
  }
  
} 

library(plyr,warn.conflicts = F)
library(dplyr,warn.conflicts = F)
library(foreach)
library(doParallel)
library(tidyr)
library(readr)
fileList <- dir("D:/data_Engineer/walter/skybolt_TSDF30_TL/csv/check_one_wafer_20201028/")



rm(list = ls(name = foreach:::.foreachGlobals),envir = foreach:::.foreachGlobals)
core1 <- makeCluster(14)
registerDoParallel(cores = core1)
predict_WPE_data1 <- foreach(i=1:length(fileList),.combine = "rbind",.packages = c("dplyr",'readr')) %dopar% 
  read_important_data_from_filelist(i,fileList)
stopCluster(core1)