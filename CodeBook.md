CodeBook
========================================================
##Introduction

This file describes the data and its variables and informs in detail the transformations performed on the initial [The Human Activity Recognition Using Smartphones Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) using the run_analysis.R script. There is a Glossary at the start explaning the different labels/features present in the initial data set. 

##Dataset Cleanup and Transformations:
[The Human Activity Recognition Using Smartphones Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) data set consists of totally 563 features (including Activity ID and Subject ID) and total of 10299 observations (including train and test observations). The features expected to be extracted from this feature set is Mean and Standard Deviation measurements. Given there is a possiblity for ambiguity, the coding allows to have 

1. mean() and std() measurements - 75 Features
2. mean(),meanFreq() and std measurements - 88 Features

This is including the SubjectID and ActivityID. By default I took the latter with 88 features. Then the ActivityID (1 to 6) is replaced by the corresponding activity description WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING in the reduced dataset. Subsequently the average of the features per SubjectID per ActivityID is calculated and written to the tidy data set. The dimensions of the final tidy data set is 180 * 88 . 180 comes from 6 activities per 30 subjects (6 * 30) . The tidy data set is written out to a file . By default to final.txt in current working directory.

##Glossary of Input Data Features

Variable Name | Description
--------------|------------
SubjectID | Total of 30 subjects referenced by numbers 1 to 30
Activity Name | Total of 6 activities performed by the 30 Subjects. The activities being WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
ActivtyID | The 6 activities of subjects mapped to ids 1 to 6
X,Y,Z | 3-axial signals in the X, Y and Z directions. Used at end of the feature names)
Mean | Mean value
Std | Standard deviation
MeanFreq | Weighted average of the frequency components to obtain a mean frequency
t | time domain signal. Used at start of the feature names: eg: tAcc-XYZ
f | frequenct domain signal. Used at start of the feature names: eg fBodyAcc-XYZ
Acc | Accelerometer
Gyro | Gyroscope
BodyAcc | Body Acceleration Signal (derived from Acc features)
GravityAcc | Gravitation Acceleration Signal (derived from Acc features)
Jerk | Jerk Signals
Mag | Magnitude of the three dimenstional signals

##Used Features

Here is the list of used mean and standard deviation features

No | VariableName
---|-------------
1	| SubjectID
2	| ActivityName
3	| tBodyAccMeanX
4	| tBodyAccMeanY
5	| tBodyAccMeanZ
6	| tBodyAccStdX
7	| tBodyAccStdY
8	| tBodyAccStdZ
9	| tGravityAccMeanX
10	| tGravityAccMeanY
11	| tGravityAccMeanZ
12	| tGravityAccStdX
13	| tGravityAccStdY
14	| tGravityAccStdZ
15	| tBodyAccJerkMeanX
16	| tBodyAccJerkMeanY
17	| tBodyAccJerkMeanZ
18	| tBodyAccJerkStdX
19	| tBodyAccJerkStdY
20	| tBodyAccJerkStdZ
21	| tBodyGyroMeanX
22	| tBodyGyroMeanY
23	| tBodyGyroMeanZ
24	| tBodyGyroStdX
25	| tBodyGyroStdY
26	| tBodyGyroStdZ
27	| tBodyGyroJerkMeanX
28	| tBodyGyroJerkMeanY
29	| tBodyGyroJerkMeanZ
30	| tBodyGyroJerkStdX
31	| tBodyGyroJerkStdY
32	|tBodyGyroJerkStdZ
33	| tBodyAccMagMean
34	| tBodyAccMagStd
35	| tGravityAccMagMean
36	| tGravityAccMagStd
37	| tBodyAccJerkMagMean
38	| tBodyAccJerkMagStd
39	| tBodyGyroMagMean
40	| tBodyGyroMagStd
41	| tBodyGyroJerkMagMean
42	| tBodyGyroJerkMagStd
43	| fBodyAccMeanX
44	| fBodyAccMeanY
45	| fBodyAccMeanZ
46	| fBodyAccStdX
47	| fBodyAccStdY
48	| fBodyAccStdZ
49	| fBodyAccMeanFreqX
50	| fBodyAccMeanFreqY
51	| fBodyAccMeanFreqZ
52	| fBodyAccJerkMeanX
53	| fBodyAccJerkMeanY
54	| fBodyAccJerkMeanZ
55	| fBodyAccJerkStdX
56	| fBodyAccJerkStdY
57	| fBodyAccJerkStdZ
58	| fBodyAccJerkMeanFreqX
59	| fBodyAccJerkMeanFreqY
60	| fBodyAccJerkMeanFreqZ
61	| fBodyGyroMeanX
62	| fBodyGyroMeanY
63	| fBodyGyroMeanZ
64	| fBodyGyroStdX
65	| fBodyGyroStdY
66	| fBodyGyroStdZ
67	| fBodyGyroMeanFreqX
68	| fBodyGyroMeanFreqY
69	| fBodyGyroMeanFreqZ
70	| fBodyAccMagMean
71	| fBodyAccMagStd
72	| fBodyAccMagMeanFreq
73	| fBodyBodyAccJerkMagMean
74	| fBodyBodyAccJerkMagStd
75	| fBodyBodyAccJerkMagMeanFreq
76	| fBodyBodyGyroMagMean
77	| fBodyBodyGyroMagStd
78	| fBodyBodyGyroMagMeanFreq
79	| fBodyBodyGyroJerkMagMean
80	| fBodyBodyGyroJerkMagStd
81	| fBodyBodyGyroJerkMagMeanFreq
82	| angletBodyAccMeangravity
83	| angletBodyAccJerkMeangravityMean
84	| angletBodyGyroMeangravityMean
85	| angletBodyGyroJerkMeangravityMean
86	| angleXgravityMean
87	| angleYgravityMean
88	| angleZgravityMean


##References:

[1] UCI HAR Dataset