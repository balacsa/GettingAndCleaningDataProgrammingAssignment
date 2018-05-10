# GettingAndCleaningDataProgrammingAssignment

This repository is for "Getting and Cleaning Data course" programming assignment on Coursera. The name of the code is run_analysis.R which written in R language.

The task was to download data from an URL, unzip it and build a tidy data set.

The code does the following tasks:

- Downloads the dataset and unzip to the local working directory.
- Reads both of test and train files, features and activities.
- Merges the training and the test datas to create one data set.
- Keeps the subject, activity, mean and std columns.
- Converts the activity values to activity names.
- Sets the column names using readable names.
- Creates an independent tidy dataset which contains of the mean value of each variable for each subject and activity pair.

The output file name is tidydata.txt, the separator character is semicolon.
