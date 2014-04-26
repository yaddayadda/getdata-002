# Obtain/Download data and unzip it
obtainData <- function(fileURL="NA"){
  
  if (fileURL == "NA"){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL,destfile="samsungdata.zip",method="curl")
    unzip( "samsungdata.zip" )
    message(paste0( "Downloaded and Unzipped \"UCI HAR Dataset\" in directory ",getwd() ))
  }
  
}

# Populate the data into tables with both train and test set merged
readData <- function(pathprefix,setName,featureNames)
{
  #Set the path prefix for the dataset type 
  pathprefix <- paste0( pathprefix,setName,"/" )
  
  #Read the data file with feature observations per subject
  dataSet <- read.table( paste0(pathprefix,"x_",setName,".txt"),col.names=featureNames)   
  
  # Add corresponding Activity IDs for the observations to the data set
  subjectActivities <- read.table( paste0(pathprefix,"y_",setName,".txt"),col.names=c("ActivityID") )
  dataSet$ActivityID <- subjectActivities$ActivityID

  #Add the subject ID per observation
  subjectID <- read.table(paste0(pathprefix,"subject_",setName,".txt"),col.names=c("SubjectID"))
  dataSet$SubjectID <- subjectID$SubjectID
  
  dataSet
}


# Load both train and test data
mergeData <- function(pathprefix)
{

  featureNames <- readFeatureLabels(pathprefix)
  
  train <- readData(pathprefix,"train",featureNames)
  test <- readData(pathprefix,"test",featureNames)
  
  #Merge Train and Test Data Set
  dataSet <- rbind(train,test)
  dataSet
}


# Reduce the feature space to just the ones required

# There is a ambiguity in the questions if just the mean() and std() features are to be extracted
# Or if meanFreq() is also to be extracted. I have made the code flexible to obtain both.
# By default only the mean(),std() and meanFreq() will be extracted. To extract with meanFreq()
# run main function with includeMeanFreq = FALSE

reduceFeatureSpace<-function(dataSet,includeMeanFreq = TRUE){

  # extract only the require feature measurements
  if (includeMeanFreq == TRUE)
  {
    featuresToExtract <- grep("Mean|Std|MeanFreq|ActivityID|SubjectID",colnames(dataSet))
    dataSet <- dataSet[,featuresToExtract]    
  }
  else
  {
    featuresToExtract <- grep("Mean[^F]|Std|ActivityID|SubjectID",colnames(dataSet))
    dataSet <- dataSet[,featuresToExtract]    
  }
  
dataSet
}

changeActivityIdToDesc<-function(dataSet,pathprefix)
{
  #pick the activity label mapping
  activityNames <- read.table(paste0(pathprefix,"activity_labels.txt"),col.names=c("ActivityID","ActivityName"))
  
  # Add descriptive activity names to the data set
  dataSet$No <- 1:nrow(dataSet)
  dataSet <- merge(dataSet,activityNames,by.x="ActivityID",by.y="ActivityID")
  dataSet <- with(dataSet,dataSet[order(dataSet$No),])

  #Clean the Feature Labels to be more readable
  colnames(dataSet) <- gsub('\\(|\\)',"",names(dataSet), perl = TRUE)
  colnames(dataSet) <- gsub('\\-',"",names(dataSet), perl = TRUE)
  colnames(dataSet) <- gsub('\\.',"",names(dataSet), perl = TRUE)
  
  dataSet
}


readFeatureLabels<-function(pathprefix)
{

  featureNames <- read.table(paste0(pathprefix,"features.txt"),col.names=c("FeatureID","FeatureName"))

  # Make the required feature labels readable
  featureNames$FeatureName <- gsub("mean","Mean",featureNames$FeatureName)
  featureNames$FeatureName <- gsub("std","Std",featureNames$FeatureName)
  
  featureNames$FeatureName
}

tidyUpData<-function(dataSet)
{
  library(reshape2)
  colNames <- c("SubjectID","ActivityName")
  reshaped <- melt(dataSet,id.vars=colNames,na.rm=TRUE)
  tidyDataSet <- dcast(reshaped,SubjectID + ActivityName ~variable,mean)
  tidyDataSetNames <- colnames(tidyDataSet)
  tidyDataSetNames <- tidyDataSetNames[tidyDataSetNames != "No" & tidyDataSetNames != "ActivityID"]
  tidyDataSet <- subset(tidyDataSet,select=tidyDataSetNames)
  tidyDataSet
}

main<-function(outputFileName="final.txt",includeMeanFreq=TRUE)
{
  #0 Obtain Data
  dataDir <- "UCI HAR Dataset"
  if (!file.exists(dataDir))
  {
    obtainData()    
  }
  pathprefix <- paste0(dataDir,"/")
  
  # 1 Merge the training and the test sets to create one data set.
  dataSet <- mergeData(pathprefix)
  
  # 2 Extract only the measurements on the mean and standard deviation for each measurement. 
  dataSet <- reduceFeatureSpace(dataSet,includeMeanFreq)
  
  # 3  & 4 Change descriptive activity names to name the activities in the data set
  # and appropriately label the data set with descriptive activity names. 
  dataSet <- changeActivityIdToDesc(dataSet,pathprefix)
  
  # 5 Creates a independent tidy data set with the average of each variable for each activity and each subject.
  tidyDataSet <- tidyUpData(dataSet)
  
  # 6 Write the tidy data to a file
  write.table(tidyDataSet,outputFileName)
  
  message(paste0("clean data is written to file ",outputFileName))
  message(paste0("Directory Path: ",getwd()))
}