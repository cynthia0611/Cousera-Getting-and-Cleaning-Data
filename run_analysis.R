#Project Script
#Set directory path
#setwd("F:/Data Science Speciality Track/Getting and Cleaning Data/Project/UCI HAR Dataset")

#Requirement 1:  Merges the training and the test sets to create one data set.
#Read the activity files
trainLabel <- read.table("./train/y_train.txt")
table(trainLabel)
testLabel <- read.table("./test/y_test.txt") 
table(testLabel)

#Read the data files.
trainData <- read.table("./train/X_train.txt")
dim(trainData) # 7352*561
head(trainData)
testData <- read.table("./test/X_test.txt")
dim(testData) # 2947*561

#Read the subject files.
trainSubject <- read.table("./train/subject_train.txt")
testSubject <- read.table("./test/subject_test.txt")

#Merge the training and the test sets
#Concatenate the data tables.
joinData <- rbind(trainData, testData)
dim(joinData) # 10299*561
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) # 10299*1
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) # 10299*1

#Requirement 2:Extracts only the measurements on the mean and standard 
# deviation for each measurement.
features <- read.table("./features.txt")
dim(features)  # 561*2
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) # 66
joinData <- joinData[, meanStdIndices]
dim(joinData) # 10299*66
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 


#Requirement 3: Uses descriptive activity names to name the activities in the data set 
activity <- read.table("./activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))#gsub:replace function 
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

#Requirement 4: Appropriately labels the data set with descriptive activity names.
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData) # 10299*68
write.table(cleanedData, "merged_data.txt") # write out the 1st dataset

#Requirement 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subjectLen <- length(table(joinSubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleanedData$subject
    bool2 <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}
head(result)
write.table(result, "data_with_means.txt") # write out the 2nd dataset

data <- read.table("./data_with_means.txt")
data[1:12, 1:3]



