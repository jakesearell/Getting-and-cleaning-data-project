---
title: "CodeBook"
author: "Jake Searell"
date: "15/10/2022"
output: html_document
---

### Code Book
***
  
#### Variables  
***
  
##### Downloaded files
* **feat**: list of all features   
* **actLabels**: Links the class labels with their activity name  
* **xTrain**: Training set  
* **yTrain**: Training labels  
* **xTest**: Test set  
* **yTest**: Test labels  
* **subTrain**: Training subjects  
* **subTest**: Test subjects  

  
##### Merge data
* **merge_train**: merged training data  
* **merge_test**: merged test data  
* **combined**: merged training and test data  

  
##### Mean and standard deviation
* **meanStdVec**: vector of columns with mean and standard deviation data  
* **meanStd**: subset of mean and standard deviation data  

  
##### Name the activities in the data set
* **smrtPhActData**: smart phone activity data, combines *meanStd* data with *actLabels* data  

  
##### Tidy data
* **sumData**: aggregated data, contains the mean per activity per subject  
* **tidyData**: contains aggregated data, arranged in order of person, then activity  

