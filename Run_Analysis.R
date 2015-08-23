runAnalysis <- function(){
  download.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  fileName <- "CourseProject.zip"
  
  if(!file.exists(fileName)){
    download.file(download.url,destfile=fileName,method="libcurl")
    unzip(fileName)
  }
  
  projDir <- "UCI HAR Dataset"
  
  library(dplyr)
  library(stringr)
  
# Reading the activity Label  
  actLab <- read.table(paste(projDir,"activity_labels.txt",sep="/"))
  names(actLab) <- c("Activity.Id","Activity.Type")

# Reading the features
  fText <- read.table(paste(projDir,"features.txt",sep="/"))
  
# Reading Trainig and Test Subjects who performed the activity
  trainingSub <- read.table(paste(projDir,"train","subject_train.txt",sep="/"))
  names(trainingSub) <- c("Subject.Id")
  trainingSub <- mutate(trainingSub,Category = "training")
  
  testSub <- read.table(paste(projDir,"test","subject_test.txt",sep="/"))
  names(testSub) <- c("Subject.Id")
  testSub <- mutate(testSub,Category = "test")
  
# Reading Training & Test Label
  yTrainLab <- read.table(paste(projDir,"train","y_train.txt",sep="/"))
  names(yTrainLab) <- c("Activity.Id")
  yTrainLab <- mutate(yTrainLab,Activity.Type = actLab[yTrainLab[,1],2])

  yTestLab <- read.table(paste(projDir,"test","y_test.txt",sep="/"))
  names(yTestLab) <- c("Activity.Id")
  yTestLab <- mutate(yTestLab,Activity.Type = actLab[yTestLab[,1],2])

# Reading & labeling Training & Test set
  yTrainSet <- read.table(paste(projDir,"train","X_train.txt",sep="/"))
  names(yTrainSet) <- fText[,2]
  trainingSet <- cbind(yTrainSet,trainingSub,yTrainLab)

  yTestSet <- read.table(paste(projDir,"test","X_test.txt",sep="/"))
  names(yTestSet) <- fText[,2]
  testSet <- cbind(yTestSet,testSub,yTestLab)

# Getting required Fields - mean & standard deviation
  reqFields <- grepl("mean",as.character(fText[,2])) | 
               grepl("std",as.character(fText[,2]))
  reqFields <- fText[reqFields,]

# 1. Merging the Training & Test set
  combinedSet <- rbind(trainingSet,testSet)

# 2. Extracting only Mean and Std
  meanStd <- combinedSet[,as.character(reqFields[,2])]
# meanStd <- as.double(meanStd[,1:79])
  meanStd <- cbind(meanStd,combinedSet[,562:565])
  

# average of each variable for each activity and Subject
  resultSet <- aggregate(meanStd,by = list(meanStd$Activity.Type,
                                           meanStd$Category,
                                           meanStd$Subject.Id),mean)
  resultSet <- resultSet[,1:82]

# Preparing the final tidy data
  library(plyr)
  cleanDataset <- rename(resultSet,c("Group.1" = "ActivityName",
                                  "Group.2" = "ObservationFrom",
                                  "Group.3" = "ObservationSubject"))
# Writng the Tidy dataset into a text file
# write.csv(cleanDataset,"Clean_Dataset.csv",row.names=TRUE,sep=" ")
write.table(cleanDataset,"Clean_Dataset.txt",row.names=FALSE,sep="\t")
}