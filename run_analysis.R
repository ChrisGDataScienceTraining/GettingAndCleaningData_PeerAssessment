# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 



getDataSet <- function () {
  cat("Checking if data directory exists\n")
  if(!file.exists("./data")){ dir.create("./data"); cat ("Drectory created\n") }
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  cat("Downloading data set", fileUrl,"\n")
#   download.file(fileUrl,destfile="./data/dataset.zip",method="curl")
  list.files("./data")
  cat("Extracting files\n")
#   unzip("./data/dataset.zip", exdir="./data")
  list.files("./data/UCI HAR Dataset/") 
}

loadDataSet <- function () {
  
  cat("Loading test data\n")
  test <<- read.table("~/Documents/R_Files/GettingAndCleaningData_PeerAssessment/data/UCI HAR Dataset/test/X_test.txt", quote="\"")
  cat("Loading the test label ids\n")
  testLabelsId <<- read.table("~/Documents/R_Files/GettingAndCleaningData_PeerAssessment/data/UCI HAR Dataset/test/y_test.txt", quote="\"")
  cat("Loading activity labels for test data set\n")
  activityLabels <<- read.table("~/Documents/R_Files/GettingAndCleaningData_PeerAssessment/data/UCI HAR Dataset/activity_labels.txt", quote="\"")
  
  cat("Loading training data \n")
  train <<- read.table("~/Documents/R_Files/GettingAndCleaningData_PeerAssessment/data/UCI HAR Dataset/train/X_train.txt", quote="\"")
  cat("Loading training label ids\n")
  trainLabelsId <<- read.table("~/Documents/R_Files/GettingAndCleaningData_PeerAssessment/data/UCI HAR Dataset/train/y_train.txt", quote="\"")
  
  cat("Loading feature labels \n")
  features <<- read.table("~/Documents/R_Files/GettingAndCleaningData_PeerAssessment/data/UCI HAR Dataset/features.txt", quote="\"")

}


mergeDataSet <- function () {
  cat("Merging testing and training data sets\n")
  merged <<- rbind(test,train)
  names(merged)
  cat("Renaming columns\n")
  names(merged)<-features$V2
  cat("Adding activ ids\n")
  merged<<-cbind(merged, c(testLabelsId$V1, trainLabelsId$V1))
  names(merged)[nrow(features)+1] <- "ActivityId"
  names(merged)
  

}

extractDataSet <- function () {
  cat("Extracting columns\n")
  merged <<- merged[, grep ("mean|std", features$V2)]
  names(merged)
}

startAnalysis <- function () {
  getDataSet()
  loadDataSet()
  mergeDataSet()
  extractDataSet()
 
  
}

