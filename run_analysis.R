    # Get names from activity and features
    actNames <- read.table("UCI HAR Dataset/activity_labels.txt")
    actNames[,2] <- as.character(actNames[,2])
    featNames <- read.table("UCI HAR Dataset/features.txt")
    featNames[,2] <- as.character(featNames[,2])
    
    # Load data
    train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
    trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
    trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
    train <- cbind(trainSubjects, trainActivities, train)
        
    test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
    testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
    testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
    test <- cbind(testSubjects, testActivities, test)
          
    # Join data and write labels
    compTable <- rbind(train, test)
    colnames(compTable) <- c("subject", "activity", featuresWanted.names)
    
    # Get means and standard deviations
    featuresWanted <- grep(".*mean.*|.*std.*", featNames[,2])
    featuresWanted.names <- featNames[featuresWanted,2]
    featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
    featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
    featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)
      
    # Set descriptive names to activities and subjects
    compTable$activity <- factor(compTable$activity, levels = actNames[,1], labels = actNames[,2])
    compTable$subject <- as.factor(compTable$subject)
        
    # Label datasets with names 
    compTable.melted <- melt(compTable, id = c("subject", "activity"))
    compTable.mean <- dcast(compTable.melted, subject + activity ~ variable, mean)
             
    # Create independent tidy dataset  
    write.table(compTable.mean, "tidyfile.txt", row.names = FALSE, quote = FALSE)
