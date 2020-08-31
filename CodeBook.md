# **Getting and Cleaning Data Course Project**

## Relevant information. 

The script `run_analysis.R` does the following:

1. Dataset download

    The data can be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
    
    Load the necessary data to the following variables:
    
    - `feature_label`: Variable for *features.txt* data
    - `activity_labels`: Variable for *activity_labels.txt* data
    - `s_training`: Variable for *subject_train.txt* data
    - `x_training`: Variable for *X_train.txt* data
    - `y_training`: Variable for *y_train.txt* data
    - `s_test`: Variable for *subject_test.txt* data
    - `x_test`: Variable for *X_test.txt* data
    - `y_test`: Variable for *y_test.txt* data

2. Merges the training and the test sets to create one data set.

    Combine the data by rows using the `rbind()` function:
    
        - `volunteers`
        - `features`
        - `activities`
    
    
    The `cbind()` function is used to merge the data:
    
        - `data`


3. Extracts only the measurements on the mean and standard deviation for each measurement.

    Select the required variables of a data frame with the `select()` function from the *dplyr* library, and create a new data set (*fil_data*).


4. Uses descriptive activity names to name the activities in the data set.

    Swap the activity identifiers for the corresponding activity names.


5. Appropriately labels the data set with descriptive variable names.

    Replace a string that follows a certain pattern with the help of the `gsub()` function.

6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

    A new data set is created with the average of each variable for each activity and subject.
    
    - `group_by()` takes an existing tbl and converts it into a grouped tbl where operations are performed "by group".
    - `summarise_all` applies a function to multiple variables.


## Descriptions

The final data set contains two identifiers for the subject and the activity. For the subject the identifier is `subject_id` and for the activity the identifier is` activity_id`. For the characteristics, only the measures of the standard and mean deviation of each measure were taken, among them we can find:

- "TimeDomainBodyAccelerometer-mean () - X"
- "TimeDomainBodyAccelerometer-mean () - Y"
- "TimeDomainBodyAccelerometer-mean () - Z"
- "TimeDomainGravityAccelerometer-mean () - X"
- "TimeDomainGravityAccelerometer-mean () - Y"
- "TimeDomainGravityAccelerometer-mean () - Z"




