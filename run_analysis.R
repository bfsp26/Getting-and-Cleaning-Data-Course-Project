library(dplyr)

# dataset
dataset <- "./getdata_projectfiles_UCI HAR Dataset.zip"

# Check if dataset exists
if (!file.exists(dataset)) {
    dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url = dataURL, destfile = dataset, method = "curl")
    unzip(dataset)
} else {
    unzip(dataset)
}

## Merges the training and the test sets to create one data set.

# Load features and activities
feature_label <- read.table(file = "./UCI HAR Dataset/features.txt", col.names = c("id", "feature"))
activity_labels <- read.table(file = "./UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity"))

# Load training and test data
s_training <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", col.names = "subject_id")
x_training <- read.table(file = "./UCI HAR Dataset/train/X_train.txt")
names(x_training) <- feature_label$feature
y_training <- read.table(file = "./UCI HAR Dataset/train/y_train.txt", col.names = "activity_id")

s_test <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt", col.names = "subject_id")
x_test <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")
names(x_test) <- feature_label$feature
y_test <- read.table(file = "./UCI HAR Dataset/test/y_test.txt", col.names = "activity_id")


# Combine data by rows
volunteers <- rbind(s_training, s_test)
features <- rbind(x_training, x_test)
activities <- rbind(y_training, y_test)

nrow(volunteers)
nrow(features)
nrow(activities)

# Merge data
data <- cbind(volunteers, activities, features)

## Extracts only the measurements on the mean and standard desviation for each measurement.
fil_data <- select(data, subject_id, activity_id, contains("mean"), contains("std"))

## Uses descriptive activity names to name the activities in the data set
fil_data$activity_id <- activity_labels[fil_data$activity_id, names(activity_labels)[2]]

## Appropriately labels the data set with descriptive variable names.
names(fil_data) <- gsub("^f", "FrequencyDomain", names(fil_data), ignore.case = F)
names(fil_data) <- gsub("^t", "TimeDomain", names(fil_data), ignore.case = F)
names(fil_data) <- gsub("Acc", "Accelerometer", names(fil_data))
names(fil_data) <- gsub("Gyro", "Gyroscope", names(fil_data))
names(fil_data) <- gsub("Mag", "Magnitude", names(fil_data))
names(fil_data) <- gsub("angle", "Angle", names(fil_data))
names(fil_data) <- gsub("gravity", "Gravity", names(fil_data))

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
by_activity <- group_by(fil_data, activity_id, subject_id)
tidy_data <- summarise_all(by_activity, list(mean))
View(tidy_data)

## Create a tidy dataset
write.table(tidy_data, file = "tidyDataset.txt", row.names = F)

