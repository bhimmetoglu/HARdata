subset_features <- function(){
  # This function reads features and then determines which are mean and std
  # Returns a list of data frames which are used to subset the full data set
  
  # Read features 
  features <- read.table("features.txt",colClasses = c("numeric","character"))
  
  # Subset mean and std features
  l_mean <- grepl("mean", features[,2]); l_std <- grepl("std", features[,2])
  mean_features <- features[l_mean, ] ; std_features <- features[l_std, ]
  
  # Return location of features of interest
  list(mean_features, std_features)
}

subset_meanstd <- function(set,X_set,y_set,subj_set){
  # This function reads the appropriate subsets of data sets (train and test)
  # Returns a data frame which contains mean and std features, activity labels,
  # and subject indices. The data frame is merged from test and train data sets.
  
  #Activity labels
  act_lab <- read.table("activity_labels.txt",colClasses = c("numeric","character"))
  
  # File locations of data_sets
  loc_X <- paste(set,X_set,sep = "/")
  loc_y <- paste(set,y_set,sep = "/")
  loc_subj <- paste(set,subj_set,sep = "/")
  
  # Read the main data_set file
  X <- read.table(loc_X,colClasses = "numeric")
  
  # Read the activity factors from file
  y_lab <- read.table(loc_y, colClasses = "numeric")
  y_lab <- factor(y_lab[,1],labels=act_lab[,2])
  
  # Read the subject factors from file
  subj_lab <- read.table(loc_subj,colClasses = "numeric") 
  subj_lab <- as.factor(subj_lab[,1])
  
  # Now, mes_interest is already in Global.Env, so use it to subset X
  X_sub <- select(X,c(mean_features[,1],std_features[,1]))
  
  # Expand the data.frame to include subjects and activities (as factors)
  X_sub <- cbind(subj_lab,X_sub)
  X_sub <- cbind(y_lab,X_sub)
  
  # Rename columns
  cnames1 <- mean_features[,2]; cnames2 <- std_features[,2]
  names_all <- c("activity", "subject", cnames1, cnames2)
  colnames(X_sub) <- names_all
  
  # Return the subsetted data frame
  X_sub
}

## Main program ##
library(dplyr)

# Make sure that you are within the folder UCI HAR Dataset
lstat <- "UCI HAR Dataset" %in% strsplit(getwd(),"/")[[1]]
if (lstat == FALSE) stop("Not in folder UCI HAR Dataset")

# Get the locations of the measures of interest from subset_features function
foo <- subset_features()
mean_features <- foo[[1]]
std_features <- foo[[2]]

# Subset relevant data, then merge test and train sets
X_train_sub <- subset_meanstd("train","X_train.txt","y_train.txt","subject_train.txt")
X_test_sub <- subset_meanstd("test","X_test.txt","y_test.txt","subject_test.txt")
X_tot <- rbind(X_train_sub,X_test_sub)

# Order the merged data frame with respect  
X_tot <- arrange(X_tot,activity)

# Loop over all activities and subjects to get the final data frame
loop_sub <- sort(as.numeric(levels(X_tot$subject))) # loop indices for subjects
charv <- levels(X_tot$activity)  # loop indices for activities
num_act <- length(charv) # lenght of activities 

# Initiate NULL numeric temp and NULL data.frame df, update them in the loop
temp <- NULL
df <- data.frame(NULL)
for (is in loop_sub){
  for (ia in seq(1,num_act)){
    # Fill df with each activity and subject whose corresponding data are averaged
    df <- rbind(df, data.frame("subject"=is,"activity"= charv[ia]) )
    
    # Filter all the data for each activity and subject
    pippo <- filter(X_tot,activity==charv[ia] & subject==is) %>% select(-(1:2))
    
    # Compute averages and update the numeric temp
    temp <- rbind(temp,colMeans(pippo))
  }
}
# Finally merge df and temp
fin <- cbind(df,temp)

# Write into file
write.table(fin, file="final_table.txt", row.name = FALSE)
