## This script generates the tidy data

# Unzip the raw data if we do not find the data folder
dataFolder <- "UCI HAR Dataset"
rawDataFilename <- "getdata-projectfiles-UCI HAR Dataset.zip"

if (!file.exists(dataFolder)) {
  if (!file.exists(rawDataFilename)) {
    stop(paste("Zipped raw data file not present in current folder:", rawDataFilename))
  }
  unzip(rawDataFilename)
}

measureNames <- function() {
  measureNameFilename <- paste0(dataFolder, "/features.txt")
  names <- read.table(measureNameFilename, stringsAsFactors=FALSE)
  names <- names[[2]] # Actual column name

  # Remove parentheses and commas
  # Replace dashes with undercores
}

buildPathForGroupFile <- function(groupName, fileSubname) {
  paste0(dataFolder, "/", groupName, fileSubname, groupName, ".txt")
}

extractGroupData <- function(groupName) {
  subjectFilename <- buildPathForGroupFile(groupName, "/subject_")
  measureFilename <- buildPathForGroupFile(groupName, "/X_")
  activityFilename <- buildPathForGroupFile(groupName, "/Y_")
  
  subjects <- read.table(subjectFilename, colClasses=c("integer"))
  colnames(subjects) <- c("subject_id")
  
  activities <- read.table(activityFilename, colClasses=c("integer"))
  colnames(activities) <- c("activity_id")
  
  #measures <- read.table(measureFilename, colClasses=c("numeric"))
  #colnames(measures) <- measureNames()
}

testData <- extractGroupData("test")
trainData <- extractGroupData("train")

# Merge with rbind

# Add activity name column

# Only keep subject id, activity names, mean & standard deviation measurements 

# Write file
