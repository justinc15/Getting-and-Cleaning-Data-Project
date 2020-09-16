## Load the training data sets into R
subject_train <- read.table(paste(getwd(),"/train/subject_train.txt", sep = ''))
x_train <- read.table(paste(getwd(),"/train/X_train.txt", sep = ''))
y_train <- read.table(paste(getwd(),"/train/y_train.txt", sep = ''))

## Load the test data sets into R
subject_test <- read.table(paste(getwd(),'/test/subject_test.txt',sep = ''))
x_test <- read.table(paste(getwd(),'/test/X_test.txt', sep = ''))
y_test <- read.table(paste(getwd(),'/test/y_test.txt', sep = ''))

## Merge the training and the test sets to create one data set
subjects <- rbind(subject_train,subject_test)
x_col <- rbind(x_train,x_test)
y_col <- rbind(y_train,y_test)
tidy_data <- cbind(subjects,y_col,x_col)
head(tidy_data)

## Saving the features label under features (with the first column removed) and 
## replace dataset column names with feature labels
features <- read.table("features.txt", stringsAsFactors = FALSE, col.names = c("Label Number","Feature"))[-1]

## Renaming the column names of the dataset and replacing the last 561 column names with feature labels
names(tidy_data)[3:563] <- features$Feature
names(tidy_data)[1] <- 'Subject'
names(tidy_data)[2] <- 'Activity'

## Extracting only the measurements on the mean and standard deviation for each measurement.
measurement_indices <- sort(c(grep("std",names(tidy_data)),grep("mean",names(tidy_data))))
tidy_data <- tidy_data[,c(1,2,measurement_indices)]

## Removing all instances of meanFreq() from tidy_data (since all frequency measurements already 
## have mean and standard deviation)
tidy_data <- tidy_data[,-grep("meanFreq",names(tidy_data))]

## Uses descriptive activity names to name the activities in the data set
activity_names <- read.table("activity_labels.txt",stringsAsFactors = FALSE, 
                         col.names = c("Activity Number", "Activity Name"))[-1]

i <- 1
for (i in 1:6){
  tidy_data$Activity <- gsub(i,activity_names$Activity.Name[i],tidy_data$Activity)
}

## Appropriately labels the data set with descriptive variable names.
names(tidy_data) <- gsub("-mean\\(\\)-X","Mean (in the direction of X)", names(tidy_data))
names(tidy_data) <- gsub("-mean\\(\\)-Y","Mean (in the direction of Y)", names(tidy_data))
names(tidy_data) <- gsub("-mean\\(\\)-Z","Mean (in the direction of Z)", names(tidy_data))
names(tidy_data) <- gsub("^t","timeDomain", names(tidy_data))
names(tidy_data) <- gsub("^f","frequencyDomain", names(tidy_data))
names(tidy_data) <- gsub("Acc","accelerometer", names(tidy_data))
names(tidy_data) <- gsub("^Gyro","gyroscope", names(tidy_data))
names(tidy_data) <- gsub("Mag","SignalMagnitude", names(tidy_data))
names(tidy_data) <- gsub("BodyBody","Body", names(tidy_data))
names(tidy_data) <- gsub("-std\\(\\)-X","StandardDeviation (in the direction of X)", names(tidy_data))
names(tidy_data) <- gsub("-std\\(\\)-Y","StandardDeviation (in the direction of Y)", names(tidy_data))
names(tidy_data) <- gsub("-std\\(\\)-Z","StandardDeviation (in the direction of Z)", names(tidy_data))
names(tidy_data) <- gsub("-mean\\(\\)","Mean", names(tidy_data))
names(tidy_data) <- gsub("-std\\(\\)","StandardDeviation", names(tidy_data))

## From the data set in step 4, create a second, independent tidy data set with the average of each 
## variable for each activity and each subject.
tidy_data <- aggregate(tidy_data[-c(1,2)],list(tidy_data$Subject,tidy_data$Activity),mean,na.rm=TRUE)
names(tidy_data)[1] <- 'Subject'
names(tidy_data)[2] <- 'Activity'
write.table(tidy_data,"tidy_data.txt", row.name=FALSE)
