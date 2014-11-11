
    > fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    > download.file(fileUrl, destfile="./data/microdata.csv", method="curl")
    > microData <- read.table("./data/microdata.csv", sep=",", header=TRUE)
    > sum(!is.na(microData$VAL[microData$VAL==24]))
    > [1] 53
    
    
----------------------------------------------------------------------------    
    
    
    
    > list.files("./")
    > microData <- read.table("./data.csv", sep=",", header=TRUE)
    > head(microData)
    > dim(microData) # 6496x188
    > sum(!is.na(microData$VAL[microData$VAL==24])) # 53




