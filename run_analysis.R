## Read train data into data frame
train_data <- read.table('X_train.txt')

## Read test data into data frame
test_data <- read.table('X_test.txt')

## Combine train and test data sets  (STEP 1 in Project Instructions)
merged_data <- rbind(raw_train_data, raw_test_data)

## Set column names using values in 'features.txt'  (STEP 4 in Project Instructions)
##   (creates DF with 2 columns and 561 rows.  Column 2 contains the var names)
var_names = read.table('features.txt')
names(merged_data) <- var_names[,2]

## Select only columns containing 'std' OR 'mean' data  (STEP 2 in Project Instructions)
std_data <- select(merged_data, contains("std()"))
mean_data <- select(merged_data, contains("mean()"))
merged_data <- cbind(std_data, mean_data)

## Create vector with activity codes for train and test sets
train_activity_codes <- read.table('y_train.txt')
test_activity_codes <- read.table('y_test.txt')
activity_codes <- rbind(train_activity_codes, test_activity_codes)

## Add activity codes column to merged data
##  (convert activity_codes data frame to vector of type 'integer')
merged_data$activity_code <- as.vector(activity_codes[,1], mode='integer')

## Create vector with subject IDs for train and test sets
train_subject_ids <- read.table('subject_train.txt')
test_subject_ids <- read.table('subject_test.txt')
subject_ids <- rbind(train_subject_ids, test_subject_ids)

## Add subject IDs column to merged data
##  (convert subject_ids data frame to vector of type 'integer')
merged_data$subject_id <- as.vector(subject_ids[,1], mode='integer')

## Remove duplicate column names by subsetting with unique column names
merged_data <- merged_data[, unique(colnames(merged_data))]

## Add descriptive activity names (STEP 3 in Project Instructions)
##  (read in labels data set)
labels <- read.table('activity_labels.txt')
##  (use merged_data$activity_code value as row number in 'labels' DF)
merged_data <- mutate(merged_data, activity=labels[activity_code, 2])

## Remove activity_code since we now have a descriptive activity var
merged_data$activity_code <- NULL

## Group merged_data by activity, and subject_id within activity
merged_data <- group_by(merged_data, activity, subject_id)

## Summarize each measurement using the "mean()" function
summary_data <- summarise_each(merged_data, funs(mean))

## Write output file
write.table(summary_data, file='tidy_data.txt', row.name=FALSE)