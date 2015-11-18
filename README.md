# Description of HARdata

This repo contains a R script (run_analysis.R) which reads Human Activity Recognition (HAR) Using Smartphones Dataset and combines the test and training data sets (contained in the zipped file). 

The R script contains two functions that subsets the measurements on the mean and standard deviation for each measurement (all measurements are listed in features.txt), and then merges the corresponding data from test and training data sets. Finally, the R script transforms the merged data set into a tidy data set with the average of each measurement (mean and standard deviation) for each activity and each subject. 

Functions in the R script:

1. subset_features: reads features and then determines which are mean and std. Returns a list of data frames which are used to subset the full data set
2. subset_meanstd: reads the appropriate subsets of data sets (train and test). Returns a data frame which contains mean and std features, activity labels, and subject indices. The data frame is merged from test and train data sets.
 
The main code uses these two functions in to merge the test and train data sets and then performs the final tidying up to print the data set "final_table.txt". The form of the final table is schematically given below:

"subject" "activity" "tBodyAcc-mean()-X" ...... "fBodyBodyGyroJerkMag-std()"
1          WALKING             ....       
1          WALKING_UPSTAIRS    ....
.          .
.          .
2          WALKING             ....
2          WALKING_UPSTAIRS    .....
.          .
.          .

Each subject has 6 different activities and each measureement starting from "tBodyAcc-mean()-X" ending at "fBodyBodyGyroJerkMag-std()" (180 of them) is averaged for each subject and each activity. 
