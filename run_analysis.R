## This script generates the tidy data
library(reshape)

# Unzip the raw data if we do not find the data folder
dataFolder <- "UCI HAR Dataset"
rawDataFilename <- "getdata-projectfiles-UCI HAR Dataset.zip"

if (!file.exists(dataFolder)) {
  if (!file.exists(rawDataFilename)) {
    stop(paste("Zipped raw data file not present in current folder:", rawDataFilename))
  }
  unzip(rawDataFilename)
}

# Get and clean up the measurement names
measureNames <- function() {
  measureNameFilename <- paste0(dataFolder, "/features.txt")
  names <- read.table(measureNameFilename, stringsAsFactors=FALSE)
  names <- names[[2]] # Actual column name

  # Remove parentheses and commas
  names <- gsub("[(),]", "", names)
  
  # Replace dashes with undercores
  names <- gsub("-", "_", names)
}

# Utility function to generate complete filenames for a group (test or train.)
buildPathForGroupFile <- function(groupName, fileSubname) {
  paste0(dataFolder, "/", groupName, fileSubname, groupName, ".txt")
}

# Extract the data into one data set for a given group (test or train.)
extractGroupData <- function(groupName) {
  subjectFilename <- buildPathForGroupFile(groupName, "/subject_")
  measureFilename <- buildPathForGroupFile(groupName, "/X_")
  activityFilename <- buildPathForGroupFile(groupName, "/Y_")
  
  subjects <- read.table(subjectFilename, colClasses=c("integer"))
  colnames(subjects) <- c("subject_id")
  
  activities <- read.table(activityFilename, colClasses=c("integer"))
  colnames(activities) <- c("activity_id")
  
  measures <- read.table(measureFilename, colClasses=c("numeric"))
  colnames(measures) <- measureNames()
  
  # Extract frequency domain signals variable on mean and standard deviation only
  measuresSubset <- measures[,grep("f.*_(mean|std)_.*", colnames(measures))]

  cbind(subjects, activities, measuresSubset)
}

# Extract test and train data
testData <- extractGroupData("test")
trainData <- extractGroupData("train")

# Merge with rbind
data <- rbind(testData, trainData)

# Add activity name column
activityNameFilename <- paste0(dataFolder, "/activity_labels.txt")
activityNames <- read.table(activityNameFilename, stringsAsFactors=FALSE)
colnames(activityNames) <- c("activity_id", "activity_name")
data <- merge(data, activityNames, by.x="activity_id", by.y="activity_id")
data <- data[,names(data) != "activity_id"] # We don't need that column anymore

## Make a tidy data set with the average of each variable, broken down by subjects and activities.

# Melt data by subject and activity
meltedData <- melt(data, c("subject_id", "activity_name"))

# Recast on the mean
tidyData <- cast(meltedData, subject_id+activity_name~variable, mean)

# Write file
write.csv(tidyData, file="tidyData.txt")
