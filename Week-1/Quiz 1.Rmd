####Question 1

######The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 

######and load the data into R. The code book, describing the variable names is here:

   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
   
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

```
# refer to the parameter book about the VAL definition and details
# VAL 2
# Property value
# bb .N/A (GQ/rental unit/vacant, not for sale only)
# 01 .Less than $ 10000
# 02 .$ 10000 - $ 14999
# 03 .$ 15000 - $ 19999
# 04 .$ 20000 - $ 24999
# 05 .$ 25000 - $ 29999
# 06 .$ 30000 - $ 34999
# 07 .$ 35000 - $ 39999
# 08 .$ 40000 - $ 49999
# 09 .$ 50000 - $ 59999
# 10 .$ 60000 - $ 69999
# 11 .$ 70000 - $ 79999
# 12 .$ 80000 - $ 89999
# 13 .$ 90000 - $ 99999
# 14 .$100000 - $124999
# 15 .$125000 - $149999
# 16 .$150000 - $174999
# 17 .$175000 - $199999
# 18 .$200000 - $249999
# 19 .$250000 - $299999
# 20 .$300000 - $399999
# 21 .$400000 - $499999
# 22 .$500000 - $749999
# 23 .$750000 - $999999
# 24 .$1000000+
```

----------------------------------------------------------------------------    
####Question 2
######Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate? 

**Tidy data has one variable per column.**
```
Explanation
The tidy data:
1. each variable you measure should be in one column
2. each different observation of that variable should be in a different row
3. there should be one table for each "kind" of variable
4. if you have multiple tables, they should include a column in the table that allows them to be linked
5. include a row at the top each file with variable name
6. make variable names human readable AgeAtDiagnosis instead of AgeDx
7. in general data should be saved in one file per table
```
--------------------------------------------
####Question 3
######Download the Excel spreadsheet on Natural Gas Aquisition Program here:

      https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx

######Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:

       dat 

######What is the value of:

      sum(dat$Zip*dat$Ext,na.rm=T) 
```
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
```
-----------------------------------------------------------------
####Question 4
#####Read the XML data on Baltimore restaurants from here: 

      https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 

#####How many restaurants have zipcode 21231?
```
library(XML)
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
balRes<-xmlTreeParse(fileUrl, useInternal=TRUE)
balRes
rootNode<-xmlRoot(balRes)
xmlName(rootNode)
names(rootNode)
sum(xpathSApply(rootNode, "//zipcode", xmlValue)==21231)
```
----------------------------------------------------------------------------------
#####Question 5
#####The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 

      https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 

#####using the fread() command load the data into an R object
       DT 
#####Which of the following is the fastest way to calculate the average value of the variable
      pwgtp15 
#####broken down by sex using the data.table package?
```
library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./microdata3.csv")
DT <- fread("./microdata3.csv")
file.info("./microdata3.csv")$size
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15))+system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(rowMeans(DT)[DT$SEX==1])+system.time(rowMeans(DT)[DT$SEX==2]
)
```
