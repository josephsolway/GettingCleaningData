#run_analysis.R
#Coursera - Getting and Cleaning Data 
#Assignment 2
#Created - Joseph Solway 5/18/2014
#Last Updated - Joseph Solway 5/25/2014

#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
#The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers 
#on a series of yes/no questions related to the project. You will be required to submit: 
#1) a tidy data set as described below, 
#2) a link to a Github repository with your script for performing the analysis, and 
#3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
#You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

#One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#Here are the data for the project: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

#You should create one R script called run_analysis.R that does the following. 
#1 Merges the training and the test sets to create one data set.
#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#3 Uses descriptive activity names to name the activities in the data set
#4 Appropriately labels the data set with descriptive activity names. 
#5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


#Load plyr package
library(plyr)
#Set working directory
#setwd("C:/documents/_Personal/Big_Data/Scripts/3-GetCleanData/UCI HAR Dataset")

########################################################################
#1 Merges the training and the test sets to create one data set.
#Load in the Train Data
dataTrain <- read.table("./train/X_train.txt",  header = F)
dataTrainY <- read.table("./train/Y_train.txt",  header = F)
idTrain <- read.table("./train/subject_train.txt",  header = F)
#Load in the Test Data
dataTest <- read.table("./test/X_test.txt",  header = F)
dataTestY <- read.table("./test/Y_test.txt",  header = F)
idTest <- read.table("./test/subject_test.txt",  header = F)
#Load in the Names of the Features
dataNames <- read.table("features.txt",  header = F)
#Load in the Activity labels
ANames <- read.table("activity_labels.txt",  header = F)

#Combine the Train and Test data
dataCombo <- rbind(dataTrain, dataTest)
id <- rbind(idTrain, idTest)
YCombo <- rbind(dataTrainY, dataTestY)

#Turn the id data from a data frame to a single vector
id <- unlist(id, use.names = FALSE)

#3 Uses descriptive activity names to name the activities in the data set
#Clean up the Features Names
dataNames[,2] <- gsub("-","",dataNames[,2], ignore.case = FALSE)
dataNames[,2] <- gsub("\\(\\)","",dataNames[,2], ignore.case = FALSE)
dataNames[,2] <- gsub("\\(","",dataNames[,2], ignore.case = FALSE)
dataNames[,2] <- gsub("\\)","",dataNames[,2], ignore.case = FALSE)
dataNames[,2] <- gsub("\\,","",dataNames[,2], ignore.case = FALSE)
#Add the feasure names to the dataset
colnames(dataCombo) <- dataNames[,2]

########################################################################
#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#Create a new data frame with the mean and standard deviation measured data only
dataMSD <- dataCombo[,c(grep("std",dataNames[,2]), grep("mean",dataNames[,2]))]

#Add to the dataframe a column of the test person id number
dataMSD$person <- id
colnames(dataMSD$person) <- "person"

#4 Appropriately labels the data set with descriptive activity names. 
#Create a list of the activities by name for each entry in the data frame
Act <- {}
#There has to be a more efficient way to do this loop.......................
for (i in 1:length(YCombo[,1])) {  
  j <- which(sapply(ANames[,1], "%in%", YCombo[i,1]))
  Act[i] <- as.character(ANames[j,2])
}
#Add the list of activity names to the data frame
dataMSD$Activity <- Act
#Name the new column in the dataframe
colnames(dataMSD$Activity) <- "Activity"

########################################################################
#5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#For the purposes of the course assignment the measurement variable 'fBodyAccmeanZ' was used
#Provide mean for the variable, for each of the 30 people person and 6 activities
dataTidy <- with(dataMSD, tapply(fBodyAccmeanZ, list(Activity, person), mean))
#Change to 2 decimal places
dataTidy <- round(dataTidy, 2)
#Write output to a file
write.table(dataTidy,"CleanDataAss.txt")
#############################END OF FILE##################