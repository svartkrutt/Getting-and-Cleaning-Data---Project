# run_analysis.R
# Brandon
## This script merges a "test" and a "training" data set into a new tidy data set
### The merged data set contains an average of each variable for each activity, and each subject

# Load required library
require(data.table)
require(reshape2)

# Download data, unzip, and set as working directory
## Data description here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## also see ./README.txt
## If running multiple times, modify following line to match your working directory
# setwd("your wd here")
fileurl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (file.exists("./accel_data.zip") == FALSE) {download.file(url = fileurl, destfile = "./accel_data.zip")
unzip(zipfile = "./accel_data.zip", exdir = "./accel_data")}
setwd("./accel_data/UCI HAR Dataset")

# 1. Combine the training and the test sets to create one data set with only standard deviation and mean measurement values
## 1a. Read txt files: subject_test, X_test, y_test, subject_train, X_train, y_train, features, activity_labels

subject_test <- read.table(file = "./test/subject_test.txt")    # subject performing test activity
x_test <- read.table(file = "./test/X_test.txt")                # test set for feature
y_test <- read.table(file = "./test/y_test.txt")                # test activity labels

subject_train <- read.table(file = "./train/subject_train.txt") # subject performing training activity 
x_train <- read.table(file = "./train/X_train.txt")             # training set for feature
y_train <- read.table(file = "./train/y_train.txt")             # training activity labels

features <- read.table("./features.txt")                        # list of all features
activity_labels <- read.table("./activity_labels.txt")[,2]      # activity name

## 1b. Select only features with std or mean
feature_names <- features[,2] 
stdmean_features <- grepl("mean|std", feature_names)

## 1c. Set x_test names according to features.txt
names(x_test) = feature_names 
names(x_train) = feature_names

## 1d. Filter test sets for measurements with std or mean
x_test_filtered = x_test[,stdmean_features]
x_train_filtered = x_train[,stdmean_features]

## 1e. Label y_test and y_train, replacing numeric value with activity name, according to activity_labels.txt
y_test[,2] = activity_labels[y_test[,1]]
y_train[,2] = activity_labels[y_train[,1]]
names(y_test) = c("activity_id", "Activity")
names(y_train) = c("activity_id", "Activity")

## 1f. Label Subject
names(subject_test) = "Subject"
names(subject_train) = "Subject"

## 1g. Combine both training and test data by column
test_data <- cbind(as.data.table(subject_test), x_test_filtered, y_test)
train_data <- cbind(as.data.table(subject_train), x_train_filtered, y_train)

## 1h. Combine testing and training data by row
filtered_data <- rbind(test_data, train_data)

## 1i. Add descriptive variable names to filtered_data
names(filtered_data) <- gsub("^t", "time, ", names(filtered_data))
names(filtered_data) <- gsub("^f", "frequency, ", names(filtered_data))
names(filtered_data) <- gsub("Acc", "Accelerometer, ", names(filtered_data))
names(filtered_data) <- gsub("BodyBody", "Body, ", names(filtered_data))
names(filtered_data) <- gsub("Gravity", "Gravity, ", names(filtered_data))
names(filtered_data) <- gsub("Gyro", "Gyroscope, ", names(filtered_data))
names(filtered_data) <- gsub("Jerk", "Jerk, ", names(filtered_data))
names(filtered_data) <- gsub("Mag", "Magnitude, ", names(filtered_data))

# 2. Create a second, independent tidy data set with average of each variable for each activity and subject
## 2a. set labels to average
labels <- c("Subject", "activity_id", "Activity")
data_labels <- setdiff(colnames(filtered_data), labels)

## 2b. Melt data
melted_data <- melt(filtered_data, id = labels, measure.vars = data_labels)

## 2c. Find mean data based on subject and activity
tidydata <- dcast(melted_data, Subject+Activity ~ variable, mean)

# 3. Write new tidy data set to file
write.table(tidydata, file = "./HAR_tidydata.txt", row.names=FALSE)