# This is the CodeBook for the Week 3 Coursera Project.

## Source Data

The data linked to from the course website represent data collected from 
the accelerometers from the Samsung Galaxy S smartphone. A full description 
is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

## R script

File with R code dataanalysis.R performs the 5 following steps: 

1. Merges the training and the test sets to create one data set.
Reading training datasets
Reading test datasets
Reading feature content
Reading activity labels
Assigning variable names
Merging all datasets into one set

2. Extracts only the measurements on the mean and standard deviation for each measurement.
The first step is reading column names
Now, we create vector for defining ID, mean, and sd
Performing a subset to continue the analysis

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 
(See previous command to account for this section)
  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Construct a another tidy data set
Writing the second tidy data set into a txt file


## Variables

x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.

x_data, y_data and subject_data merge the previous datasets to further analysis.

features contains the correct names for the x_data dataset, which are applied to the column names stored in.
