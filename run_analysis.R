# ---------------------------------------------------------------------#
# Getting and cleaning data
# Course project 
# Tidy data set: Human Activity Recognition Using Smartphones Data Set
# Author: Jake Searell
# Date: 15 Oct. 2022
# ---------------------------------------------------------------------#
# load packages
library(tidyverse)
# Download data ====
# 0.1 create data folder if one doesn't exist
if (!file.exists("./data")) {
  
  dir.create("./data")
  
}

# 0.2 download data and store in data folder
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/dataset.zip")

# 0.3 unzip file if file has not been unzipped
if (file.exists("./data/dataset.zip")) {
  
  unzip("./data/dataset.zip", exdir = "./data")
  
}

# Section 1 - Merges the training and the test sets to create one data set ====

# 1.1 read in data ====
# 1.1.1 specify file path to read from
path <- file.path("data", "UCI HAR Dataset")

# 1.1.2 list files - set recursive to TRUE to list all sub-foldered files
files <- list.files(path, recursive = TRUE)

# 1.2 read in tables ====
#     train data
yTrain <- read.table(file.path(path, "train", "y_train.txt"))
xTrain <- read.table(file.path(path, "train", "x_train.txt"))
subTrain <- read.table(file.path(path, "train", "subject_train.txt"))
#     test data 
yTest <- read.table(file.path(path, "test", "y_test.txt"))
xTest <- read.table(file.path(path, "test", "x_test.txt"))
subTest <- read.table(file.path(path, "test", "subject_test.txt"))

# 1.2.1 read in features vector
feat <- read.table(file.path(path, "features.txt"))

# 1.2.2 read in activity labels
actLabels <- read.table(file.path(path, "activity_labels.txt"))

# 1.3 assigning column headers ====
#     train data
colnames(subTrain) <- "subjectId"
colnames(yTrain) <- "activityId"
colnames(xTrain) <- feat[,2]
#     test data
colnames(subTest) <- "subjectId"
colnames(yTest) <- "activityId"
colnames(xTest) <- feat[,2]
#     activity data
colnames(actLabels) <- c("activityId", "activityType")

# 1.4 merge data ====
#     train data
merge_train <- cbind(subTrain, yTrain, xTrain)
#     test data
merge_test <- cbind(subTest, yTest, xTest)
#     combine data
combined <- rbind(merge_train, merge_test)
#     check dimensions
dim(combined)
#     10299 obs. of  563 variables

# Section 2 - Extract only the measurements on the mean and standard deviation for each measurement ====

# 2.1 isolate column names ====
colNames <- colnames(combined)

# 2.2 create a vector used to subset combined data ====
meanStdVec <- (grepl("subjectId", colNames) | 
              grepl("activityId", colNames) | 
              grepl("mean", colNames) | 
              grepl("std", colNames)
   )

# 2.3 subset combined data set ====
meanStd <- combined[, meanStdVec == TRUE]
#     check dimensions
dim(meanStd)
#     10299 obs. of  81 variables

# Section 3 - Use descriptive activity names to name the activities in the data set ====

# 3.1 left join meanStd and actLabels data on activityId variables ====
smrtPhActData <- left_join(meanStd, actLabels, by = "activityId")
#     remove activityId variable and replace with activityType variable
smrtPhActData <- select(smrtPhActData, -2)
smrtPhActData <- select(smrtPhActData, c(1, 81, 2:80))

# Section 4 - Appropriately label the data set with descriptive variable names ====
#             See README.txt
# 4.1 substitute abbreviations for full text ====
#     - note that "X", "Y"  "Z" refers to triaxial measurement
colnames(smrtPhActData) <- gsub("^f", "frequency", colnames(smrtPhActData))
colnames(smrtPhActData) <- gsub("^t", "time", colnames(smrtPhActData))
colnames(smrtPhActData) <- gsub("BodyGyro", "Velocity", colnames(smrtPhActData))
colnames(smrtPhActData) <- gsub("BodyAcc", "TotalAcc", colnames(smrtPhActData))
colnames(smrtPhActData) <- gsub("BodyBody", "EstAcc", colnames(smrtPhActData))
colnames(smrtPhActData) <- gsub("Mag", "Magnitude", colnames(smrtPhActData))

# Section 5 - From the data set in step 4, creates a second, independent tidy data set ====
#             with the average of each variable for each activity and each subject.
# 5.1 summarise data - aggregate to find mean per activity per subject ====
sumData <- aggregate(. ~subjectId + activityType, smrtPhActData, mean)
# 5.2 arrange in order of person, then activity ====
tidyData <- sumData[order(sumData$subjectId, sumData$activityType),]
# 5.2 write tidy data to .txt file ====
write.table(tidyData, "./data/tidyData.txt", 
            quote = FALSE, row.names = FALSE, sep = "\t")


