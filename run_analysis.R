#Getting and Cleaning Data - Assignment

#rm(list=ls())
#setwd("C:/Users/jwright/Documents/Coursera/3. Getting and Cleaning Data/Assignment")

#Downloading the data and extract from zip folder
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
name = "projdata.zip"
download.file(url, dest = name)
unzip(name)


#Reading in the metadata -------------------------------------------------------------------------------------------
activityLables <- read.table("./UCI HAR Dataset/activity_labels.txt")
featuresLables <- read.table("./UCI HAR Dataset/features.txt")
featuresLables <- as.character(featuresLables$V2)

#reformatting the features lables
featuresLables <- sub("-", "_" , featuresLables)
featuresLables <- gsub("\\()", "_" , featuresLables)
featuresLables <- gsub("-", "" , featuresLables)

#Reading in the test data -------------------------------------------------------------------------------------------
testSubj <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testSubj$group <- "test"
testX <- read.table("./UCI HAR Dataset/test/X_test.txt")
testY <- read.table("./UCI HAR Dataset/test/Y_test.txt")

#Combining test data
testdata <- cbind(testSubj, testY, testX)
colnames(testdata) <- c("subject", "group", "activity", names(testX))
#head(testdata)


#Reading in the training data ---------------------------------------------------------------------------------------
trainSubj <- read.table("./UCI HAR Dataset/train/subject_train.txt")
trainSubj$group <- "train"
trainX <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("./UCI HAR Dataset/train/Y_train.txt")
 
#Combining test data
traindata <- cbind(trainSubj, trainY, trainX)
colnames(traindata) <- c("subject", "group", "activity", names(testX))
#head(traindata)

#Joining the training and test data --------------------------------------------------------------------------------
alldata <- rbind(testdata, traindata)

colnames(alldata) <- c("subject", "group", "activity", featuresLables)
alldata$activity <- activityLables[alldata[,"activity"],"V2"]

#Subsetting the data to include only columns which pertain to the mean or std dev-----------------------------------

cols <- c("subject", "group", "activity", grep("mean|std", colnames(alldata), value = TRUE)) #list of column names want to keep
subdata <- alldata[,cols]
subdata

#second independent tidy data set with the average of each variable for each activity and each subject--------------
avg <- aggregate(subdata[4:ncol(subdata)], by=list(subdata$activity, subdata$subject), FUN = mean)
colnames(avg) <- c("activity","group", names(avg[3:ncol(avg)]))
avg

#exporting second tidy data to csv file ---------------------------------------------------------------------------
#write.table(avg, "./avgdata.csv", sep=",", row.names = FALSE)
write.table(avg, "./avgdata.txt", sep=",", row.names = FALSE)

#to read the clean daat back into R
cleandata <- read.table("./avgdata.txt", sep=",", header = TRUE)


