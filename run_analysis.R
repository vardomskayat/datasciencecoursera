# Run_Analysis.R

/* 
Run_analysis.R should do the following.

	Merges the training and the test sets to create one data set.
	Extracts only the measurements on the mean and standard deviation for each measurement.
 	Uses descriptive activity names to name the activities in the data set
	Appropriately labels the data set with descriptive variable names.
	From the data set in step 4, creates a second, independent tidy data set 
		with the average of each variable for each activity and each subject
 */
 
/* Merge the data set */


features <- read.table("~/UCI HAR Dataset/features.txt", quote="\"", comment.char="")
X_train <- read.table("~/UCI HAR Dataset/train/X_train.txt",  quote="\"", comment.char="")
train_subject <- read.table("~/UCI HAR Dataset/train/subject_train.txt",  quote="\"", comment.char="")
train_activity <- read.table("~/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
traindata <- cbind(train_subject, train_activity, X_train) # We have created a full data frame of the training data

X_test <- read.table("~/UCI HAR Dataset/test/X_test.txt", quote="\"",  comment.char="")
test_subject <- read.table("~/UCI HAR Dataset/test/subject_test.txt",  quote="\"", comment.char="")
test_activity <- read.table("~/UCI HAR Dataset/test/y_test.txt", quote="\"",  comment.char="")
testdata <-  cbind(test_subject, test_activity, X_test) # We have created a full data frame of the testing data

fulldata <- rbind(traindata, testdata) # This is a data frame that combines training and testing. It has as many rows as the two of them combined.


/* Extract the measurements of the mean and standard deviation */

featuresNew <- c(1, 2, grep(as.character("mean|std"), as.character(features$V2)) + 2)
// seeks out the column numbers that have mean or std in them sm
// adds 2 because there are two extra columns at front of table

act <- read.table("~/UCI HAR Dataset/activity_labels.txt")

smallerdata <- fulldata[featuresNew]

/* Label the data set with descriptive variable names */

smallerdata$V1.1 <- act$V2[smallerdata$V1.1] # Replaces the activity codes with the ones in the lookup table.

smallerFeatures <- grep(as.character("mean|std"), as.character(features$V2), value=TRUE) /# We create the table of feature names as they look now.

// A series of substitutions to make the names more descriptive. 
smallerFeatures <- gsub("tBody", "TimeBody", smallerFeatures)
smallerFeatures <- gsub("BodyAcc", "BodyAcceleration", smallerFeatures)
smallerFeatures <- gsub("-","\\.",smallerFeatures)
smallerFeatures <- gsub("fBody", "FFTofBody", smallerFeatures)
smallerFeatures <- gsub("Mag", "Magnitude", smallerFeatures)
smallerFeatures <- gsub("tGravityAcc", "TimeGravityAcceleration", smallerFeatures) 

smallerFeatures <- c("Subject.ID", "Activity", smallerFeatures) // This creates what we want as our descriptive names.
colnames(smallerdata) <- smallerFeatures // Column names have been set to more descriptive names


/* Create a second, independent tidy data set with the average of each variable for each activity and for each subject */

tidydata <-  tidydata %>% group_by(Subject.ID, Activity) 
tidydata <- tidydata %>% summarise_all(mean) // We group by subject ID and by Activity

write.table(tidydata, row.names=FALSE) // We create the table.
