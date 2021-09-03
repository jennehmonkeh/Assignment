# for this script to run the data set must be in the working directory e.g. in windows:
#setwd("C:\\Users\\usernamexx\\Documents\\Getting and Cleaning Data\\FinalAssignment\\Dataset\\UCI HAR Dataset")

install.packages("dplyr")
install.packages("data.table")

library(dplyr)
library(data.table)

# read features file
features<-read.table("features.txt",header = FALSE)

# read activity labels 6 rows:
activity_names<-read.table("activity_labels.txt", header = FALSE)

# read the files in the folder "train"
features_train<-read.table("./train/X_train.txt",header = FALSE)
activity_train<-read.table("./train/Y_train.txt",header=FALSE)
subject_train<-read.table("./train/subject_train.txt",header=FALSE)

# read the files in the folder "test"
features_test<-read.table("./test/X_test.txt",header = FALSE)
activity_test<-read.table("./test/Y_test.txt",header=FALSE)
subject_test<-read.table("./test/subject_test.txt",header=FALSE)

# Add descriptive column names to all the datasets:

# Add 561 column names to measurements for both datasets:
names(features_train)<-features$V2
names(features_test)<-features$V2

# Add column name "activity" to both datasets
names(activity_train)<-"activity"
names(activity_test)<-"activity"

# Add column name "subject" to both datasets
names(subject_train)<-"subject"
names(subject_test)<-"subject"


# add subject and activity sets to train set
traindata <- cbind(subject_train,activity_train,features_train)

# add subject and activity sets to test set
testdata <- cbind(subject_test,activity_test,features_test)

# Assignment requirements items 1 to 5:

# Item 1: Merge the training and the test sets to create one data set (append one to the other)
mergeddataset <-rbind(traindata,testdata)

# Item 2: Extract only the measurements (86 of 561) on the mean and standard deviation
thedataset <- mergeddataset %>% select(subject, activity, matches('mean|std'))

# Item 3:  Use descriptive activity names to name the activities in the data set
thedataset$activity <- factor(thedataset$activity,labels = activity_names$V2)

# Item 4: Label the data set with descriptive variable names
names(thedataset)<-sub("tBodyAcc-","timebodyacceleration",names(thedataset))
names(thedataset)<-sub("tBodyAccMag-","timebodyaccelerationmagnitude",names(thedataset))
names(thedataset)<-sub("tBodyAccJerk-","timebodyaccelerationjerk",names(thedataset))
names(thedataset)<-sub("tBodyAccJerkMag-","timebodyaccelerationjerkmagnitude",names(thedataset))
names(thedataset)<-sub("tGravityAcc-","timegravityacceleration",names(thedataset))
names(thedataset)<-sub("tGravityAccMag-","timegravityaccelerationmagnitude",names(thedataset))
names(thedataset)<-sub("tBodyGyro-","timebodygyroscope",names(thedataset))
names(thedataset)<-sub("tBodyGyroMag-","timebodygyroscopemagnitude",names(thedataset))
names(thedataset)<-sub("tBodyGyroJerk-","timebodygyroscopejerk",names(thedataset))
names(thedataset)<-sub("tBodyGyroJerkMag-","timebodygyroscopejerkmagnitude",names(thedataset))
names(thedataset)<-sub("fBodyAcc-","frequencybodyacceleration",names(thedataset))
names(thedataset)<-sub("fBodyAccMag-","frequencybodyaccelerationmagnitude",names(thedataset))
names(thedataset)<-sub("fBodyAccJerk-","frequencybodyaccelerationjerk",names(thedataset))
names(thedataset)<-sub("fBodyGyro-","frequencybodygyroscope",names(thedataset))
names(thedataset)<-sub("fBodyAccJerkMag-","frequencybodyaccelerationjerkmagnitude",names(thedataset))
names(thedataset)<-sub("fBodyGyroMag-","frequencybodygyroscopemagnitude",names(thedataset))
names(thedataset)<-sub("-", "", names(thedataset))
names(thedataset)<-sub("\\(", "", names(thedataset))
names(thedataset)<-sub("\\)", "", names(thedataset))
names(thedataset)<-sub("std", "standarddevation", names(thedataset))

# Item 5: Create tidy data set with the average of each variable for each activity and each subject
tidydata <- thedataset %>% group_by(subject,activity) %>% summarise_all(mean)
write.table(tidydata, "TidyData.txt", row.name=FALSE)
