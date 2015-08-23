Description:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

R Script - Run_Analysis.R does the following
- If the file CourseProject.zip doesn't exist in the working directory, it downloads the file from the link
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
   and save it in the working directory with the name CourseProject.zip
- Then it unzip the zipped file and creates the directory UCI HAR Dataset
- then reads the activity_lebel.txt file and creats the dataframe actLab and names header.
  So, actLab is a dataframe having the description of the 6 activities associated with id. Six activities are
   Standing,walking,sitting,lying,walking_upstairs,walking_downstairs
- dataframe Ftext, then reads the feature variables from the file features.txt
- subject for Training are read from subject_train.txt file and stored into dataframe trainingSub with the subject.id & category as 'training'
- subject for Test are read from subject_test.txt file and stored into the dataframe testSub with the subject.id and category as 'test'
- y_train.txt is read and the corresponding activity id's are labeled with the activity type in the dataframe yTrainLab for Training set
- y_test.txt is read and the corresponding activity id's are labeled with the activity type in the dataframe yTestLab for Test set
- Train set X_train.txt is read into the dataframe yTrainSet and the columns are lebeled from features (fText)
- The above training dataset is combined with the activity & subject dataset and trainingSet is formed
- Test set X_test.txt is read into the dataframe yTestSet and the columns are lebeled from features (fText)
- The above test dataset is combined with the activity & subject dataset and testSet is formed
- The training and test sets are merged to form combinedSet dataframe
- in the reqFields dataframe columns(features) with mean() and std() are isolated
- from combinedSet dataframe, those observation corresponding to the reqFields are separated into meanStd dataframe
- aggregate() function is used to group the meanStd dataframe on Activity.Type, Observation.Category & Subject.Id, on the basis of which the mean() function has been applied to get the average
- The above operation is stored into the dataframe resultSet and then All NA's were removed (i.e. the last 4 columns)
- Now final cleanDataset is formed by rename-ing the auto-generated columns because of aggregate()
- cleanDataset is the final output file.

