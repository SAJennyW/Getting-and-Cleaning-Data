## README
This is the README file for the assignment as part of the Getting and Cleaning Data course on Coursera

## Data
The data was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The data was seperate for the training and test subjects, it was also split across various text files.
More info on these text files can be found in the README.txt file in the zipped folder

## Assumptions Made
* It was assumed since the test_X, test_Y and subject_test files were of the same row dimension it was safe you concatinate these text files. 
* Also since the features.txt and subject_test files were the same in column dimension is was safe to concatinate these files. 
* When selecting mesurements only pertaining to the mean or standard deviation - it was assumed the fetures lable would include the word "mean" or "std". 

## Scripts

~~~~~~~~~~~~~~~~~~~~~
#Getting and Cleaning Data - Assignment

'#Downloading the data and extract from zip folder
'url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
'name = "projdata.zip"
'download.file(url, dest = name)
'unzip(name)


'#Reading in the metadata -------------------------------------------------------------------------------------------
'activityLables <- read.table("./UCI HAR Dataset/activity_labels.txt")
'featuresLables <- read.table("./UCI HAR Dataset/features.txt")
'featuresLables <- as.character(featuresLables$V2)

'#reformatting the features lables
'featuresLables <- sub("-", "_" , featuresLables)
'featuresLables <- gsub("\\()", "_" , featuresLables)
'featuresLables <- gsub("-", "" , featuresLables)

'#Reading in the test data -------------------------------------------------------------------------------------------
'testSubj <- read.table("./UCI HAR Dataset/test/subject_test.txt")
'testSubj$group <- "test"
'testX <- read.table("./UCI HAR Dataset/test/X_test.txt")
'testY <- read.table("./UCI HAR Dataset/test/Y_test.txt")

'#Combining test data
'testdata <- cbind(testSubj, testY, testX)
'colnames(testdata) <- c("subject", "group", "activity", names(testX))
'#head(testdata)


'#Reading in the training data ---------------------------------------------------------------------------------------
'trainSubj <- read.table("./UCI HAR Dataset/train/subject_train.txt")
'trainSubj$group <- "train"
'trainX <- read.table("./UCI HAR Dataset/train/X_train.txt")
'trainY <- read.table("./UCI HAR Dataset/train/Y_train.txt")
 
'#Combining test data
'traindata <- cbind(trainSubj, trainY, trainX)
'colnames(traindata) <- c("subject", "group", "activity", names(testX))
'#head(traindata)

'#Joining the training and test data --------------------------------------------------------------------------------
'alldata <- rbind(testdata, traindata)

'colnames(alldata) <- c("subject", "group", "activity", featuresLables)
'alldata$activity <- activityLables[alldata[,"activity"],"V2"]

'#Subsetting the data to include only columns which pertain to the mean or std dev-----------------------------------

'cols <- c("subject", "group", "activity", grep("mean|std", colnames(alldata), value = TRUE)) #list of column names want to keep
'subdata <- alldata[,cols]
'subdata

'#second independent tidy data set with the average of each variable for each activity and each subject--------------
'avg <- aggregate(subdata[4:ncol(subdata)], by=list(subdata$activity, subdata$subject), FUN = mean)
'colnames(avg) <- c("activity","group", names(avg[3:ncol(avg)]))
'avg

'#exporting second tidy data to csv file ---------------------------------------------------------------------------
'#write.table(avg, "./avgdata.csv", sep=",", row.names = FALSE)
'write.table(avg, "./avgdata.txt", sep=",", row.names = FALSE)

'#to read the clean daat back into R
'cleandata <- read.table("./avgdata.txt", sep=",", header = TRUE)



## Transformations
The following transformations were performed on the variables:
1. Two seperate vectors for the activity and features lables was created

2. The features lables were transformed to be clean:
	() were replaced by _
	- between feature and variable type was replaces with _
	- between () and the axis was removed
	e.g. tBodyAcc-mean()-X became tBodyAcc_mean_X

   This was done to avoid confusion when referencing the columns in R.

3. A seperate table for the test and train data was created. In these tables the subjects (subject_test), corresponding activity (test_Y) and features measurements (test_X) were merged into an single table.

4. The seperate train and test tables were combined.

5. The activity numbers were replaced with the activity name. 

6. Measurements for which the column nmae included either "mean" or "std" were extracted.

7. The mean of the extracted measurements was calculated per activity and subject.

Transformations 1 - 6 produce the 1st data set required
While transformations 1 - 7 produce the 2nd data set required. This is the data set hat was uploaded during submission. 


