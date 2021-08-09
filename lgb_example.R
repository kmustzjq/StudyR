rm(list = ls())
gc()


suppressWarnings(library(lightgbm,warn.conflicts = F))
lgb.unloader(wipe = TRUE)
# \donttest{
data(agaricus.train, package = "lightgbm")
train <- agaricus.train
dtrain <- lgb.Dataset(train$data, label = train$label)

params <- list(
  objective = "binary"
  , learning_rate = 0.1
  , max_depth = -1L
  , min_data_in_leaf = 1L
  , min_sum_hessian_in_leaf = 1.0
)
model <- lgb.train(
  params = params
  , data = dtrain
  , nrounds = 5L
)
#> [LightGBM] [Info] Number of positive: 3140, number of negative: 3373
#> [LightGBM] [Warning] Auto-choosing row-wise multi-threading, the overhead of testing was 0.000963 seconds.
#> You can set `force_row_wise=true` to remove the overhead.
#> And if memory is not enough, you can set `force_col_wise=true`.
#> [LightGBM] [Info] Total Bins 232
#> [LightGBM] [Info] Number of data points in the train set: 6513, number of used features: 116
#> [LightGBM] [Info] [binary:BoostFromScore]: pavg=0.482113 -> initscore=-0.071580
#> [LightGBM] [Info] Start training from score -0.071580
#> [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
#> [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
#> [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
#> [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
#> [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
tree_imp1 <- lgb.importance(model, percentage = TRUE)

tree_imp2 <- lgb.importance(model, percentage = FALSE)
# }

