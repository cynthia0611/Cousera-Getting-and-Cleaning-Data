#Getting and Cleaning Data
# Week 1 Note

# W1 Downloading files
# Download Files
setwd("G:/Data Science Speciality Track/Getting and Cleaning Data/week2")
getwd()
if(!file.exists("data")){
  dir.create("data")
}

list.files()

# download Baltimore camera data 
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.csv")
list.files("./data") # [1] "cameras.csv"
dateDownloaded <- date()
dateDownloaded
-----------------------------------------------------------------------------------------------------------------------------
# Reading Local Flat Files
# read.table(), parameters: file, header,sep,row.names,nrow
cameraData <- read.table("./data/cameras.csv", sep=",", header=TRUE)
head(cameraData)
# if using read.csv, default setting is sep=",", header=TRUE
# other parameter:quote, na.strings, nrows, skip
-----------------------------------------------------------------------------------------------------------------------------
#Reading Excel Files
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.xlsx")
dateDownloaded <- date()

# set up java_home variable
Sys.setenv(JAVA_HOME='C://Program Files//Java//jdk1.7.0_40//jre')

# xlsx package
library(xlsx)
list.files()
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, header=TRUE)
head(cameraData)

list.files("./data")#[1] "cameras.csv"  "cameras.xlsx"

# Reading specific rows and columns
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, colIndex=colIndex, rowIndex=rowIndex)
cameraDataSubset
-----------------------------------------------------------------------------------------------------------------------------
# W1 Reading XML
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
# parse this XML page
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
doc
# rootnode is the wrapper of the entire doc
rootNode <- xmlRoot(doc)
rootNode
# give the name to the rootnode
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
rootNode[[1]][[1]]
# loop and give the xmlValue to each element
xmlSApply(rootNode, xmlValue)
# Get the items on the menu and prices
# takes out all the name/price/description``` content
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)
xpathSApply(rootNode, "//description", xmlValue)
xpathSApply(rootNode, "//calories", xmlValue)

## Reading/Extract content by attributes
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal=TRUE)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores
teams
-----------------------------------------------------------------------------------------------------------------------------
# Joson
> library(jsonlite)
jsondata<- fromJSON("https://api.github.com/users/jtleek/repos")
# get the name of Json data frame
names(jsondata)
# subset with data names
names(jsondata$owner)
# get data subset under the attribute of owner
jsondata$owner$login
# focus on the created_at subset
jsondata$created_at
# Writing data frames to JSON
myjson<- toJSON(iris,pretty=TRUE)
# print result using cat() function
# because here are text variables, so we use cat()
cat(myjson)
# Convert back to JSON
iris2<- fromJSON(myjson)
class(iris2)#data frame
head(iris2)
