Question 1
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 

and load the data into R. The code book, describing the variable names is here:

   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
   
    > fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    > download.file(fileUrl, destfile="./data/microdata.csv", method="curl")
    > microData <- read.table("./data/microdata.csv", sep=",", header=TRUE)
    > sum(!is.na(microData$VAL[microData$VAL==24]))
    > [1] 53
    
    
----------------------------------------------------------------------------    





