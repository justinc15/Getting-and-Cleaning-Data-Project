# Getting and Cleaning Data (Week 4 Project)

## How the Script Works 
Before loading the script, unzip the compressed file and move the unzipped file to your current working directory. After moving the file, set the working directory to be the dataset folder (i.e. UCI HAR Dataset). 

The script cleans and tidies up the dataset based on the 5 main procedures that was posted on the assignment page :
1. `subject_train.txt`, `X_train.txt`, `y_train.txt` (the training dataset files from the dataset folder) and `subject_test.txt`, `X_test.txt`, `y_test.txt` (the test dataset files from the dataset folder) will first be read as data frames in R. Then, `subject_train.txt` and `subject_test.txt` will be combined to form the column for *Subject*, `y_train.txt` and `y_test.txt` will be combined to form the column for *Activity*, while `X_train.txt` and `X_test.txt` will be combined to form the columns for each of the feature measurements, before these are combined to form the new dataset
2. After the formation of the dataset, the measurement labels in `features.txt` will replace the column names for each of the feature measurements. Since we only need the mean and standard deviation measurements, the script will proceed by extracting only columns that represent either the mean or SD of a specific measurement. 
3. The integers in the *Activity* column of the dataset will be replaced by their respective activity names (based on their index in `activity_labels.txt`)
4. The column names in the modified dataset will be replaced to add description to the variable measurements (for example: "f" with "frequencyDomain", "Acc" with "accelerometer etc.)
5. Using the modified dataset, the script will proceed to summarize the variable measurements for each activity and each subject, returning a new data frame containing only the means of each measurement for each subject and each activity that they have participated in 
