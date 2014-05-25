Getting-and-Cleaning-Data
=========================

Course Project for Getting and Cleaning Data

This project contains a script to generate a tidy data set from a raw data set.

The raw data set in question contains measurement obtained from accelerometers worn by subjects performing various activities.

The data acquisition is explained here: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

As a prerequisite, this file should be in the same folder as the
run_analysis.R script:
[getdata-projectfiles-UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Performing the following on the command line would generate a tidy data set file named tidyData.csv in the current folder.

`r CMD BATCH run_analysis.R`

The R script will unzip the archive of the raw data files, merge them, clean them and generate a tidy data file.

The codebook explains the variables, data and transformations applied to the raw data to create the tidy data.
