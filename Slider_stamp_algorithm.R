#-----------------------------------------------------------------------------------------------------------
# time 2019 08 30 MQO4 slider stamp
#-----------------------------------------------------------------------------------------------------------
need_column <- c(
   "delta_INC_IPCM","delta_INC_ELG_w2_divide_r2","SS1_EXP_TOOL",
   "HTW_EXP_TOOL","RIM_IBE_TOOL","delta_INC_ELG_R2","delta_INC_ELG_W2","delta_INC_HDI","delta_INC_HR",
   "delta_INC_MRR","delta_INC_PCM","delta_INC_WRT_RES","FF_TWG_Y","FF_WF_MRR","FF_BLK_SS1_Y","FF_PT2C_UZ55",
   "R4_MEAN","W1_MEAN","R2_RIM_IBE_TOOL","OC_SPUT_TOOL","CUS_IBE_TOOL","UC_DEP_TOOL","X0D2_PWA_F","X0D2_P2TB",
   "OU5V_P2TB_AVG","TMR_IBD_TOOL","S1_EXP_TOOL","R2_TMR_IBD_TOOL"
)


calculate_by_sld<-function(i,train_levels,Train_data1,need_column){
  ADDRESS1<-train_levels[i]
  Train_data1$ADDRESS<-as.character(Train_data1$ADDRESS)
  Train_data_A_SLD10<-subset(Train_data1,ADDRESS %in% ADDRESS1)

  set.seed(0)
  if(nrow(Train_data_A_SLD10)<=1){
    verif_value=NA
    random_forest_fit=NULL
  }else{
    bagData<-as.matrix(Train_data_A_SLD10[,c("delta_SSEB_EWI",need_column)])
    #-----------------------------------------bagging--------------------------------------------
    tunegrid <- expand.grid(.mtry=c(4:10))
    random_forest_fit<-train(delta_SSEB_EWI~.,data = bagData,
                   method='rf',
                   tuneGrid=tunegrid, 
                   trControl=trainControl(method = "cv",number = 5))
    
  }
  save(random_forest_fit,file = paste0("MG08_slider_stamp_model/",ADDRESS1,"_random_forest_fit.Rdata"))
  rm(Train_data_A_SLD10,random_forest_fit)
  gc()
  return(NULL)
}



main<-function(Train_data,Block1,need_column,calculate_by_sld){
  
  Train_data1<-subset(Train_data,BLOCK %in% Block1)
  
  train_levels<-levels(as.factor(Train_data1$ADDRESS))
  
  n1=length(train_levels)
  rm(list = ls(name = foreach:::.foreachGlobals),envir = foreach:::.foreachGlobals)
  coreNumber<-makeCluster(14)
  registerDoParallel(coreNumber)
  model_1<-foreach(i1=1:n1,.combine = "rbind", .packages = c("caret")) %dopar% 
    calculate_by_sld(i = i1,train_levels,Train_data1,need_column)
  stopCluster(coreNumber)
  return(model_1)
}







rm(list = ls(name = foreach:::.foreachGlobals),envir = foreach:::.foreachGlobals)
test_pred<-data.frame()
Block_list <- c("A", "B" ,"C", "D", "E", "F", "G" ,"H", "J" ,"K" ,"P", "Q" ,"R" ,"S")

for (Block1 in Block_list) {
  test_block_pred<-main(Train_data,Block1,Test_data,need_column,calculate_by_sld)
  test_pred<-rbind(test_pred,test_block_pred)
}





