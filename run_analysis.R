## Course Assignment

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./UCI HAR Dataset.zip")
unzip("./UCI HAR Dataset.zip")

library(dplyr)
library(data.table)

## Read Activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Read the column names from the features text file
varnames <- read.table("./UCI HAR Dataset/features.txt")

## Replace punctuation characters from the column names like ['('; ')'; ','; '-'] with "_" (underscore)
## character so that they can be assigned as valid column names when X_*.txt files are read in 
#vname <- gsub("\\(|\\)|\\,|\\-","_",varnames$V2, useBytes=TRUE, perl=TRUE)

## Read in TRAIN data
#trainx <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, nrow=7500, col.names=vname)
trainx <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, nrow=7500)
## labeling the columns
names(trainx) <- varnames[,2]

trains <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, nrow=7500, col.names="subject")
trainy <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, nrow=7500)

## getting the decode of activity labels
#trainy2 <- merge(trainy, activity_labels)
trainy2 <- join(trainy, activity_labels, by="V1")
names(trainy2) <- c("V1", "Activity")

## combine all training data
train_all <- bind_cols(trains, trainy2[2], trainx)

## Read in TEST data
#testx <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, nrow=3000, col.names=vname)

testx <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, nrow=3000)
names(testx) <- varnames[,2]

tests <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, nrow=3000, col.names="subject")
testy <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, nrow=3000)
testy2 <- join(testy, activity_labels, by="V1")
names(testy2) <- c("V1", "Activity")

## combine all test data
test_all <- bind_cols(tests, testy2[2], testx)


## Combine all the data - train & test
Activity_Data <- rbind_list(train_all, test_all)

## Extracting only the "mean()" & "std()" variables

AD_subset1 <- select(Activity_Data, contains("mean()", ignore.case=TRUE))
AD_subset2 <- select(Activity_Data, contains("std()", ignore.case=TRUE))

## Combining the mean & std variables with the subject, activity variables
AD_subset <- bind_cols(Activity_Data[1:2], AD_subset1, AD_subset2)

AD1 <- data.table(AD_subset)

## Step-5 : average of each variable for each activity and each subject.
tidy1 <- AD1[, lapply(.SD, mean), by = list(subject, Activity)]

## Saving the dataset to text file
write.table(tidy1, "./tidy1.txt",row.names=FALSE)


 