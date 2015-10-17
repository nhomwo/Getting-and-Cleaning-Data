#Getting and Cleaning Data Project
   
   The datset of the project is originally from (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


Files in the project includes (1) README.md : you are reading, (2) CodeBook.md : codebook describing variables, the data and transformations, and (3) run_analysis.R : actual R code.


R script does the following by those steps: 
1. Merges the training and the test sets to create one data set. 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set. 
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Merges the training and the test sets to create one data set. 
1. Step 1: Get the data.
Download the file and put the file in the data folder.

2. Step 2: Unzip the file.

3. Step 3: Unzipped files are in the folder "data/UCI HAR Dataset". 
Get the list of the files.

4. Step 4: Read datasets from the files into the variables by reading
the Activity files: *Y_test* and *Y_train*.


5. Step 5: Read the Subject files, *subject_test* and *subject_train*.


6. Setep 6: Read Fearures files: *X_test* and *X_train*.


7. Step 7: Merges the training and the test sets to create one data set, by following these step, concatenate the data tables by rows, set names to variables and merge columns to get the data frame.

###Extracts only the measurements on the mean and standard deviation for each measurement.
8. Step 8: Extracts only the measurements on the mean and standard deviation for each measurement.

9. Step 9: Subset the data frame by selecting names of features.

###Uses descriptive activity names to name the activities in the data set. 
10. Step 10: Read descriptive activity names from *"activity_labels.txt".*


11. Step 11: Enter name of activity into data.


12. Step 12: Create data with variable means and sorted by subject and activity.

###Appropriately labels the data set with descriptive activity names. 
13. Step 13: Appropriately labels the data set with descriptive variable names

###Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
14. Step 14: Creates a second, independent tidy data set with the average of each variable for each activity and each subject with writing to text file on disk called *"tidydata.txt".*



