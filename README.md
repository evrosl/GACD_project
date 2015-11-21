# README

The `run_analysis.r` script was written for the *Getting and Cleaning Data* course on Coursera. The script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Running the script
1. Download and unzip the data in a local folder. The script will need to be in the same folder as the `UCI HAR Dataset` folder. 
2. Set the working directory to that folder using `setwd()`. 
3. Run `source(run_analysis.r)`. 

## Libraries
A number of packages are used within the script and will need to be installed for the script to run. These are: 

* `data.table`
* `plyr`
* `dply`

## Output
The script will output a text file with a smaller data set, called `tidy.txt` in the working directory folder. 

