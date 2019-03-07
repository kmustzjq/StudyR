# Create a vector.
#x <- c(12,7,3,4.2,18,2,54,-21,8,-5)
x<-c(1,2,3,4,5,6,-7,8,-9,-10)
# Find Mean.
result.mean <-mean(x,trim=0.3)
print(result.mean)
result.mean1 <- mean(x,trim=0.1)
print(result.mean1)
result.mean2 <- mean(x)
print(result.mean2)



# Create the function.
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
# Create the vector with numbers.
v <- c(2,1,1,3,1,2,3,4,1,5,5,3,2,3)
# Calculate the mode using the user function.
result <- getmode(v)
print(result)
# Create the vector with characters.
charv <- c("o","it","the","it","it")
# Calculate the mode using the user function.
result <- getmode(charv)
print(result)

#一元回归
x <- c(151, 174, 138, 186, 128, 136, 179, 163, 152, 131)
y <- c(63, 81, 56, 91, 47, 57, 76, 72, 62, 48)
# Apply the lm() function.
relation <- lm(y~x)
print(relation)


# Create the predictor and response variable.
x <- c(151, 174, 138, 186, 128, 136, 179, 163, 152, 131)
y <- c(63, 81, 56, 91, 47, 57, 76, 72, 62, 48)
relation <- lm(y~x)
# Give the chart file a name.
png(file = "linearregression.png")
# Plot the chart.
plot(y,x,col="blue",main="Height & Weight Regression",
     abline(lm(x~y)),cex = 1.3,pch=16,xlab="Weight in Kg",ylab="Height in cm")
# Save the file.
dev.off()


#方差分析
aa=read.csv(file='data.txt',header = TRUE)
result <- aov(mpg~hp*am,data=aa)
print(summary(result))
result1<- aov(mpg~hp+am,data=aa)
print(summary(result1))
print(anova(result,result1))

#时间序列分析
# Get the data points in form of a R vector.
rainfall1 <- c(799,1174.8,865.1,1334.6,635.4,918.5,685.5,998.6,784.2,985,882.8,1071)
rainfall2 <- c(655,1306.9,1323.4,1172.2,562.2,824,822.4,1265.5,799.6,1105.6,1106.7,1337.8)
# Convert them to a matrix.
combined.rainfall <-  matrix(c(rainfall1,rainfall2),nrow=12)
# Convert it to a time series object.
rainfall.timeseries <- ts(combined.rainfall,start=c(2012,5),frequency=12)
# Print the timeseries data.
print(rainfall.timeseries)
# Give the chart file a name.
png(file = "rainfall_combined.png")
# Plot a graph of the time series.
plot(rainfall.timeseries, main = "Multiple Time Series")
# Save the file.
dev.off()





