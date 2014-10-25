# Understand what this does and if the dplyr below is redundant
packages <- c("data.table", "reshape2")
sapply(packages, require, character.only = TRUE, quietly = TRUE)

install.packages("dplyr")
library(dplyr)
setwd("C:/Users/SR/Documents/Coursera/GettingAndCleaningData/CourseProject/UCI HAR Dataset")
path<-getwd()

filesLoc <- file.path(path)
list.files(filesLoc, recursive = TRUE)

# Read the Subject Files
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


##Extract only the measures on the mean and standard deviation for each measurement


## Use descriptive activity names to name the activities in the data set

## Appropriately label the data set with descriptive variable names

## Create a second, independent tidy data set with the average of each variable for each activity and each subject