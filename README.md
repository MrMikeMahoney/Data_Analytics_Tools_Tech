#Data Analytics Tools and Techniques >> DA 6233

This repository contains HW and other files used in Data Analytics Tools and Techniques >> DA 6233 >> with Professor Joey Campbell, PhD.

The bulk of this class has been SQLite thus far, but I am including my HomeWorks as well.

HW1 was data cleaning an manipulation of the UCI_HAR Data set, which is measuring smart phone movements according to several conditions.
The data set is found at >> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones >> This project is data cleaning and manipulation.

The Actions performed in this script/manipulation >>

Loading in the >> X_test, X_train, y_test, y_train, features(which will become our column headers), activity_labels >> and eventually subject_train and subject_test files.
Combining the files for two final data sets (steps 4 and 5) >> step4: master_data, step5: subject_data_mean.
Subsetting the features, selecting only features recorded with either mean or standard deviations.
Creating a new column response (a misnomer, shoould have been activity) >> by creating a function recode_response from the activity_labels file.
Creating subject_data_mean (in step 5) which is a filter of master_data >> by subject then response >> then a mean of the remaining columns

The files include:
1) Getting_Cleaning_Data_assignment.pdf >> Information and insructions for the assignment
2) run_analysis.R >> R code used to transform the dataset and create the Fixed Response >> Recode
3) subject_data_mean.txt >> The dataset in text file
