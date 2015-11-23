# CleanDataProject
Course work for Getting and Cleaning Data Course

This repository contains data files from a data source obtained from 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The files selected from the data source and included here are:
    activity_labels.txt

    features.txt

    README.txt

    subject_train.txt

    X_train.txt

    y_train.txt

    subject_test.txt

    X_test.txt

    y_test.txt

One file from the original data source was modified:

    features2.txt,	modification of features.txt

New files generated for this repository are:

    CodeBook.md         Description of the project, procedures for cleaning and shaping the data, description of variables.

    run_Analysis.R      The R code for creating the data set

    AvgValsforSubjectIDandActivity.txt	
                        The final tidy data set output to tab-delimited text file.

If all files are deposited to a single folder, and the R script is run, an identical data set to the final tidy data set should result.
If someone actually does try to run the script, I would suggest renaming the AvgValsforSubjectIDandActivity.txt file to allow easy comparison with the newly created output file.

The comments in the R script should match up with comments in the CodeBook.