---
title: "README"
author: "Jake Searell"
date: "15/10/2022"
output: html_document
---

### Getting and Cleaning Data Course Project
***
#### About this Project:
***
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

You should create one R script called run_analysis.R that does the following. 

Merges the training and the test sets to create one data set.

Extracts only the measurements on the mean and standard deviation for each measurement. 

Uses descriptive activity names to name the activities in the data set

Appropriately labels the data set with descriptive variable names. 

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

***

#### About the Script:
##### Steps: 

##### Analysis Prep:
Download data:  
0.1 create data folder if one doesn't exist  
0.2 download data and store in data folder  
0.3 unzip file if file has not been unzipped  

##### Section 1
Merge the training and the test sets to create one data set:  
1.1 read in data  
1.1.1 specify file path to read from  
1.1.2 list files - set recursive to TRUE to list all sub-foldered files  
1.2 read in tables  
1.2.1 read in features vector  
1.2.2 read in activity labels  
1.3 assigning column headers  
1.4 merge data  

##### Section 2
Extract only the measurements on the mean and standard deviation for each measurement:  
2.1 isolate column names  
2.2 create a vector used to subset combined data  
2.3 subset combined data set  

##### Section 3
Use descriptive activity names to name the activities in the data set:  
3.1 left join meanStd and actLabels data on activityId variables  

##### Section 4 
Appropriately label the data set with descriptive variable names:  
4.1 substitute abbreviations for full text  

##### Section 5
From the data set in step 4, creates a second, independent tidy data set:  
5.1 summarise data - aggregate to find mean per activity per subject  
5.2 arrange in order of person, then activity  
5.2 write tidy data to .txt file  

