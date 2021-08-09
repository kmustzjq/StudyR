library(lightgbm)
waferlist <- waferaaa
EWAC_train_MG08 <- EVANSBP_Train1 %>% 
  filter(WAFER %in% waferlist[1:60]) %>% 
  select(-c("WAFER","ROW","SLD_NO")) 
EWAC_Verificaiton_MG08 <- EVANSBP_Train1 %>% filter(WAFER %in% waferlist[61:82])


train_data = as.data.frame(EWAC_train_MG08)
test_data = as.data.frame(EWAC_Verificaiton_MG08)
varList = need_column


library(data.table)
library(lightgbm)

train = as.matrix(train_data[, varList])
test = as.matrix(test_data[, varList])

dtrain = lightgbm::lgb.Dataset(train, label = train_data$delta_WPE)
lightgbm::lgb.Dataset.construct(dtrain)

dtest = lightgbm::lgb.Dataset.create.valid(dtrain, test, label = test_data$delta_WPE)
valids = list(test = dtest)

params = list(objective = "regression", 
              metric= "mse", 
              #device= "gpu",
              feature_fraction = 0.8,
              bagging_fraction = 0.8,
              bagging_freq = 100,
              feature_fraction_seed = 451,
              bagging_fraction_seed = 42)
# lambda_l2 = 0.6,
# lambda_l1 = 0.6)


model_final = lightgbm::lgb.train(params, 
                                  dtrain, 
                                  nrounds = 500, 
                                  valids, 
                                  verbose = 1, 
                                  learning_rate  = 0.01, 
                                  early_stopping_rounds = 50) 

feature_importance = lgb.importance(model_final)
# lgb.save(model_final, file = "model_data/model_lgb_delta_SSEB_EWI_MG08.Rdata")
# [13886]:	test's l2:21.3743 
pre_train = predict(model_final, test)
cor(pre_train, test_data$delta_WPE)^2

# caret::R2(pre_train,train_data$delta_WPE)
# [1] 0.2786628