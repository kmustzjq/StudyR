##
# Feature Selection ¡§C Ten Effective Techniques with Examples
##

# 1. Boruta
# 2. Variable Importance from Machine Learning Algorithms
# 3. Lasso Regression
# 4. Step wise Forward and Backward Selection
# 5. Relative Importance from Linear Regression
# 6. Recursive Feature Elimination (RFE)
# 7. Genetic Algorithm
# 8. Simulated Annealing
# 9. Information Value and Weights of Evidence
# 10. DALEX Package


# 1. Boruta

# Boruta is a feature ranking and selection algorithm based on random forests algorithm.
library(dplyr,warn.conflicts = F)
trainData <- combine_ML_predictor_and_response_data1 %>% filter(BLOCK %in% "A" & ROW %in% "01") %>% na.omit()
trainData1 <- trainData[,5:26]

index2 <- findCorrelation(cor(trainData1[,1:21]),cutoff = 0.5,names = T)
trainData2 <- trainData1[,-which(names(trainData1) %in% index2)]

# install.packages('Boruta')
library(Boruta)
# Perform Boruta search
boruta_output <- Boruta(delta_EWAC ~ ., data=trainData2 , doTrace=0)
# boruta_output <- Boruta(Species ~ ., data=na.omit(iris), doTrace=0)
names(boruta_output)

# Get significant variables including tentatives
boruta_signif <- getSelectedAttributes(boruta_output, withTentative = TRUE)
print(boruta_signif)  



# Do a tentative rough fix
roughFixMod <- TentativeRoughFix(boruta_output)
boruta_signif <- getSelectedAttributes(roughFixMod)
print(boruta_signif)
# Variable Importance Scores
imps <- attStats(roughFixMod)
imps2 = imps[imps$decision != 'Rejected', c('meanImp', 'decision')]
head(imps2[order(-imps2$meanImp), ])  # descending sort
# Plot variable importance
plot(boruta_output, cex.axis=.7, las=2, xlab="", main="Variable Importance") 



# 2. Variable Importance from Machine Learning Algorithms
# Train an rpart model and compute variable importance.
library(caret)
set.seed(100)
# rPartMod <- train(Class ~ ., data=trainData, method="rpart")
rPartMod <- train(delta_EWAC ~ ., data=trainData1, method="rpart")
rpartImp <- varImp(rPartMod)
print(rpartImp)


