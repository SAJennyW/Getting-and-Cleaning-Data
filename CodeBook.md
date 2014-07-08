## Code Book
This is the code book for the assignment as part of the Getting and Cleaning Data course on Coursera

## Data
The data was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The data was seperate for the training and test subjects, it was also split across various text files.
More info on these text files can be found in the README.txt file in the zipped folder

## Variables & Units of Measure
For the test and train data the explaination is the same (so will only explain the test data)

### Subjects 
A group of 30 subjects was used. 
Each subject was numbered from 1 - 30. 

_**This data was found in the subject_test.txt file

### Activities
Each subject weas measured while performing 6 different activities. These activities are 

* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

_**This data was found in the features_info.txt and test_Y.txt files

### Features Measurements
A 561-feature vector with time and frequency domain variables was recoreded for each subject while performing each activity. 
Features are normalized and bounded within [-1,1]

_**This data was found in the features.txt and test_X.txt files

## Column Names 
The column names were based off the original features.txt file. These were transformed slightly to avoid confusion when referencing the columns in R. 
The following transformations were applied:
	() were replaced by _
	- between feature and variable type was replaces with _
	- between () and the axis was removed
	e.g. tBodyAcc-mean()-X became tBodyAcc_mean_X

