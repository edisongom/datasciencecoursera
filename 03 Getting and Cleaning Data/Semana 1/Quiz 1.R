# Q1

url1="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url1,destfile = "q1.csv",method = "curl")
data1=read.csv("q1.csv")
head(data1)
View(data1[,24])
q1=(data1["VAL"]==24)
summary(q1)

# Q2

unique(data1$FES)
str(data1$FES)

#Q3

url3="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url2,destfile = "q3.xlsx",method = "curl")

data3=read_xlsx("q3.xlsx", rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

# Q4
install.packages("XML")
library(XML)
url4="http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
q4 <- xmlTreeParse(url4, useInternalNodes = TRUE)
rootNode <- xmlRoot(q4)

names(rootNode)
rootNode[[1]][[1]][[2]] 

sum(xpathSApply(rootNode,"//zipcode",xmlValue) == 21231) #zip


#Q5
url5="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url5,destfile = "q5.csv",method = "curl")

library(data.table)
DT=fread("q5.csv")

system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15)) + system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
|