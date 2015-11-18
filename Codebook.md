# Code Book for HARdata

#### Experimental design and background
Explain how data is obtained here

#### Raw Data
All the data is contained in the folder UCI HAR Dataset. The folder contains several key text files:

* activity_labels.txt : All the activities (1 to 6) during which measurements are made, contains: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
* features.txt : All the measured quantities are listed in this file. Further detailed information is provided in the features_info.txt. In quick summary:
  * Variables with a prefix "t" refers to measurements in time domain.
  * Variables with a prefix "f" refers to Fourier transformed ones (i.e. frequency domain).
  * '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions. Mag is used for magnitudes (norm).
  * Variables containing BodyAcc, GravityAcc are in units of standard gravitational acceleration g (9.8 m/s^2).
  * Variables containing Gyro are angular accelerations (units are radians/second).
  * Variables containing Jerk are Jerk signals (time derivative of acceleration).
  * These measurements are used to estimate variables range from mean to angle (listed in features_info.txt). In total, there are 561 variables that are collected.

* Folder train: 
  * Contains all the 561 measured variables in the file X_train.txt. 
  * y_train.txt : Contains the indices of activities (ranges from 1 to 6, as in activity_labels.txt) for each measurement (7352 of them).
  * subject_train.txt: Contains the indices of subjects (21 levels) for each measurement (7352 of them).
  * X_train.txt: Contains measurements (7352 of them) of all 561 variables. Each column corresspond to a specific observation for a (activity,subject) pair. 
    * For example, 1st line of y_train.txt is 5 (STANDING), 1st line of subject_train.txt is 1 (subject 1), thus first line of X_train.txt contains the measurement of 561 variables for subject 1 while STANDING. 

* Folder test: Basically the same with folder train (in file names train is replaced with test), just for test cases. There are only 9 levels in subject_test.txt (since only %30 of subjects are for test, while %70 for train), and there are 2947 measurements.

#### Processed Data

