##########################################################
#You should create one R script called run_analysis.R that does the following.
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with #the average of each variable for each activity and each subject.
##########################################################
setwd("C:/Study Documents/Z_The Data Science Specialization/3_Getting and Cleaning Data/Assignment")
rm(list=ls())
##########################################################

#Get the data
#1.Download the file and put the file in the data folder

if(!file.exists("fileUrl")){
   dir.create("./Data")
   fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
   download.file(fileUrl,destfile="./Data/Assignment.zip",method="curl")
}

#2.Unzip the file
unzip(zipfile="./Data/Assignment.zip",exdir="./Data")

#3.unzipped files are in the folderUCI HAR Dataset. Get the list of the files
path_dataFolder <- file.path("./Data" , "UCI HAR Dataset")
#path <- list.files(path_dataFolder, recursive=TRUE)
#path


#4.Read datasets from the files into the variables
#Read the Activity files: Y_test and Y_train

Y_test  <- read.table(file.path(path_dataFolder, "test" ,
                                          "Y_test.txt" ),header = FALSE)
Y_train <- read.table(file.path(path_dataFolder, "train",
                                          "Y_train.txt"),header = FALSE)

#5.Read the Subject files: subject_test and subject_train
subject_test <- read.table(file.path(path_dataFolder, "test" ,
                                         "subject_test.txt"),header = FALSE)
subject_train <- read.table(file.path(path_dataFolder, "train",
                                         "subject_train.txt"),header = FALSE)

#6.Read Fearures files: X_test and X_train
X_test <- read.table(file.path(path_dataFolder, "test" ,
                                          "X_test.txt" ), header = FALSE)
X_train <- read.table(file.path(path_dataFolder, "train",
                                "X_train.txt"), header = FALSE)

#Look at the properties of the above varibles
#str(Y_test)
#str(Y_train)

#str(subject_test)
#str(subject_train)

#str(X_train)
#str(Y_train)



#7.Merges the training and the test sets to create one data set
#-Concatenate the data tables by rows
#-Set names to variables
#-Merge columns to get the data frame Data for all data

activity <- rbind(Y_test, Y_train)
names(activity)<- c("activity")
#head(activity)

subject <- rbind(subject_test, subject_train)
names(subject)<- c("subject")


features<- rbind(X_test, X_train)
featuresNames <- read.table(file.path(path_dataFolder, "features.txt"),
                            header=FALSE)
names(features)<- featuresNames$V2
#head(features)

# Merge columns
DatCom <- cbind(subject, activity)
Data <- cbind(features, DatCom)
#head(Data)



#8.Extracts only the measurements on the mean and standard deviation
#for each measurement
#Reading Name of Features and extracting only the mean and standard deviation
subfeaturesNames <- grep("mean\\(\\)|std\\(\\)", featuresNames$V2,value=TRUE)

subfeaturesNames <-featuresNames$V2[grep("mean\\(\\)|std\\(\\)",
                                         featuresNames$V2)]

#9.Subset the data frame Data by seleted names of Features
#and add "subject","activity"
selectedNames <- union(c("subject","activity"), subfeaturesNames)
Data <- subset(Data,select=selectedNames)

#Check the structures of the data frame Data
#str(Data)


#10.Read descriptive activity names from "activity_labels.txt"
#column names for activity labels
activity_labels <- read.table(file.path(path_dataFolder, "activity_labels.txt"),
                             header = FALSE)
names(activity_labels)<- c("activity","activityName")

##11. Enter name of activity into Data
Data <- merge(activity_labels, Data , by="activity", all.x=TRUE)


##12. Create data with variable means sorted by subject and Activity
Data$activityName <- as.character(Data$activityName)
dataAggr<- aggregate(. ~ subject +activityName, data = Data, mean)
Data <-Data[order(Data$subject,Data$activity),]




#13. Appropriately labels the data set with descriptive variable names
names(Data)<-gsub("std()", "sd", names(Data))
names(Data)<-gsub("mean()", "mean", names(Data))
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

#head(str(Data),6)
#names(Data)

#14.Creates a second, independent tidy data set
#with the average of each variable for each activity and each subject.
##write to text file on disk
write.table(Data, file = "tidydata.txt", row.names=FALSE)



