####Question 1

   The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 

and load the data into R. The code book, describing the variable names is here:

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
   dim(microData) # 6496x188
   sum(!is.na(microData$VAL[microData$VAL==24])) 
   #[1] 53

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
----------------------------------------------------------------------------    





