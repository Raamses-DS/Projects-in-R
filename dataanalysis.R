# We load a library that will allow us to manipulate the data correctly.
library(plyr)

# First, we need to download the dataset:
if(!file.exists("./getcleandata")){dir.create("./getcleandata")}
projectdata <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(projectdata, destfile = "./getcleandata/projectdataset.zip")

# Now we proceed to perform the unzip:
unzip(zipfile = "./getcleandata/projectdataset.zip", exdir = "./getcleandata")

# 1. Merges the training and the test sets to create one data set.

# Reading training datasets:
x_train <- read.table("./getcleandata/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./getcleandata/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./getcleandata/UCI HAR Dataset/train/subject_train.txt")

# Reading test datasets:
x_test <- read.table("./getcleandata/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./getcleandata/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./getcleandata/UCI HAR Dataset/test/subject_test.txt")

# Reading feature content:
features <- read.table("./getcleandata/UCI HAR Dataset/features.txt")

# Reading activity labels:
activitylabels = read.table("./getcleandata/UCI HAR Dataset/activity_labels.txt")

# Assigning variable names:
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"

colnames(activitylabels) <- c("activityID", "activityType")

# Merging all datasets into one set:
alldatatrain <- cbind(y_train, subject_train, x_train)
alldatatest <- cbind(y_test, subject_test, x_test)
completedataset <- rbind(alldatatrain, alldatatest)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# The first step is reading column names:
colNames <- colnames(completedataset)

# Now, we create vector for defining ID, mean, and sd:
mean_and_std <- (grepl("activityID", colNames) |
                     grepl("subjectID", colNames) |
                     grepl("mean..", colNames) |
                     grepl("std...", colNames))

# Performing a subset to continue the analysis:
setMeanandstd <- completedataset[ , mean_and_std == TRUE]

# Uses descriptive activity names to name the activities in the data set.

setwithActivityNames <- merge(setMeanandstd, activitylabels,
                              by = "activityID",
                              all.x = TRUE)


# 4. Appropriately labels the data set with descriptive variable names. 
# (See previous command to account for this section).



# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.


# Construct a another tidy data set:
tidySet1 <- aggregate(. ~subjectID + activityID, setwithActivityNames, mean)
tidySet2 <- tidySet[order(tidySet$subjectID, tidySet$activityID), ]

# Writing the second tidy data set into a txt file:
write.table(tidySet2, "tidySet.txt", row.names = FALSE)
