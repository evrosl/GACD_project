# CobeBook

The script `run_analysis.r` was written for *Getting and Cleaning Data* course on Coursera. It picks up the data found at the links below and performs various operations on them, outputting a simpler data set in the end.  

## Original data
The original data for this project can be found at 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
with a full description at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Operations on data

The training and testing data from that database were loaded into variables `DT_train` and `DT_test` and then merged into `DT`.

Column names where added from the corresponding text files in the raw data. 

From the data set the indices of columns with mean and standard deviation values were collected and a new data set `DT_ms` was constructed using only these values. 

The activity column with an integer ID was replaced with a descriptive string.

The `gsub` function was used to rename the remaining columns to a more easily readable format. 

A smaller data set was created called `tidy_set`, by grouping by subject and activity and averaging the remaining columns accordingly. This set was written to file `tidy.txt`.