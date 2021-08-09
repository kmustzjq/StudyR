##
# Feature Selection ¨C Ten Effective Techniques with Examples
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

# install.packages('Boruta')
library(Boruta)
# Perform Boruta search
# boruta_output <- Boruta(Class ~ ., data=na.omit(trainData), doTrace=0)
boruta_output <- Boruta(Species ~ ., data=na.omit(iris), doTrace=0)
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
rPartMod <- train(Species ~ ., data=na.omit(iris), method="rpart")
rpartImp <- varImp(rPartMod)
print(rpartImp)


# Train an RRF model and compute variable importance.
set.seed(100)
rrfMod <- train(Species ~ ., data=na.omit(iris), method="RRF")
rrfImp <- varImp(rrfMod, scale=F)
rrfImp



# 3. Lasso Regression
# 4. Step wise Forward and Backward Selection

# 6.Recursive Feature Elimination (RFE)

set.seed(100)
options(warn=-1)

subsets <- c(1:5, 10, 15, 18)

ctrl <- rfeControl(functions = rfFuncs,
                   method = "repeatedcv",
                   repeats = 5,
                   verbose = FALSE)

lmProfile <- rfe(x=trainData[, c(1:3, 5:13)], y=trainData$ozone_reading,
                 sizes = subsets,
                 rfeControl = ctrl)

lmProfile





# 9. Information Value and Weights of Evidence

# Choose Categorical Variables to compute Info Value.
cat_vars <- c ("WORKCLASS", "EDUCATION", "MARITALSTATUS", "OCCUPATION", "RELATIONSHIP", "RACE", "SEX", "NATIVECOUNTRY")  # get all categorical variables

# Init Output
df_iv <- data.frame(VARS=cat_vars, IV=numeric(length(cat_vars)), STRENGTH=character(length(cat_vars)), stringsAsFactors = F)  # init output dataframe

# Get Information Value for each variable
for (factor_var in factor_vars){
  df_iv[df_iv$VARS == factor_var, "IV"] <- InformationValue::IV(X=inputData[, factor_var], Y=inputData$ABOVE50K)
  df_iv[df_iv$VARS == factor_var, "STRENGTH"] <- attr(InformationValue::IV(X=inputData[, factor_var], Y=inputData$ABOVE50K), "howgood")
}

# Sort
df_iv <- df_iv[order(-df_iv$IV), ]

df_iv

WOETable(X=inputData[, 'WORKCLASS'], Y=inputData$ABOVE50K)



# 7. Genetic Algorithm
# Define control function
ga_ctrl <- gafsControl(functions = rfGA,  # another option is `caretGA`.
                       method = "cv",
                       repeats = 3)

# Genetic Algorithm feature selection
set.seed(100)
ga_obj <- gafs(x=trainData[, c(1:3, 5:13)], 
               y=trainData[, 4], 
               iters = 3,   # normally much higher (100+)
               gafsControl = ga_ctrl)

ga_obj
# Optimal variables
ga_obj$optVariables



# 8. Simulated Annealing

# Define control function
sa_ctrl <- safsControl(functions = rfSA,
                       method = "repeatedcv",
                       repeats = 3,
                       improve = 5) # n iterations without improvement before a reset

# Genetic Algorithm feature selection
set.seed(100)
sa_obj <- safs(x=trainData[, c(1:3, 5:13)], 
               y=trainData[, 4],
               safsControl = sa_ctrl)

sa_obj

# Optimal variables
print(sa_obj$optVariables)
