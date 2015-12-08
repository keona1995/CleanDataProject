# CleanDataProject
Course work for Getting and Cleaning Data Course

This repository contains data files from a data source obtained from 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The files selected from the data source and included here are:  
  * activity_labels.txt  
  * features.txt  
  * README.txt  
  * subject_train.txt  
  * X_train.txt  
  * y_train.txt  
  * subject_test.txt  
  * X_test.txt  
  * y_test.txt  

One file from the original data source was modified:  
  * features2.txt--modification of features.txt

New files generated for this repository are:  
  * CodeBook.md  
    Description of the project, procedures for cleaning and shaping the data, description of variables.  
  * run_Analysis.R  
    The R code for creating the data set  
  * AvgValsforSubjectIDandActivity.txt	
    The final tidy data set output to tab-delimited text file.

The single script run_Analysis.R does all of the work of reading and cleaning the data. Briefly, here are all the tasks the script performs:
  * parses and transforms the variable names from features2.txt. The vector of features is kept in memory to rename the data set columns later
  * parses data from activity_labels.txt to be used as categorical variable activityid, and transforms numerical data into friendlier strings representing activities
  * handles the training and test data separately, but using the same set of steps. These included reading in the primary measurement data set (X_\*.txt), the subject information (subject_\*.txt), then combining the activity labels, subject information, and measurement data into one data set, then removing all columns not relevant to the requirements for the study
  * combines training and test data, then reshapes the data so that summaries for each unique combination of subject and activity can be compiled
  * outputs the final tidy data set

If all files are deposited to a single folder, and the R script is run, an identical data set to the final tidy data set should result.
If someone actually does try to run the script, I would suggest renaming the AvgValsforSubjectIDandActivity.txt file to allow easy comparison with the newly created output file.
