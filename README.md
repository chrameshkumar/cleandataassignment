cleandataassignment
===================
This document explains the location of the input data sets and the sequence of operations performed by the script ‘run_analysis.R’ to get the desired clean and tiny set as per the given specification

Following files unzipped from the downloaded Zip file and loaded 

'features.txt':		          in current working directory.
'activity_labels.txt': 	    in current working directory.
'train/X_train.txt': 	      in train directory under working directory
'train/y_train.txt': 	      in train directory under working directory
'train/subject_train.txt’:  in train directory under working directory
'test/X_test.txt':	        in test directory under working directory
'test/y_test.txt': 	        in test directory under working directory
‘test/subject_test.t        xt’: 	in test directory under working directory

Script ‘run_analyzis.R’ description:
1.	‘Data.table’ package requested and loaded for handling data tables
2.	‘reshape2’ package loaded for ‘d-casting’ of melted table data table
3.	Read all  8 required files in the R environment
4.	From the feature labels list select all required std() and mean() variable column numbers in the data set as ‘reqfea1’     and ‘reqfea2’
5.	Combine these two vectors as single vector  ‘reqfeatures’ that has 66 entries ( 33 from each)
6.	Using ‘reqfeatures’ select the required feature labels from total features list
7.	Required feature labels are cleaned to create meaningful short labels:
      a.	Common string ‘Body’ and ‘()’ are removed 
      b.	All ‘_’ and ‘-‘ characters removed
      c.	The strings ‘mean’ and ‘std’ modified as ‘Mean’ and  ‘Std’ and ‘_’ added before ‘S’ and ‘M’ 
      d.	The selected features labels after cleaning is listed below;

[1] "tAcc_MeanX"            "tAcc_MeanY"            "tAcc_MeanZ"           
 [4] "tAcc_StdX"             "tAcc_StdY"             "tAcc_StdZ"            
 [7] "tGravityAcc_MeanX"     "tGravityAcc_MeanY"     "tGravityAcc_MeanZ"    
[10] "tGravityAcc_StdX"      "tGravityAcc_StdY"      "tGravityAcc_StdZ"     
[13] "tAccJerk_MeanX"        "tAccJerk_MeanY"        "tAccJerk_MeanZ"       
[16] "tAccJerk_StdX"         "tAccJerk_StdY"         "tAccJerk_StdZ"        
[19] "tGyro_MeanX"           "tGyro_MeanY"           "tGyro_MeanZ"          
[22] "tGyro_StdX"            "tGyro_StdY"            "tGyro_StdZ"           
[25] "tGyroJerk_MeanX"       "tGyroJerk_MeanY"       "tGyroJerk_MeanZ"      
[28] "tGyroJerk_StdX"        "tGyroJerk_StdY"        "tGyroJerk_StdZ"       
[31] "tAccMag_Mean"          "tAccMag_Std"           "tGravityAccMag_Mean"  
[34] "tGravityAccMag_Std"    "tAccJerkMag_Mean"      "tAccJerkMag_Std"      
[37] "tGyroMag_Mean"         "tGyroMag_Std"          "tGyroJerkMag_Mean"    
[40] "tGyroJerkMag_Std"      "fAcc_MeanX"            "fAcc_MeanY"           
[43] "fAcc_MeanZ"            "fAcc_StdX"             "fAcc_StdY"            
[46] "fAcc_StdZ"             "fAccJerk_MeanX"        "fAccJerk_MeanY"       
[49] "fAccJerk_MeanZ"        "fAccJerk_StdX"         "fAccJerk_StdY"        
[52] "fAccJerk_StdZ"         "fGyro_MeanX"           "fGyro_MeanY"          
[55] "fGyro_MeanZ"           "fGyro_StdX"            "fGyro_StdY"           
[58] "fGyro_StdZ"            "fAccMag_Mean"          "fAccMag_Std"          
[61] "fBodyAccJerkMag_Mean"  "fBodyAccJerkMag_Std"   "fBodyGyroMag_Mean"    
[64] "fBodyGyroMag_Std"      "fBodyGyroJerkMag_Mean" fBodyGyroJerkMag_Std" 

8.	Select required features using the selected labels for test and train files separately
9.	Refined column labels incorporated to selected test and train data sets
10.	Activity name and identity of person conducting the experiment included to each row in selected test and train data       sets using the ‘cbind’ function
11.	Selected test and train data sets combined with ‘rbind’ and converted into a data table, named ‘clean_set’
12.	‘clean_set’ data table is melted with ‘Subject’ and ‘act_desc’ as id variables and rest of the columns as measure         variables
13.	Melted data set is recast by using both id variables against all measure variables, using mean as the aggregate           function
14.	Resulting Clean_tiny_set’ is the desired tiny table that contains
      a.	180 rows of mean values for each experiment (30 subject and 6 activities-> 30*6 = 180)
      b.	68 column of variables ( Two id variables and 66 measure variables of mean and sd)
