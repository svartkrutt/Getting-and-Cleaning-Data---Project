Getting-and-Cleaning-Data---Project
#run_analysis.R
# This script merges a "test" and a "training" data set into a new tidy data set
## Data was collected from smartphones for 30 different users, aged 19-48 years, who each performed six different activities:
###* Walking
###* Walking up stairs
###* Walking down stairs
###* Sitting
###* Standing
###* Laying

This script performs the following actions to create a new data set of average measurements by activity, for each user:
####1. Downloads and unzips the required data, if it isn't in the current working directory
####2. Loads required libraries
####3. Reads all required .txt files from the downloaded data
####4. Selects only measurements with standard deviation and mean data
####5. Assigns appropriate activity and feature names
####6. Combines test and training data
####7. Creates a second, independent tidy data set with the average measurement by activity, for each user. New data set is saved as HAR_tidydata.txt
