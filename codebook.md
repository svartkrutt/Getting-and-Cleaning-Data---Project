#Codebook for run_analysis.R

##Data

###Data https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
###Data Set information http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


### All files used were .txt, and were of three main types:
#### subject: The subjects carrying out the activity, coded 1 through 30
#### X: Feature measurements, normalized [-1,1]
#### Y: Activity labels, coded 1 through 6

##### Two secondary file types were used:
###### Activity Labels: relate codes in Y to their activity
###### Features: define each feature, used to determine data containing standard deviation and mean values for run_analysis.R
### Files Used:
#### subject_test.txt 
#### subject_train.txt 
#### X_train.txt 
#### X_test.txt
#### y_test.txt
#### y_train.txt
#### activity_labels.txt
#### features.txt

##Analysis
### 1. Combine the training and the test sets to create one data set with only standard deviation and mean measurement values
#### 1a. Read txt files: subject_test, X_test, y_test, subject_train, X_train, y_train, features, activity_labels
#### 1b. Select only features with std or mean
#### 1c. Set x_test names according to features.txt
#### 1d. Filter test sets for measurements with std or mean
#### 1e. Label y_test and y_train, replacing numeric value with activity name, according to activity_labels.txt
#### 1f. Label Subject
#### 1g. Combine both training and test data by column
#### 1h. Combine testing and training data by row
#### 1i. Add descriptive variable names to filtered_data:
#####time, frequency, accelerometer, body, gravity, gyroscope, jerk, magnitude
### 2. Create a second, independent tidy data set with average of each variable for each activity and subject
#### 2a. set labels to average
#### 2b. Melt data
#### 2c. Find mean data based on subject and activity
### 3. Write new tidy data set to file