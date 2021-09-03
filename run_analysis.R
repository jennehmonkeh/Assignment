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

# Item 4: Label the data set with descriptive variable names (still horrendous)
names(thedataset)<-sub("tGravity","timegravit",names(thedataset))
names(thedataset)<-sub("tBody","timebody",names(thedataset))
names(thedataset)<-sub("fBodyBody","frequencybody",names(thedataset))
names(thedataset)<-sub("fBody","frequencybody",names(thedataset))
names(thedataset)<-sub("Acc","acceleration",names(thedataset))
names(thedataset)<-sub("Mag","magnitude",names(thedataset))
names(thedataset)<-sub("Freq","frequency",names(thedataset))
names(thedataset)<-sub("Gyro","gyroscope",names(thedataset))
names(thedataset)<-sub("Jerk","jerk",names(thedataset))
names(thedataset)<-gsub("-","", names(thedataset))
names(thedataset)<-gsub("\\(","", names(thedataset))
names(thedataset)<-gsub("\\)","", names(thedataset))
names(thedataset)<-gsub("\\,","", names(thedataset))
names(thedataset)<-sub("std", "standarddevation", names(thedataset))
names(thedataset)<-gsub("Mean", "mean", names(thedataset))


# Item 5: Create tidy data set with the average of each variable for each activity and each subject
tidydata <- thedataset %>% group_by(subject,activity) %>% summarise_all(mean)
write.table(tidydata, "TidyData.txt", row.name=FALSE)
