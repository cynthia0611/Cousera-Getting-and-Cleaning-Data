# Q1
setwd("G:/Data Science Speciality Track/Getting and Cleaning Data/week3")
if(!file.exists("./data")){dir.create("./data")}
url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url,destfile="./data/microdata.csv")
microdata<-read.csv("./data/microdata.csv")
head(microdata,n=1)
str(microdata)
# households on greater than 10 acres 
# who sold more than $10,000 worth of agriculture products.
agricultureLogical<-microdata$ACR == 3 & microdata$AGS == 6
which(agricultureLogical)[1:3]
#[1] 125 238 262

# Q2
library(jpeg)
if(!file.exists("./data")){dir.create("./data")}
url="https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url,destfile="./data/q2.jpg",mode = "wb")
q2jpg<-readJPEG("./data/q2.jpg",native = TRUE)
quantile(q2jpg,probs=c(0.3,0.8))
# 30%       80% 
# -15259150 -10575416 

# Q3
getwd()

library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(), "GDP.csv")
download.file(url, f)
dtGDP <- data.table(read.csv(f, skip = 4, nrows = 215))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                               "Long.Name", "gdp"))
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "EDSTATS_Country.csv")
download.file(url, f)
dtEd <- data.table(read.csv(f))
dt <- merge(dtGDP, dtEd, all = TRUE, by = c("CountryCode"))
sum(!is.na(unique(dt$rankingGDP)))
#[1] 189
dt[order(rankingGDP, decreasing = TRUE), list(CountryCode, Long.Name.x, Long.Name.y, 
                                              rankingGDP, gdp)][13]
#CountryCode         Long.Name.x         Long.Name.y rankingGDP   gdp
#1:         KNA St. Kitts and Nevis St. Kitts and Nevis        178  767

# Q4
# average GDP ranking for the "High income: OECD" and "High income: nonOECD" group
dt[, mean(rankingGDP, na.rm = TRUE), by = Income.Group]
# Income.Group        V1
# 1: High income: nonOECD  91.91304
# 2:           Low income 133.72973
# 3:  Lower middle income 107.70370
# 4:  Upper middle income  92.13333
# 5:    High income: OECD  32.96667
# 6:                   NA 131.00000
# 7:                            NaN

# Q5
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
# How many countries are Lower middle income but among the 38 nations with highest GDP?
breaks <- quantile(dt$rankingGDP, probs = seq(0, 1, 0.2), na.rm = TRUE)
dt$quantileGDP <- cut(dt$rankingGDP, breaks = breaks)
dt[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantileGDP")]
# Income.Group quantileGDP  N
# 1: Lower middle income (38.8,76.6] 13
# 2: Lower middle income   (114,152]  8
# 3: Lower middle income   (152,190] 16
# 4: Lower middle income  (76.6,114] 12
# 5: Lower middle income    (1,38.8]  5
# 6: Lower middle income          NA  2

# Reference: https://github.com/benjamin-chan/GettingAndCleaningData/blob/master/Quiz3/quiz3.md


