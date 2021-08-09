
smooth_by_smoothIndex <- function(pred_data,smoothIndex,column1){
  long_index<-subset(smoothIndex,BLOCK %in% c("A","B","C","D","J","K","P","Q"))
  middle_index<-subset(smoothIndex,BLOCK %in% c("E","F","G","H","R","S"))
  
  
  
  long_bar_Smooth<-function(pred_data,wafer1,block1,row1,column1){
    data1<-subset(pred_data,WAFER %in% wafer1 & BLOCK %in% block1 & ROW %in% row1) %>% 
      select(WAFER,BLOCK,ROW,SLIDER_NO,!! sym(column1))
    # names(data1)[grep("SLD_NO",names(data1))]<-"SLIDER_NO"
    nn=91
    Delta_Hw<-rep(0,nn)
    Delta_Hw[as.numeric(data1$SLIDER_NO)]<-data1[,column1] %>% unlist() %>% as.numeric()
    Delta_Hw_final<-rep(0,nn)
    Delta_Hw_final[1:5]<-mean(Delta_Hw[1:11],na.rm = T)
    for (i in 6:85) {
      Delta_Hw_final[i]<-mean(Delta_Hw[(i-3):(i+3)],na.rm = T)
    }
    Delta_Hw_final[86:91]<-mean(Delta_Hw[81:91],na.rm = T)
    data2<-data.frame("WAFER"=rep(wafer1,nn),
                      "BLOCK"=rep(block1,nn),
                      "ROW"=rep(row1,nn),
                      "slider"=1:nn,
                      "smooth_final"=Delta_Hw_final)
    rm(data1,Delta_Hw,Delta_Hw_final)
    gc()
    return(data2)
  }
  
  
  middle_bar_Smooth<-function(pred_data,wafer1,block1,row1,column1){
    data1<-subset(pred_data,WAFER %in% wafer1 & BLOCK %in% block1 & ROW %in% row1) %>% 
      select(WAFER,BLOCK,ROW,SLIDER_NO,!! sym(column1))
    nn=75
    Delta_Hw<-rep(0,nn)
    Delta_Hw[as.numeric(data1$SLIDER_NO)]<-data1[,column1] %>% unlist() %>% as.numeric()
    Delta_Hw_final<-rep(0,nn)
    
    Delta_Hw_final[1:5]<-mean(Delta_Hw[1:11],na.rm = T)
    for (i in 6:70) {
      Delta_Hw_final[i]<-mean(Delta_Hw[(i-3):(i+3)],na.rm = T)
    }
    Delta_Hw_final[71:75]<-mean(Delta_Hw[65:75],na.rm = T)
    data2<-data.frame("WAFER"=rep(wafer1,nn),
                      "BLOCK"=rep(block1,nn),
                      "ROW"=rep(row1,nn),
                      "slider"=1:nn,
                      "smooth_final"=Delta_Hw_final)
    rm(data1,Delta_Hw,Delta_Hw_final)
    gc()
    return(data2)
  }
  
  
  final_smooth_data<-data.frame()
  cl<-makeCluster(14)
  registerDoParallel(cl)
  if (nrow(long_index)>0) {
    longdata<-foreach(i=1:nrow(long_index),.combine = rbind,.packages = c("dplyr","tidyr")) %dopar%
      long_bar_Smooth(pred_data=pred_data,
                      wafer1 = as.character(long_index[i,]$WAFER),
                      block1 = as.character(long_index[i,]$BLOCK),
                      row1 = as.character(long_index[i,]$ROW),
                      column1 = column1)
    final_smooth_data<-rbind(final_smooth_data,longdata)
  }
  if (nrow(middle_index)>0) {
    middledata<-foreach(i=1:nrow(middle_index),.combine = rbind,.packages = c("dplyr","tidyr")) %dopar%
      middle_bar_Smooth(pred_data = pred_data,
                        wafer1 = as.character(long_index[i,]$WAFER),
                        block1 = as.character(long_index[i,]$BLOCK),
                        row1 = as.character(long_index[i,]$ROW),
                        column1 = column1)
    final_smooth_data<-rbind(final_smooth_data,middledata)
  }
  stopCluster(cl)
  # final_smooth_data<-rbind(final_smooth_data,longdata)
  return(final_smooth_data)
}
rm(list = ls(name = foreach:::.foreachGlobals),envir =  foreach:::.foreachGlobals)
smoothIndex <- final_test_data1111 %>%  group_by(WAFER,ROW,BLOCK) %>% summarise(qty=n())
final_smooth_data <- smooth_by_smoothIndex(pred_data=final_test_data1111,smoothIndex,column1 = "slider_stamp_predict")
final_WPE_smooth_data <- smooth_by_smoothIndex(pred_data=final_test_data1111,smoothIndex,column1 = "delta_WPE")
# smoothIndex1 <- smoothIndex %>% mutate(ID=row_number()) %>% select(-qty)
Arrange_in_below_table<-final_smooth_data %>% spread(key = slider,value = mean_delta_HWf_final)




names(final_smooth_data)[5] <- "slider_stamp_predict"
names(final_WPE_smooth_data)[5] <- "delta_WPE"

final_smooth_data1111 <- final_smooth_data %>% left_join(final_WPE_smooth_data,by=c("WAFER","BLOCK","ROW","slider"))
write.csv(x = final_smooth_data1111,file = "csv/test_wafer_data_block_A_B_202008261416.csv",row.names = F)
