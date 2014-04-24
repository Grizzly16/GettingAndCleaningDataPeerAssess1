#Read in sensor data and make it all pretty and tidy
##Required libraries
*reshape2
##Read in data files
*Activity lables
*Features file
*Training files
** x_train
** y_train
** subject_train
*Test files
**x_test
**y_test
**subject_test
##Fixing up our data
*Apply column names from feature list files
*Combine train and test X data
*Combine train and test Y data
*Combine subject ID data
*Create a map of activity number to activity name
*Merge activity name to sensor data by activity ID
*Add subject ID numbers to our sensor data
##Manipulate the data
*Convert the full data into a table for easier manipulation later
*Get only the column names that end itn std() or mean()
*Melt our full data set that has these features
**Only the coulmns we selected above
**Is tall and skinny with columns for subject ID, acitivity name, measurement name and value of measurement
**Has clear column names
#Write the data
*Write out a delimited txt file
