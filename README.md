GettingCleaningData
===================

## Course Project for Coursera Getting and Cleaning Data Course
Last Updated: Joseph Solway 5/25/2014

### Project Objectives: 
* Load in data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
* Create one R script called run_analysis.R that does the following. 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Files
Requires the following folders be in the working directory
* "features.txt" - Loaded as dataNames
*  "activity_labels.txt" - Loaded as ANames
*  "./train/X_train.txt" - Loaded as dataTrain
*  "./train/Y_train.txt" - Loaded as dataTrainY
*  "./train/subject_train.txt" - Loaded as idTest
*  "./test/X_test.txt" - Loaded as dataTest
*  "./test/Y_test.txt" - Loaded as dataTestY
*  "./test/subject_test.txt" - Loaded as idTest

### Local Variables
* dataCombo - combined test and train data
* id - combined subject test and train data
* YCombo - combined Y test and train data
* dataMSD - data for mean and standard deviation variables only
* Act - list of activity names
* dataTidy - tidy data set of mean of variable fBodyAccmeanZ

