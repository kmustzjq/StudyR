library(pmml)
model0 <- lm(Sepal.Length~., data=iris[,-5])
model.pmml <- pmml(model0)
saveXML(model.pmml,"linear regression model.pmml")
