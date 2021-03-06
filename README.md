The script prepares a tidy data with the data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The R script Run_Analysis.R satisfies the following below requirements

    1. Merges the training and the test sets to create one data set - dataframe 'combinedSet' satisfies this requirement
    2. Extracts only the measurements on the mean and standard deviation for each measurement - dataframe 'meanStd' satisfies the requirement
    3. Uses descriptive activity names to name the activities in the data set - dataframe 'resultSet' satisfies the requirement
    4. Appropriately labels the data set with descriptive variable names - dataframe 'resultSet' satisfies the requirement
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject - dataframe 'cleanDataset' is the final tidy data.

The final clean and tidy data cleanDataset is then written into a text file as output.
