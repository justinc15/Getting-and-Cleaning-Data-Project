## CodeBook 

### Description of the Experiment
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

### For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. ('GravityAcc` and `BodyAcc` (both in the time and frequency domains))
- Triaxial Angular velocity from the gyroscope. (`tBodyGyro` (in the time domain) and `fBodyGyro` (in the frequency domain))
- A 561-feature vector with time and frequency domain variables. (names of measurements contained in `features.txt`) 
- Its activity label (activity names matched by indices in `activity_labels.txt`)
- An identifier of the subject who carried out the experiment (entries contained in `subject_train.txt` and `subject_test.txt`)

### Transformations Involved to Clean Up Data 
 + In the first step, `rbind()` and '`cbind()` were used to combine the data frames and columns together to form the dataset 
 + `read.table()`, other than reading the txt files into R, is also used to read the feature and activity labels into R
 + `grep()` is used to look for all instances of the column names containing `mean()` and `std()`, and subsetting is used to subset only the columns from the dataset that represent the mean or standard deviation of a measurement from either an accelerometer or gyroscope
 + `gsub()` is used to replace the activity numbers in the `Activity` column with their respective activity names (based on `activity_labels.txt`), and the results are saved to the original dataset by using variable assignment of the same name and a for loop to loop through all of the possible activity numbers (i.e. integers 1 to 6)
 + `gsub()` is also used to replace all instances of common characters or words in the column names to add description to the variable names 
 + `aggregate()` is used to summarize all of the variable measurements for each subject in each of the activites (other than the `Subject` and `Activity` columns, returning a data frame containing all of the mean measurement statistics for each subject and activity 
