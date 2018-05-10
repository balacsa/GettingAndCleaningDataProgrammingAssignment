# set envirnoment variables
rawDataUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
rawDataFileName <- 'getdata_projectfiles_UCI_HAR_Dataset.zip'
workDir <- 'C:/CourseraDataScientistCourse/03_GettingAndCleaningData/ProgrammingAssignment'
zipFileName <- paste(workDir,rawDataFileName, sep ='/')
zipDir <- paste(workDir,'UCI HAR Dataset', sep ='/')

# Download and unzip the dataset
if (!file.exists(zipFileName)){
    download.file(rawDataUrl, zipFileName)
} else {
    #print("File has been already downloaded.")
    unzip(zipFileName, exdir = workDir)
}

# reading train and test data files
trainSubjects <- read.table(file.path(zipDir, "train", "subject_train.txt"))
testSubjects  <- read.table(file.path(zipDir, "test",  "subject_test.txt"))

trainValues <- read.table(file.path(zipDir, "train", "X_train.txt"))
testValues  <- read.table(file.path(zipDir, "test",  "X_test.txt"))

trainActivity <- read.table(file.path(zipDir, "train", "y_train.txt"))
testActivity  <- read.table(file.path(zipDir, "test",  "y_test.txt"))

# read features
features <- read.table(file.path(zipDir, "features.txt"), as.is = TRUE)

# read activity labels
activities <- read.table(file.path(zipDir, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")

# merging train and test data
trainData <- cbind(trainSubjects, trainValues, trainActivity)
testData <- cbind(testSubjects, testValues, testActivity)

# merge all data to one table
allData <- rbind(trainData,testData)
colnames(allData) <- c("subject", features[, 2], "activity")

# keep the selected columns
selectedColumns <- grepl("subject|activity|mean|std", colnames(allData))
shortData <- allData[, selectedColumns]

# convert activity values to names
shortData$activity <- factor(shortData$activity,labels=activities[,2])

#correct the column names
names(shortData) <- gsub("^t", "timeDomain", names(shortData))
names(shortData) <- gsub("^f", "frequencyDomain", names(shortData))
names(shortData) <- gsub("Acc", "Accelerometer", names(shortData))
names(shortData) <- gsub("Gyro", "Gyroscope", names(shortData))
names(shortData) <- gsub("Mag", "Magnitude", names(shortData))
names(shortData) <- gsub("BodyBody", "Body", names(shortData))
names(shortData) <- gsub("Freq", "Frequency", names(shortData))
names(shortData) <- gsub("mean", "Mean", names(shortData))
names(shortData) <- gsub("std", "StandardDeviation", names(shortData))
# remove special characters
names(shortData) <- gsub("-", "", names(shortData))
names(shortData) <- gsub("\\(", "", names(shortData))
names(shortData) <- gsub("\\)", "", names(shortData))

# create tidy data set
tidyData<-aggregate(. ~subject + activity, shortData, mean)
tidyData<-tidyData[order(tidyData$subject,tidyData$activity),]
write.table(tidyData, file = paste (workDir,"tidydata.txt",sep = '/'),row.name=FALSE,quote = FALSE,sep=';')