==============================================================

Tidied data from a Dataset obteined from a Hardware-Friendly Ambient Intelligence for healthcare applications based in the work of Anguita et al. (2012).

==============================================================

By César Gonzalez

==============================================================

**Getting and Cleaning Data Project**

Few steps were taken to transform de dataset downloaded from the URL indicated.

#### <i class="icon-file"></i> Contains
>**This Repository contains:**
> - This Readme
> - Run_analisys.R. The R script have the steps necessary to perform the required work
> - Codebook. This file contains all codes and variable names that appear in the dataset

#### <i class="icon-file"></i>We requiere to submit
>-A tidy data set 

>-A link to a Github repository containing all project files

>-A code book with the explanation of each and every one of the variables and the keys used

>-A brief explanation of the script


#### <i class="icon-file"></i>Explanation of script

The raw data sets are processed with the script run_analysis.R script to create a tidy data set.

Merge training and test sets to obtain one unify data set.

From the last single dataset was extract mean an standard deviation variables

A new columns was added to add the activity and subject information

Obtain a tidy data from the last dataset where numeric variables are averaged for each activity and each subject.
