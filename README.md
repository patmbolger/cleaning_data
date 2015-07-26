This is the README.md file for the course project for the course "Getting and Cleaning Data" (part of the Johns Hopkins Data Science Specialization) on Coursera.

This course was taken by the author in July, 2015.

The analysis steps are all contained in the R script file in this repo - "*run_analysis.R*".

**Data Preparation**

The following steps were taken to produce the tidy data set found in the output file "*tidy_data.txt*".  The line numbers refer to lines in the script file.

1. Read the train data source file into a data frame (line 2)
2. Read the test data source file into a data frame (line 5)
3. Merge the above two data frames into one (line 8)
4. Read the measurement variables names into a data frame (line 12)
5. Set the var names in the merged data set using the variable names from prior step (line 13)
6. Reduce the set of variables to only those for "mean" and "standard deviation" values
  1. Use select() to create data frame of variables containing the string "std()" (this exploits the naming convention in the source data files) (line 16)
  2. Use select() to create data frame of variables containing the string "mean()" (this exploits the naming convention in the source data files) (line 17)
  3. Reset the merged data frame to equal the combination (via cbind) of the data frames created by the prior two steps (line 18)
7. Create a data frame consisting of the activity codes, for each row in the data source files (lines 21 - 23)
8. Add a vector 'activity_code' to the merged data frame using the data frame created in prior step (convert latter to vector as part of this) (line 27)
9. Create a data frame consisting of the subject ids, for each row in the data source files (lines 30 - 32)
10. Add a vector 'subject_id' to the merged data frame using the data frame created in prior step (convert latter to vector as part of this) (line 36)
11. Since the source data files contain duplicate names for many measurements, remove columns with duplicated names (line 39)
12. Add a column for descriptive activity names (instead of relying solely on activity codes)
  1. Read the file that associates activity code (1 - 6) with the description of the activity (line 43)
  2. Add column "activity" to the merged data frame by using mutate() (line 45)
13. Remove the "activity_code" column from the merged data frame as it is now not needed (this step can be omitted if retention of the activity codes would be useful for subsequent analysis) (line 48)
14. Group the merged data file by activity, and by subject_id within activity (line 51)
15. Create a data frame containing the mean of each measurement, for each subject_id within activity (line 54)
16. Write the resulting summary data frame to a txt file (*tidy_data.txt*) as a table (line 57)

**Code Book**

The description of the measurement variables are included in the associated file *features_info.txt*.  **Please note, however, that the measurements in the output data file (*tidy_data.txt*) are actually the *mean* values of the measurements described in the associated file, where the mean is the average of each measurement for each subject_id, within activity.**
