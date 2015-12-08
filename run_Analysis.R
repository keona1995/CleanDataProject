# run_Analysis.R
# Project for Getting and Cleaning Data Course, Novemember 2015
# PKim
#
# Create variable names in preparation for loading and merging data sets that
# have no column names
cleanWearableData <- function() {
features <- read.table("./features2.txt")
featurelist <- features[,2]

# transform names to be lower case, remove parentheses, dashes, dots, commas
featurelist <- tolower(featurelist)
featurelist <- gsub("-","",featurelist)
featurelist <- gsub(",","",featurelist)
featurelist <- gsub("\\(","",featurelist)
featurelist <- gsub(")","",featurelist)
l <- length(featurelist)

# add two variable names for subjects and activity 
featurelist[(l+1):(l+2)] <- c("subjectid", "activity")

# load dplyr, then read in training set, training subjects, training activities
library(dplyr)
trainset <- read.table("./X_train.txt")
trainsubj <- read.table("./subject_train.txt")
trainact <- read.table("./y_train.txt")

# change all values in trainact to be more descriptive
trainact$V1 <- as.character(trainact$V1)
trainact$V1[trainact$V1=="1"] <- "walk"
trainact$V1[trainact$V1=="2"] <- "walkup"
trainact$V1[trainact$V1=="3"] <- "walkdown"
trainact$V1[trainact$V1=="4"] <- "sit"
trainact$V1[trainact$V1=="5"] <- "stand"
trainact$V1[trainact$V1=="6"] <- "lie"
trainact$V1 <- as.factor(trainact$V1)

# combine trainset, trainsubj, trainact by column
trainset <- cbind(trainset, trainsubj, trainact)

# convert the trainsubj column to factor
trainset[,562] <- as.factor(trainset[,562])

# use the featurelist to name the columns of the data set
colnames(trainset) <- featurelist

# to keep memory usage moderate, select only necessary columns
# then dispose of unnecessary variables
mintrainset <- select(trainset,matches("mean|std|subjectid|activity"))
rm(trainset,trainsubj,trainact,features,l)

# repeat the steps above for the test data sets
testset <- read.table("./X_test.txt")
testsubj <- read.table("./subject_test.txt")
testact <- read.table("./y_test.txt")

# change values in the activity list
testact$V1 <- as.character(testact$V1)
testact$V1[testact$V1=="1"] <- "walk"
testact$V1[testact$V1=="2"] <- "walkup"
testact$V1[testact$V1=="3"] <- "walkdown"
testact$V1[testact$V1=="4"] <- "sit"
testact$V1[testact$V1=="5"] <- "stand"
testact$V1[testact$V1=="6"] <- "lie"
testact$V1 <- as.factor(testact$V1)

# combine testset, testsubj, testact
testset <- cbind(testset, testsubj,testact)

# make the subject column a factor variable
testset[,562] <- as.factor(testset[,562])

# set the column names the same as training set
colnames(testset) <- featurelist

# select only necessary variables
mintestset <- select(testset, matches("mean|std|subjectid|activity"))

# remove unnecessary variables
rm(testset, testsubj, testact)

# combine the two sets by row
totalset <- rbind(mintrainset, mintestset)

# There are still some unnecessary columns because their names
# were included in the matches() criteria. Remove them now.
mintotalset <- select(totalset,-(matches("meanfreq|angle")))

# get rid of unnecessary data
rm(totalset,mintrainset,mintestset)

# prepare to reshape data, load library reshape2
library(reshape2)

#define id vars for the melt set
melttotalset <- melt(mintotalset,id.vars=c("subjectid","activity"))

# set up the relationship between subjectid+activity and all the 
# measurement variables, setting up the summary function to "mean"
myfinalcast <- dcast(melttotalset,subjectid+activity ~ variable, fun.aggregate=mean)

# output the final data set to disk
write.table(myfinalcast,file="AvgValsforSubjectIDandActivity.txt",sep="\t",row.names=FALSE)
}






