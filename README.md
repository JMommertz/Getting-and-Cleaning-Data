# Getting-and-Cleaning-Data
Coursera, Getting-and-Cleaning-Data, Week 4, Course Project

## Applied packages
* dplyr
* tidyr

## Procedure of "run_analysis.R"

* Download the required data
* unzip the relevant data
* Read all tests and subjects from file "Test"
  * test/X_test.txt
  * test/Y_test.txt
  * test/subject_test.txt
* Read all tests and subjects from file "Train"
  * train/X_train.txt
  * train/Y_train.txt
  * train/subject_train.txt
* Create one test-table with all three dimensions 
* Create one train-table with all three dimensions
* Combine Test and Train to one big table
* Read colum descriptions from file
  * features.txt
* Join all colum names from file with two more colum names ("ID" & "Actions") to previous generated table
* Read all descriptive actions from file
* Modifying 2nd colname because of previous left_join
* Create a tidy data set with the average of each variable for each activity and each subject
