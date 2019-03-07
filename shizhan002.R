vars<-c("mpg","hp","wt")
head(mtcars[vars])

summary(mtcars)
var(mtcars)
sapply(mtcars, var)
sapply(mtcars, sd)

library(Hmisc)
describe(mtcars)

mtcars$am


library(vcd)
attach(Arthritis)
mytable<-xtabs(~Treatment+Improved,data=Arthritis)
chisq.test(mytable)





library(randomForest)
set.seed(4543)
data(mtcars)
mtcars.rf <- randomForest(mpg ~ ., data=mtcars, ntree=1000,
                          keep.forest=FALSE, importance=TRUE)
summary(mtcars.rf)
importance(mtcars.rf)
importance(mtcars.rf, type=1)


states<-state.x77[,1:6]
cov(states)
cor(states,method = "spearman")


library(psych)
corr.test(states,use = "complete")
