# Getting and Cleaning ReadMe
# 
This folder contains the files README.md and the file run_analysis.R for
the Coursera course Getting And Cleaning Data.

The data set is taken from smartphone data that was collected for
Anguita, Davide, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
"A Public Domain Dataset for Human Activity Recognition Using Smartphones." 
ESANN 2013 proceedings, 2013.  http://www.i6doc.com/en/livre/?GCOI=28001100131010.

## Assignment Task
## 
Run_analysis.R should do the following.

	# Merges the training and the test sets to create one data set.

	This requires that we create a table by converting the text files in the Train folder into column vectors. 
	First we convert the Subject and the Y text files. We then cbind them.
	Then we take the X data text and convert it to CSV. 
	We then C-bind that to the table we have created. 
	vectors to create a readable table of the Train values. 
	We then do the same to the Test values, creating another table that is identical in format.
	Last, we rbind the Train and Test values together.

	# Extracts only the measurements on the mean and standard deviation
	for each measurement.
	
We use a grep vector that selects for matching the string "mean" or "std" in the features array. 
(I am choosing to match it to any string with those values.) 
We modify it to add the values 1 (the subject code column) and 2 (the activity code column), and then
add 2 to every further iteration to get the right column number from the features list. 

We rename the new data set we have "smallerdata."

 	# Uses descriptive activity names to name the activities in the data set 
 	
We do a find-and-replace (grep) of the Activity column and replace 
		1 with Walking Upstairs, 
		2 with Walking Up, 
		3 with Walking Downstairs, 
		4 with Sitting, 
		5 with Standing 
		6 with Lying Down.
		
		Note that this must be done after the data tables are created and merged, because otherwise the data
		will be reordered and the row values for the actual subjects and activities will not match! 
 	
 	# Appropriately labels the data set with descriptive
 	variable names. 
 	
We do a find-and-replace (grep) of the features info to expand the feature names: 
 	(Acc to Acceleration, t to Time, f to FFT, Mag to Magnitude)
 	and add  
 		Subject ID and Activity to the front of that vector. 
 		We then assign that vector to the column names of the smallerdata set.
 		
 	(I am NOT using the Inertial folder values, as they are merely included for verifying.)
 	 	
 	# From the data set in step 4, creates a second,
 	independent tidy data set with the average of each variable for
 	each activity and each subject.
 	
 	We use group_by() to group the smallerdata set by Subject.ID and Activity, 
 	writing to a new data frame called tidydata.
 	
 	We then use Summarise_all() to summarise it by mean. This should create a wide tidy data set, 
 	rather than a narrow one as would be created if I had used the melt() function. 
 	
 	We then use write_table() to write the tidydata table down.  
 	
 	
 	
 	
 	

