---
title: "Codebook for Coursera Data Cleaning Project"
author: "nscottphillips"
date: "November 23, 2015"
output: html_document
---


* Source data obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

* A description of the sourcce data can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

* The following steps are performed in run_analysis.R
    1. Download entire data set and unzip contents
    2. Load both train and test data sets
    3. Load activity labels data set
    4. Combine both train and test data sets into a data table
    5. Calculate and store mean and standard deviation on all readings
    6. Rename variables appropriately
          a. Subject = one of the 30 participating subjects
          b. ActivityID = one of six activities defined in the study
          c. ReadingXXX = readings taken from the device
          d. Activity = name of the activity
    7. Copied a new data table and calculated mean of all readings by Subject and Activity
    8. Wrote results to text file for submission