Human Activity Recognition Using Smartphones Data Set

See readme for the source information of the dataset.

Files:

README.txt - information on the dataset

features_info.txt - variable and feature information

activity_labels.txt - the 6 activities with their id

features.txt - the 561 "feature labels"

Folders:  Test & Train

There were 30 volunteers who contributed data to the data set, 21 of which went to the training data set and 9 went to the test dataset.  These datasets will be reintegrated into one dataset.  All the test data files have 2947 rows and the training files have 7352 rows (10,299 rows when merged together, over 343 measurements for the different activities for each subject).

Each test and train dataset has 3 files:

subject_train.txt & subject_test.txt - the volunteers labeled subject 1 through 30 and are split between these files (test: 2,4,9,10,12,13,18,20,24)

X_train.txt & X_test.txt contains the measurements on the 561 "features" without column headings

y_train.txt & y_test.txt contains the activities that were measured for each feature (1 to 6)

Other folders: "Inertial Signals" were not used in this analysis.


Transformations:
The subjects and activities that were measured need to be added as columns to the measurements table for it to make any sense.  Once these are pasted to the measurement data both data sets are merged to create a single dataset with the activities updated to reflect the descriptive activity (e.g. walking) rather than the id.

Once the above is processed the measurement columns are reduced from 561 to 86 which are either mean or standard deviation measurements.

Then the data is grouped on activity and the average of each column is calculated resulting in 6 average measurements for each of the 30 subjects (180 rows).  This tidy data is writen to a new file "TidyData.txt"
