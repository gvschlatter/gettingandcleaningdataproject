README.md
This is to describe how the "Getting and Cleaning Data Course Project" works.
The R script "run_analysis.R" works like described below:
1.	It is supposed the working file and directory already exists and are available;
2.	It first get the names of activities and features labels from each text file;
3.	Second, it loads both activity and subject data for each dataset and merges common columns;
4.	Third, it gets means and standard deviations from both datasets;
5.	Then it converts the activity and subject columns to names as factors;
6.	Finally, it creates a tidy dataset with average values of each variable for each subject and activity group;
7.	The result of all this processing is available in "tidyfile.txt".

