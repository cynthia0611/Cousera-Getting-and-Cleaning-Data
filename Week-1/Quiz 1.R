# Question 1
# set up defualt directory
  setwd('H:/Desktop/Data Specialist/Getting Cleaning Data/week 1')
  getwd()
  # set the url path
  fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
  # download file
  download.file(fileUrl, destfile="./data.csv")

  list.files("./")
  microData <- read.table("./data.csv", sep=",", header=TRUE)
  head(microData)
  dim(microData) 
  # 6496x188
  sum(!is.na(microData$VAL[microData$VAL==24])) 
  #[1] 53

#Question 2
setwd('G:/Data Science Speciality Track/Getting and Cleaning Data/week1/quiz1')
getwd()
# fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
# download.file(fileurl,destfile="./ngap.xlsx")
Sys.setenv(JAVA_HOME='C://Program Files//Java//jdk1.7.0_40//jre')
library(xlsx)
list.files()
ngapdata<-read.xlsx("./ngap.xlsx",sheetIndex=1,header=TRUE)
colIndex<-7:15
rowIndex<-18:23

dat<-read.xlsx("./ngap.xlsx",sheetIndex=1, colIndex=colIndex, rowIndex=rowIndex)

sum(dat$Zip*dat$Ext,na.rm=T) 
# [1] 36534720

# Qeustion 4
library(XML)
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
balRes<-xmlTreeParse(fileUrl, useInternal=TRUE)
balRes
rootNode<-xmlRoot(balRes)
xmlName(rootNode)
names(rootNode)
sum(xpathSApply(rootNode, "//zipcode", xmlValue)==21231)
# 127

# Qeustion 5
library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./microdata3.csv")
# fread() is a function with the data.table packge
DT <- fread("./microdata3.csv")
file.info("./microdata3.csv")$size
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15))+system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(rowMeans(DT)[DT$SEX==1])+system.time(rowMeans(DT)[DT$SEX==2]
)
