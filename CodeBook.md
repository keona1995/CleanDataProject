## CodeBook for CleanDataProject, 11/11/2015
## 
Project Description
--------------------

The project was an assignment for the “Getting and Cleaning Data” course offered through coursera.org. The objectives of the project are stated as follows:

------------------------
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
One of the most exciting areas in all of data science right now is wearable computing - see for example  this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 

1.Merges the training and the test sets to create one data set.

2.Extracts only the measurements on the mean and standard deviation for each measurement. 

3.Uses descriptive activity names to name the activities in the data set

4.Appropriately labels the data set with descriptive variable names. 

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

--------------------------------

Study design and data processing
--------------------------------

###Collection of the raw data

The data was collected from the public repository at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Though nothing will be published as a result of this study, I cite the following in recognition of the importance of the data source in completing the project:

Lichman, M. (2013). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, School of Information and Computer Science

###Notes on the original (raw) data

In most cases the raw data was obtained and used in its original form. The exceptions are the following three files:  
  * y_test.txt  
  * subject_test.txt  
  * features.txt

During preliminary analysis, I tried to get a feel for the data by manually opening files and visually inspecting them. The two files “y_test.txt” and “subject_test.txt” above were opened in a basic text editor but were unsuccessfully formatted by the application. They were then opened in Microsoft Word, which successfully formatted the data, which was then copied back to plain text files in a separate location from the downloaded data. The original files were used in the formal analysis; however, without the intermediate step detailed here, I would not have grasped the intent of the authors. Hence, I am obligated to report these ancillary procedures.

It was necessary to make changes to the “features.txt” file. The data in this file provided the variable names for the primary data set. Unfortunately, there were duplicate variable names in the original file. I do not know the reason for the duplicates, but since all the data corresponding to the duplicate sets of variables were not going to be used in the analysis, I felt justified in making the names unique. This was necessary in order to use dplyr to select the required columns.

How the tidy data file was constructed
--------------------------------------

The data were downloaded from the website indicated above in section "Project Description". The individual files were inspected visually, in particular the README.txt and features_info.txt.

Labels for the "activity" variable were derived from the file activity_labels.txt. The labels were shortened and transformed to lower case. These actions are documented in the R script, run_Analysis.R, provided in the repository.

The list of features that were to serve as the column names for the final tidy data set were derived from several sources. Column names for measurement variables were derived from features_info.txt. The subjectid column name was assigned to data from  files subject_train.txt and subject_test.txt. The activity column name was assigned to  data from files y_train.txt and y_test.txt. The features were further transformed as follows:

  * convert all names to lower case  
  * replace all "-", ",", "(",")" with empty string ""  

The names "subjectid" and "activity" were added to the vector of feature names. The feature vector was reserved for further use later in the analysis process.

The training data set consisted of 3 different files:  

  * X_train.txt		Contains primary measurement variables  
  * subject_train.txt	Contains the subject id associated with each row of X_train.txt  
  * y_train.txt		Contains the activity label associated with each row of X_train.txt

The test data set consisted of 3 different files, organized similarly to the training data set:  

  * X_test.txt  
  * subject_test.txt  
  * y_test.txt

Each of training and test data sets were handled separately and memory disposed of as quickly as possible to avoid potential problems with memory shortage. The dplyr package was loaded prior to handling of the data sets. The pattern of processing was the same for both data sets:

1. read the principal data set into data frame 1  
2. read the subject data set into data frame 2  
3. read the activity data set into data frame 3  
4. temporarily change the activity data set types to character  
5. replace the activity data set values with more descriptive values (i.e., replace value 1 with the activity “walk”)  
6. change the activity data set types back to factor  
7. combine the three data frames using column bind and save to a new data frame 4  
8. convert the column representing the subject data into factor class  
9. assign to the column names of the combined data set the reserved vector of features  
10. select from data frame 4 only columns necessary for analysis and assign to another data frame 5  
11. dispose of data frames 1, 2, 3, 4.  

After each data set was handled, the resulting data sets for training and test were combined using row bind. At this stage the resulting data set represented the merging of training and test data sets. There were still some unnecessary columns remaining. These were removed using the dplyr “select” command, and the resulting data set was assigned to the final merged data set. As before, unnecessary data sets were disposed of.

Reshaping of data occurred next. The “reshape2” library was loaded, and a melt command executed such that “subjectid” and “activity” were selected as the id factors. The dcast command was executed so that the mean of each measurement variable could be displayed for each unique combination of subjectid and activity. For example, for subjectid 1, the following could be a representative view of the displayed rows:

|  subjectid  |  activity | measure 1 avg | measure 2 avg |  etc  |
|-------------|-----------|---------------|---------------|-------|
|    1        |    walk   |       0.2     |      0.3      |  0.4  |
|    1        |  walkup   |       0.5     |      0.6      |  0.7  |
|    1        | walkdown  |       0.4     |      0.5      |  0.6  |

The final data set was written to disk.

All of the steps discussed in this section are documented in R script run_Analysis.R

Description of the variables
----------------------------
The final data set is named “myfinalcast” in the run_Analysis.R file and is output as a tab-delimited text file named "AverageValsforSubjectIDandActivity.txt". It contains a compilation of average measurement values for each unique combination of subject and activity, where the subject id ranges from 1 to 30 and the activities are named “walk”, “walkup”, “walkdown”, “sit”, “stand”, “lie” that represent measurements taken for walking, walking upstairs, walking downstairs, sitting, standing, and lying. The measurements were taken from accelerometers from the Samsung Galaxy S smartphone.

The full list of the original features is listed in “features_info.txt” from the original study. The names of the variables in the data set resemble the original, with the following differences:

  * all names have been changed to lower case  
  * parentheses, dot, and comma characters have been removed  
  * the only measurements retained are mean and standard deviation, indicated in the name by “mean” and “std”

The naming conventions adopted in this project are the following:

  * Prefixes – ‘f’ denotes measurements from the frequency domain, ‘t’ denotes measurements from the time domain  
  * Root names – First root can be “body”, or “gravity”, indicating body signals or gravity signals. Second root name 
can be attached to first root name and can be “acc” or “gyro” indicating signals from the accelerometer or the 
gyroscope. Third root name can be attached to the second root name “acc” or “gyro” and can be “jerk” indicating a 
jerk signal. Fourth root name can be attached to second or third rootname and can be “mag” indicating a magnitude measurement.  
  * Suffixes – Principal suffix can be either “mean” or “std” indicating a mean value measurement or a standard deviation. 
Subsidiary suffixes can be “x”, “y”, or “z” and can be attached to “mean” or “std” suffix; they indicate measurements 
along x, y, or z axis.  
  * Not all combinations make sense, and one combination is included in the original data set 
(e.g., fbodybodygyromagstd) that was never explained. However, something like “fbodyaccjerkmeanz” makes perfect sense 
and can be easily searched, summarized, etc., with the aid of this list of conventions.  


The entire list of measurement variables are shown below. All are class numeric. No units were presented in the original study.  

  tbodyaccmeanx  
  tbodyaccmeany  
  tbodyaccmeanz  
  tbodyaccstdx  
  tbodyaccstdy  
  tbodyaccstdz  
  tgravityaccmeanx  
  tgravityaccmeany  
  tgravityaccmeanz  
  tgravityaccstdx  
  tgravityaccstdy  
  tgravityaccstdz  
  tbodyaccjerkmeanx  
  tbodyaccjerkmeany  
  tbodyaccjerkmeanz  
  tbodyaccjerkstdx  
  tbodyaccjerkstdy  
  tbodyaccjerkstdz  
  tbodygyromeanx  
  tbodygyromeany  
  tbodygyromeanz  
  tbodygyrostdx  
  tbodygyrostdy  
  tbodygyrostdz  
  tbodygyrojerkmeanx  
  tbodygyrojerkmeany  
  tbodygyrojerkmeanz  
  tbodygyrojerkstdx  
  tbodygyrojerkstdy  
  tbodygyrojerkstdz  
  tbodyaccmagmean  
  tbodyaccmagstd  
  tgravityaccmagmean  
  tgravityaccmagstd  
  tbodyaccjerkmagmean  
  tbodyaccjerkmagstd  
  tbodygyromagmean  
  tbodygyromagstd  
  tbodygyrojerkmagmean  
  tbodygyrojerkmagstd  
  fbodyaccmeanx  
  fbodyaccmeany  
  fbodyaccmeanz  
  fbodyaccstdx  
  fbodyaccstdy  
  fbodyaccstdz  
  fbodyaccjerkmeanx  
  fbodyaccjerkmeany  
  fbodyaccjerkmeanz  
  fbodyaccjerkstdx  
  fbodyaccjerkstdy  
  fbodyaccjerkstdz  
  fbodygyromeanx  
  fbodygyromeany  
  fbodygyromeanz  
  fbodygyrostdx  
  fbodygyrostdy  
  fbodygyrostdz  
  fbodyaccmagmean  
  fbodyaccmagstd  
  fbodybodyaccjerkmagmean  
  fbodybodyaccjerkmagstd  
  fbodybodygyromagmean  
  fbodybodygyromagstd  
  fbodybodygyrojerkmagmean  
  fbodybodygyrojerkmagstd  

The two categorical variables are subjectid and activity.

  * subjectid      
    factor variable ranging consecutively from 1 to 30. These represent a random selection of volunteers from the original study with no further disclosure of characteristics.

  * activity        
    factor variable indicating the activity that was measured. These activities were walking, walking upstairs, walking downstairs, sitting, standing, laying [sic]. In the final data set these are indicated in abbreviated form as walk, walkup, walkdown, sit, stand, lie.

The dimensions of the tidy data set are 180 observations of 68 variables.

