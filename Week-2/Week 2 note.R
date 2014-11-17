# Getting and Cleaning Data W2 Note
######### Reading from MySQL
# first one option is connect with RODBC
library(RODBC)
channel <- odbcConnect("mysql_data", uid="root", pwd="s*******1")
sqlTables(channel)# Check out tables in that database
data<-sqlFetch(channel,"user")# get table from database and save as dataframe
data
# second option is install RMySQL package in R
# but need to change the settings in R/RTools install path and MySQL Server path
install.packages('RMySQL',type='source')
install.packages('DBI')
# it should like this to tell you installation successfully
# MYSQL_HOME defined as C:/Program Files/MySQL/MySQL Server 5.6 
# * DONE (RMySQL)

library(RMySQL)
# database name: MySQL, user and host get from the provider's instruction
ucscDb<-dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")
# get query
result<-dbGetQuery(ucscDb,"show databases;");dbDisconnect(ucscDb);
# [1] TRUE for disconnect
# show databases; is the command line in MySQL Client cmd
# every time get out the tables which you need, disconnect with database
result
# get one particular database hg19
hg19<-dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables<-dbListTables(hg19)
# get the size of this database
length(allTables)#[1] 11015
allTables[1:5]
# get dimensions of a specific table, column names
dbListFields(hg19,"affyU133Plus2")
# count how many row using MySQL commend select count(*)
dbGetQuery(hg19,"select count(*) from affyU133Plus2") #  count(*) #1    58463
# read from the table
affyData<-dbReadTable(hg19,"affyU133Plus2")
head(affyData)
# select a specific subset
query<-dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis<-fetch(query);quantile(affyMis$misMatches)
#   0%  25%  50%  75% 100% 
#    1    1    2    2    3
affMisSmall<-fetch(query,n=10);dbClearResult(query);#after query, clean result
# [1] TRUE
dim(affMisSmall)#[1] 10 22
dbDisconnect(hg19)

########HDF5
# used for storing large data sets
# HDF = heirachical data format
# groups: group header + group symbol
# datasets: header + data array
source("http://bioconductor.org/biocLite.R")# allow to use biocLite function
biocLite("rhdf5")#get rhdf5 package

library(rhdf5)
created = h5createFile("example.h5")#create rhdf5 files
created
# create groups
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")
#   group   name     otype dclass dim
# 0     /    baa H5I_GROUP           
# 1     /    foo H5I_GROUP           
# 2  /foo foobaa H5I_GROUP
# write to groups
A = matrix(1:10,nr=5,nc=2)
h5write(A,"example.h5","foo/A")# write matrix A into group foo/A which is in the file example.h5
B=array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B,"scale")<-"liter" #add a new attribute in to array B
h5write(B,"example.h5","foo/foobaa/B")
h5ls("example.h5")
# write a data set
df<-data.frame(1L:5L,seq(0,1,length.out=5),c("ab","cde","fghi","a","s"),stringAsFactors = FALSE)
h5write(df,"example.h5","df")# write to top level group data frmae df
h5ls("example.h5")
# reading data
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf = h5read("example.h5","df")
readA
readdf
# writing and reading chunks
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))# write into first 3 rows,first column
# write to a sepecifc part which is defined with index
h5read("example.h5","foo/A",index=list(1:3,1))
h5read("example.h5","foo/A")
#       [,1] [,2]
# [1,]   12    6
# [2,]   13    7
# [3,]   14    8
# [4,]    4    9
# [5,]    5   10

################Reading data from the Web
# HTML
# getting data off webgages - readLines()
# create connect with url()functions
con<-url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode
# parsing with XML
library(XML)
require(XML)
url<-"http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html<-htmlTreeParse(url,useInternalNodes=T)
xpathSApply(html,"//title",xmlValue)
# [1] "Jeff Leek - Google Scholar Citations"

xpathSApply(html,"//td[@id='col-citedby']",xmlValue)
# just get return empty result with list(), how to fix here

# get from the httr package
library(httr)
html2=GET(url)# another way to get html with the same url defined above
content2 = content(html2,as="text")#struct content as text
parsedHtml = htmlParse(content2,asText = TRUE)#it should be the same as using XML package
xpathSApply(parsedHtml,"//title",xmlValue)
xpathSApply(parsedHtml,"//td[@id='col-citedby']",xmlValue)#invalid again
# accessing websites with passwords
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")#get login page
pg1

pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd"))#get login page with authenticate fuctions

pg2
names(pg2)
google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")



