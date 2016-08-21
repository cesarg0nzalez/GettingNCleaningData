#This project is based is based on the paper "Human Activity Recognition on
#Smartphones using a Multiclass Hardware-Friendly Support Vector Machine".
#International Workshop of Ambient Assisted Living (IWAAL 2012)

#This script merges data from several txt files and produce a tidy data.
#The R script that does the following:
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive activity names
#5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

#Clean up workspace
rm(list=ls())

if (!require("data.table")) {
  install.packages(data.table)
}
if (!require("reshape2")) {
  install.packages("reshape2")
}
if (!require("plyr")) {
  install.packages("plyr")
}
library(data.table)
library(reshape2)
library(plyr)

# Download and unzip the dataset.
library(reshape2)

filename <- "getdata_dataset.zip"

#If filename is not exist
if (!file.exists(filename))
{
  fileURL <-         "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}
#Unzip filename
if (!file.exists("UCI HAR Dataset"))
{  unzip(filename)
}

#Read in the data from files

# Load activity labels
Labels <- read.table("UCI HAR Dataset/activity_labels.txt")
#Change factors as characters
Labels[,2] <- as.character(Labels[,2])

#Load features activity
features <- read.table("UCI HAR Dataset/features.txt")
#Change factors as characters
features[,2] <- as.character(features[,2])

# Extract only the measurements on the mean and standard deviation for each measurement.

Selected <- grep(".*mean.*|.*std.*", features[,2])
#Extract only the data on mean and standard deviation features
featuresSelected.names <- features[Selected,2]
#Make changes in the names, change -mean for Mean where exist
featuresSelected.names = gsub('-mean', 'Mean', featuresSelected.names)
#Make changes in the names, change -std for Std where exist
featuresSelected.names = gsub('-std', 'Std', featuresSelected.names)
#Desepare all de parenthesis of the names
featuresSelected.names <- gsub('[-()]', '', featuresSelected.names)

# Load the train datasets but only with the selected columns
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")[Selected]
#Load the train activities of each observation
X_train[,80] <- read.table("UCI HAR Dataset/train/Y_train.txt")
#Load the train subjects of each observation
X_train[,81] <- read.table("UCI HAR Dataset/train/subject_train.txt")

#Then now, the same procedure for test

# Load the test datasets but only with the wanted columns
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")[Selected]
#Load the test activities of each observation
X_test[,80] <- read.table("UCI HAR Dataset/test/Y_test.txt")
#Load the train subjects of each observation
X_test[,81] <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Merge the training and the test sets to create one data set.

# Merge datasets and add labels
finalData <- rbind(X_train, X_test)

# Appropriately label the data set with descriptive activity names.

#Rename de columns
colnames(finalData) <- c(featuresSelected.names,"activity","subject")
# turn activities and subjects into factors

# Use descriptive activity names to name the activities in the data set

#Set level and labels
finalData$activity <- factor(finalData$activity, levels = Labels[,1], labels = Labels[,2])
#Any subject change to factor
finalData$subject <- as.factor(finalData$subject)

# Create a second, independent tidy data set with the average of each variable for each activity and each subject.

finalDataSet<-ddply(finalData, c("subject","activity"), numcolwise(mean))
write.table(finalDataSet, file = "tidy.txt", row.name=FALSE, quote = FALSE)