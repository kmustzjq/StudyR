library(methods,warn.conflicts = F)
library(DBI,warn.conflicts = F)
library(RMariaDB,warn.conflicts = F)
library(dplyr,warn.conflicts = F)
library(iterators)
library(parallel)
library(foreach)
library(doParallel)
suppressMessages(library(caret,warn.conflicts = F))

model_data <- train_data
train_data <- model_data[1:100,]
test_data <- model_data[101:115,]


rm(list = ls(name = foreach:::.foreachGlobals),envir =  foreach:::.foreachGlobals)
core1 <- makeCluster(14)
registerDoParallel(core1)
set.seed(0)

# train_data[response_name]
rfgrid <- expand.grid(.mtry=c(4,8,12,14,16,20))
randomforestmodel <- train(x = train_data[-1],y=as.numeric(unlist(train_data[response_name])),
                           # data=train_data,
                           method="rf",
                           ntree=35,
                           tuneGrid=rfgrid,
                           trControl=trainControl(method = "cv",number = 5,allowParallel = T,savePredictions = "all")
)
test_data$randomforest_predict <- predict(randomforestmodel,newdata = test_data)
R2(test_data$randomforest_predict,test_data$`2P_BER`)


lmmodel <- train(x = train_data[-1],y=as.numeric(unlist(train_data[response_name])),
                 data=train_data,
                 method="lm",
                 preProcess=c("center","scale"),
                 trControl=trainControl(method = "cv",number = 2,allowParallel = T,savePredictions = "all")
)
test_data$lm_predict <- predict(lmmodel,newdata = test_data)
R2(test_data$lm_predict,test_data$`2P_BER`)


# elastic network
enetgrid <- expand.grid(.fraction=seq(0.1,0.9,0.2),.lambda=c(0.01,0.1,1))
enetmodel <- train(x = train_data[-1],y=as.numeric(unlist(train_data[response_name])),
                   data=train_data,
                   method="enet",
                   preProcess=c("center","scale"),
                   tuneGrid = enetgrid,
                   trControl=trainControl(method = "cv",number = 5,allowParallel = T,savePredictions = "all")
)
test_data$enet_predict <- predict(enetmodel,newdata = test_data)
R2(test_data$enet_predict,test_data$`2P_BER`)


set.seed(0)
nnetgrid=expand.grid(size=c(5,10,15,20),decay=seq(from = 0.1, to = 0.5, by = 0.1))
nnetmodel <- train(response~.,
                     data=train_data,
                     method="nnet",
                     tuneGrid = nnetgrid,
                     trControl=trainControl(method = "cv",number = 10,allowParallel = T,savePredictions = "all")
)
test_data$nnet_predict <- predict(nnetmodel,newdata = test_data)
R2(test_data$nnet_predict,test_data$response)







set.seed(0)
treebagodel <- train(x = train_data[-1],y=as.numeric(unlist(train_data[response_name])),
                     method="treebag",
                     nbagg=15,
                     trControl=trainControl(method = "cv",number = 5,allowParallel = T,savePredictions = "all")
)
test_data$treebag_predict <- predict(treebagodel,newdata = test_data)
R2(test_data$treebag_predict,test_data$`2P_BER`)






set.seed(0)
xgbTreegrid <- expand.grid(nrounds=c(30,50),
                           max_depth=c(4:8),
                           eta =c(0.01),gamma=0,
                           colsample_bytree=0.7,min_child_weight=1,
                           subsample=1)
xgbTreemodel <- train(x = train_data[-1],y=as.numeric(unlist(train_data[response_name])),
                      method="xgbTree",
                      tuneGrid = xgbTreegrid,
                      verbose=TRUE,
                      trControl=trainControl(method = "cv",number = 5,allowParallel = T,savePredictions = "all"),
)
test_data$xgbTree_predict <- predict(xgbTreemodel,test_data)
R2(test_data$xgbTree_predict,test_data$response)

stopCluster(core1)
