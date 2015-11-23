run_analysis <- function() {
  require(data.table)
  require(downloader)
  
  # Download provided data and unzip into working dir
  dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  downloader::download(dataURL, "wearable_data.zip", mode = "wb")
  unzip("wearable_data.zip", exdir = "./")
  
  # Load tables from the test files
  xtest_table <- read.table("UCI HAR Dataset/test/X_test.txt", sep = "")
  ytest_table <- read.table("UCI HAR Dataset/test/y_test.txt", sep = "")
  subtest_table <- read.table("UCI HAR Dataset/test/subject_test.txt", sep = "")
  
  # Load tables from the train files
  xtrain_table <- read.table("UCI HAR Dataset/train/X_train.txt", sep = "")
  ytrain_table <- read.table("UCI HAR Dataset/train/y_train.txt", sep = "")
  subtrain_table <- read.table("UCI HAR Dataset/train/subject_train.txt", sep = "")
  
  # Load tables from the label file
  label_table <- read.table("UCI HAR Dataset/activity_labels.txt", sep = "")
  
  # [TASK 1] Combine the test and train data sets; Columns are Subject, Activity, Reading1, Reading2 . .
  test_data <- cbind(cbind(subtest_table, ytest_table), xtest_table)
  train_data <- cbind(cbind(subtrain_table, ytrain_table), xtrain_table)
  combined_data <- as.data.table(rbind(test_data, train_data))
  
  # [TASK 2] Retrieve mean and standard deviation calculations on all readings
  col_count <- ncol(combined_data)
  means <- sapply(combined_data[3:col_count], mean)
  stddevs <- sapply(combined_data[3:col_count], sd)
  
  # [TASK 4] Give appropriate names to variables
  col_names <- list()
  col_names[1] <- "Subject"
  col_names[2] <- "ActivityID" 
  for (i in 3:col_count) {
    col_names[i] <- paste("Reading", toString(i-2))
  }
  names(combined_data)[1] <- "Subject"
  names(combined_data)[2] <- "ActivityID"
  setnames(combined_data, names(combined_data), unlist(col_names))
  
  # Load table with Activity ID and Activity Description
  act_table <- as.data.table(read.table("UCI HAR Dataset/activity_labels.txt", sep = ""))
  setnames(act_table, "V1", "ActivityID")
  setnames(act_table, "V2", "Description")
  
  # [TASK 3] Set keys and join to activity data table, update combined data with descriptions
  setkey(combined_data, ActivityID)
  setkey(act_table, ActivityID)
  combined_data[, Activity := act_table[Description]]
  
  # [TASK 5] Make independent copy of combined data and find avgs grouped by subject and activity
  copied <- copy(combined_data)
  averages <- copied[, lapply(.SD, mean),by=.(Subject,Activity)]
  
  write.table(averages, file = "averages.txt", row.names = FALSE)
  
  return(averages)
}
