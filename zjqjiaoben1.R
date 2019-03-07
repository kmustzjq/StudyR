x=1:100
z=sample(x,100,rep=T)
xz=setdiff(x,z)#找不同
xz
tt=sort(union(xz,z))#结合，联合   并集
tt
tz=intersect(1:10,7:50)#交集
tz
pi * 10^2 #能够用?”*”来看基本算术运算方法
"*"(pi, "^"(10, 2))
pi * (1:10)^2
rt<-read.table('exam0203.txt',header = TRUE);rt
lm.sol<-lm(Weight~Height, data=rt);


v <- c(0,0,TRUE,2+2i)
t <- c(3,3,TRUE,2+3i)
print(v||t)
print(v&&t)



x <- switch(
  1,
  "first",
  "second",
  "third",
  "fourth"
)
print(x)













data <- read.csv("zhiyuan.csv")
print(data)

aa<-subset(data,salary>700)
print(aa)
ab<-subset(data,salary==max(salary))
print(ab)
write.csv(aa,'input.csv')
newdata<-read.csv("input.csv")
print(newdata)
install.packages(xlsx)


any(grepl("xlsx",installed.packages()))
library("xlsx")
data<-read.csv("qizhongkaoshi.csv")
print(data)





x<-read.table("clipboard")
write.table(x=x,file="clipboard",sep='\t')

x<-(1:10)^5
