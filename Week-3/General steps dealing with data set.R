##Subsetting and sorting
#Subsetting - quick review
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA
X

#Subsetting - quick review
X[,1]
X[,"var1"]
X[1:2,"var2"]
Logicals ands and ors

X[(X$var1 <= 3 & X$var3 > 11),]
X[(X$var1 <= 3 | X$var3 > 15),]

#Dealing with missing values
X[which(X$var2 > 8),]

#Sorting
sort(X$var1)
sort(X$var1,decreasing=TRUE)
sort(X$var2,na.last=TRUE)

#Ordering
X[order(X$var1),]

X[order(X$var1,X$var3),]

#Ordering with plyr
library(plyr)
arrange(X,var1)
arrange(X,desc(var1))

#Adding rows and columns
X$var4 <- rnorm(5)
X

#Adding rows and columns
Y <- cbind(X,rnorm(5))
Y

## summarizingData
# Getting the data from the web
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")

#Look at a bit of the data
head(restData,n=3)
tail(restData,n=3)

#More in depth information
str(restData)

#Quantiles of quantitative variables
quantile(restData$councilDistrict,na.rm=TRUE)
quantile(restData$councilDistrict,probs=c(0.5,0.75,0.9))

#Make table
table(restData$zipCode,useNA="ifany")
table(restData$councilDistrict,restData$zipCode)

#Check for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)

#Row and column sums
colSums(is.na(restData)
all(colSums(is.na(restData))==0)

#Values with specific characteristics
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212","21213"))
restData[restData$zipCode %in% c("21212","21213"),]

#Cross tabs
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit,data=DF)
xt

#Flat tables
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~.,data=warpbreaks)
xt

ftable(xt)

#Size of a data set
fakeData = rnorm(1e5)
object.size(fakeData)

print(object.size(fakeData),units="Mb")

## Creating new variables
#Creating sequences

s1 <- seq(1,10,by=2) ; s1
s2 <- seq(1,10,length=3); s2
x <- c(1,3,8,25,100); seq(along = x)

#Subsetting variables
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

#Creating binary variables
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong,restData$zipCode < 0)

#Creating categorical variables
restData$zipGroups = cut(restData$zipCode,breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups,restData$zipCode)

#Easier cutting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)

#Creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

#Levels of factor variables
yesno <- sample(c("yes","no"),size=10,replace=TRUE)
yesnofac = factor(yesno,levels=c("yes","no"))
relevel(yesnofac,ref="yes")
as.numeric(yesnofac)

#Cutting produces factor variables
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)

#Using the mutate function
library(Hmisc); library(plyr)
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)

#Common transforms
abs(x) absolute value
sqrt(x) square root
ceiling(x) ceiling(3.475) is 4
floor(x) floor(3.475) is 3
round(x,digits=n) roun(3.475,digits=2) is 3.48
signif(x,digits=n) signif(3.475,digits=2) is 3.5
cos(x), sin(x) etc.
log(x) natural logarithm
log2(x), log10(x) other common logs
exp(x) exponentiating x

## Reshaping data
#Start with reshaping
library(reshape2)
head(mtcars)

#Melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
head(carMelt,n=3)
tail(carMelt,n=3)

#asting data frames
cylData <- dcast(carMelt, cyl ~ variable)
cylData
cylData <- dcast(carMelt, cyl ~ variable,mean)
cylData

#Averaging values
head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum)

#split
spIns =  split(InsectSprays$count,InsectSprays$spray)
spIns

#apply
sprCount = lapply(spIns,sum)
sprCount

#combine
unlist(sprCount)
sapply(spIns,sum)

#plyr package
ddply(InsectSprays,.(spray),summarize,sum=sum(count))

#Creating a new variable
spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))
dim(spraySums)
head(spraySums)

##Merging data
#Peer review data
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews = read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)

#Merging data - merge()
# Merges data frames
# Important parameters: x,y,by,by.x,by.y,all
names(reviews)
names(solutions)

#Merging data - merge()
mergedData = merge(reviews,solutions,by.x="solution_id",by.y="id",all=TRUE)
head(mergedData)

#Default - merge all common column names
intersect(names(solutions),names(reviews))
mergedData2 = merge(reviews,solutions,all=TRUE)
head(mergedData2)

#Using join in the plyr package
Faster, but less full featured - defaults to left join 
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id)

#If you have multiple data frames
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3)
join_all(dfList)

