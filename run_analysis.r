## Establish Environment

# Install and packages needed for execution of this script
packages <- c("data.table", "reshape2", "dplyr")
packages
sapply(packages, require, character.only = TRUE, quietly = TRUE)

# Set working directory
setwd("C:/Users/SR/Documents/Coursera/GettingAndCleaningData/CourseProject/UCI HAR Dataset")
path<-getwd()

## Download Source Files
#  Note that these files have already been downloaded and must reside in the path set
#  for your working directory indicated in the previous step

#  This section is commented out as it is assumed that the files have been downloaded and 
#  placed in the appropriate working directory unzipped; this task was not included as
#  a part of the project assignment

# url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# file <- "Dataset.zip"
# if (!file.exists(path)){
#     dir.create(path)
# }
# download.file(url, file.path(path, file))

#  View download files
filesLoc <- file.path(path)
list.files(filesLoc, recursive = TRUE)

# Read the Subject Files
# Note that the Inertial Signals files are not being used for this project
SubjectTrain <-fread(file.path(filesLoc, "train", "subject_train.txt"))
SubjectTest <-fread(file.path(filesLoc, "test", "subject_test.txt"))

# Read the Activity Files
YActivityTrain <-fread(file.path(filesLoc, "train", "Y_train.txt"))
YActivityTest <-fread(file.path(filesLoc, "test", "Y_test.txt"))

# Read the Activity Files
readFileToTable <- function(f) 
  {
  df <- read.table(f)
  dt <- data.table(df)
  }

XActivityTrain <- readFileToTable(file.path(filesLoc, "train", "X_train.txt"))
XActivityTest <- readFileToTable(file.path(filesLoc, "test", "X_test.txt"))

## Merge the training and test sets to create one data set

Subject<-rbind(SubjectTrain, SubjectTest)
setnames(Subject, "V1", "Subject")

XActivity<-rbind(XActivityTrain, XActivityTest)
setnames(XActivity, "V1", "ActNum")

YActivity<-rbind(YActivityTrain, YActivityTest)
setnames(Subject, "V1", "ActNum")

Subject<-cbind(Subject, YActivity)
Subject<-cbind(Subject, XActivity)

setkey(Subject, subject, ActNum)


##Extract only the measures on the mean and standard deviation for each measurement
# THIS IS NOT WORKING
Features<-fread(file.path(filesLoc, "features.txt"))
setnames(Features, names(Features), c("featureID", "featureName"))

Features<-filter(Features, featureName == "tBodyAcc-mean()-X")



## Use descriptive activity names to name the activities in the data set

ActivityNames<-fread(file.path(filesLoc, "activity_labels.txt"))
setnames(ActivityNames, names(ActivityNames), c("actNum", "actName"))


## Appropriately label the data set with descriptive variable names



## Create a second, independent tidy data set with the average of each variable for each activity and each subject