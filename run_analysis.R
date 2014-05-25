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
  names <- gsub("[(),]", "", names)
  
  # Replace dashes with undercores
  names <- gsub("-", "_", names)
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
  
  measures <- read.table(measureFilename, colClasses=c("numeric"))
  colnames(measures) <- measureNames()
  
  # Extract frequency domain signals variable on mean and standard deviation only
  # mn[grep("*_(mean|std)_*", mn)]
  measuresSubset <- measures[,grep("f.*_(mean|std)_.*", colnames(measures))]

  cbind(subjects, activities,measuresSubset)
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

# Make a tidy data set with the average of each variable, broken down by subjects and activities.

# Melt and reshape?

# Write file
write.csv(tidyData, file = "tidyData.csv")
