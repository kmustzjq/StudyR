attach(mtcars)
plot(wt,mpg)
abline(lm(mpg~wt))
title("regression of MPG of weight")
detach(mtcars)


dose<-c(20,30,40,45,60)
drugA<-c(16,20,27,40,60)
drugB<-c(15,18 25,31,40)
opar<-par(no.readonly = True)
par(lwd=2,cex=1.5,font.lab=2)
plot(dose,drugA,type='b',pch=15,lty=1,col="red",ylim=c(0,60),main="Drug A vs . Drug B",xlab="Drug Dosage",ylab="Drug Response")


attach(mtcars)
opar<-par(no.readonly = TRUE)
par(mfrow=c(2,2))
plot(wt,mpg,main="scatterplot of wt vs .mpg")
plot(wt,disp,main = "scatterplot of wt vs disp")
hist(wt,main="histogram of wt")
boxplot(wt,main="Boxplot of wt")
par(opar)
detach(mtcars)


attach(mtcars)
layout(matrix(c(1,1,2,3),nrow = 2,ncol = 2,byrow = TRUE))
hist(wt)
hist(mpg)
hist(disp)
detach(mtcars)


manager<-c(1,2,3,4,5)
date<-c("10/24/08","10/28/08","10/1/08","10/12/08","5/1/09")
country<-c("us","us","uk","uk","uk")
gender<-c("M","F","F","M","F")
age<-c(32,45,25,39,99)
q1<-c(5,3,3,3,2)
q2<-c(4,5,5,3,2)
q3<-c(5,2,5,4,1)
q4<-c(5,5,5,NA,2)
q5<-c(5,5,2,NA,1)
leadership<-data.frame(manager,date,country,gender,age,q1,q2,q3,q4,q5,stringsAsFactors = FALSE)
fix(leadership)
is.na(leadership[,6:10])
newdata<-na.omit(leadership)

newdata1<-leadership[order(gender,age)]
newdata2<-leadership[order(gender,age),]
newdata3<-subset(leadership,age>35|age<24,select = c(q1,q2,q3,q4,q5))

mydata<-data.frame(x1=c(2,2,6,4),x2=c(3,4,2,8))
mydata<-transform(mydata,sumx=x1+x2,meanx=(x1+x2)/2)
mydata

mysample<-leadership[sample(1:nrow(leadership),3,replace=FALSE),]





library(sqldf)
newdf<-sqldf("select * from mtcars where carb<3 order by cyl,mpg",row.names = TRUE)
newdf




library(MASS)
options(digits = 3)
set.seed(12)
mean1<-c(230.7,146.7,3.6)
sigma<-matrix(c(15360.8,6721.2,-47.1,6721.2,4700.9,-16.5,-47.1,-16.5,0.3),ncol = 3,nrow = 3,byrow = FALSE)
mydata1<-mvrnorm(500,mean1,sigma)
mydata1<-as.data.frame(mydata1)
names(mydata1)<-c("y","x1","x2")
head(mydata1,n=10)






madata<-function(type="long"){
  switch (type,
    long = format(Sys.time(),"%A %B %d %Y"),
    short = format(Sys.time(),"%m-%d-%Y"),
    cat(type,"is not a recognized type")
    )
}


madata("short")


options(digits = 3)
attach(mtcars)
aggdata<-aggregate(mtcars,by = list(cyl,gear,vs),FUN = mean, NA.rm=true)
aggdata

head(mtcars,n=10)







ID<-c(1,1,2,2)
Time<-c(1,2,1,2)
x1<-c(5,3,6,2)
x2<-c(6,5,1,4)
x<-cbind(ID,Time,x1,x2)
mydata001<-as.data.frame(x,row.names = c(ID,Time,x1,x2))


library(reshape)
md<-melt(mydata001,id=(c("ID","Time")))



barplot(tableipl)









library(vcd)
counts<-table(Arthritis$Improved)
counts1<-table(Arthritis$Improved,Arthritis$Treatment)
barplot(counts1,main = "stacked bar plot",xlab = "Treatment",ylab = "frequency",beside =T,legend = rownames(counts),col = c("red" ,"pink", "blue"))

barplot(counts,main = "simple bar plot",xlab = "improvement ",ylab = "frequency",horiz = TRUE)




library(corrplot)
corr <- cor(mtcars[,1:7])
corrplot(corr = corr,order = "AOE")
var(mtcars[,1:7])
mean(corr,0)
