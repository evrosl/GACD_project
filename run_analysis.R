# The R script below does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

# setwd('GACD_project/') # set working directory
library(data.table) # load data.table package
####################
f_train <- list.files("./UCI HAR Dataset/train/", pattern="*.txt", full.names = TRUE)
dat_train <- lapply(f_train,read.table) # and this to import
DT_train <- data.table(dat_train[[2]]) # choose the train set
# now we need to label the columns (561)
features <- read.table("./UCI HAR Dataset/features.txt")
names(DT_train) <- as.character(features$V2)
# and we need to add the data for which person and which activity to each row
DT_train$subject <- dat_train[[1]]
DT_train$activity_label <- dat_train[[3]]
######################
f_test <- list.files("./UCI HAR Dataset/test/", pattern="*.txt", full.names = TRUE)
dat_test <- lapply(f_test,read.table) # and this to import
DT_test <- data.table(dat_test[[2]]) # choose the train set
# now we label the columns (561)
names(DT_test) <- as.character(features$V2)
# and we add the data for which person and which activity to each row
DT_test$subject <- dat_test[[1]]
DT_test$activity_label <- dat_test[[3]]
# ----------------------------------------
# 1. merge data sets
# ----------------------------------------
DT <- rbind(DT_train,DT_test)

# ----------------------------------------
# 2. get indices of mean and std values
# # ----------------------------------------
msInd <- grep("mean\\(\\)|std\\(\\)|activity_label|subject", names(DT))
DT_ms <- DT[,msInd, with=FALSE]

# ----------------------------------------
# 3. add column with activity name
# ----------------------------------------
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names=c("id", "name"))
for (i in 1:nrow(activities)) {
  DT_ms$activity_label[DT_ms$activity_label == activities[i, "id"]] <- as.character(activities[i, "name"])
}

# ----------------------------------------
# 4. add descriptive variable names
# ----------------------------------------
old_var_names <- names(DT_ms)
new_var_names <- gsub("^t(.*)", "\\1 time", old_var_names)
new_var_names <- gsub("^f(.*)", "\\1 frequency", new_var_names)
new_var_names <- gsub("-"," ", new_var_names)
new_var_names <- gsub("mean\\(\\)","Mean", new_var_names)
new_var_names <- gsub("std\\(\\)","StD", new_var_names)
new_var_names <- gsub("BodyBody","Body", new_var_names)
new_var_names <- gsub("Acc"," Acceleration", new_var_names)
new_var_names <- gsub("(Jerk|Gyro)"," \\1", new_var_names)
new_var_names <- gsub("Mag"," Magnitude", new_var_names)
new_var_names <- gsub("subject","Subject", new_var_names)
new_var_names <- gsub("activity_label","Activity", new_var_names)
# assign to names
names(DT_ms) <- new_var_names

# ----------------------------------------
# 5. create independent tidy set
# ----------------------------------------
library(plyr)
library(dplyr) 
# 
tidy_set <- DT_ms %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
write.table(tidy_set,file="tidy.txt",row.names = FALSE)
