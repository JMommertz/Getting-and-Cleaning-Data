        library(dplyr)
       library(tidyr)

       if (!file.exists("Coursproject")) {
       dir.create("Coursproject")}

        temp <- tempfile(tmpdir = "Courseproject")
        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(URL, temp, method = "curl", mode= "wb")
        unzip(temp)

        setwd("~/Desktop/Coursera/Getting and Cleaning Data/Week 4/Coursproject/UCI HAR Dataset")       

        # Read all tests and subjects from file
        xTest <- read.table("test/X_test.txt")
        yTest <- read.table("test/Y_test.txt")
        subTest <- read.table("test/subject_test.txt")
        
        # Read all trainings and subjects from file
        xTrain <- read.table("train/X_train.txt")
        yTrain <- read.table("train/Y_train.txt")
        subTrain <- read.table("train/subject_train.txt")
        
        
        # Create one big test-table with all three dimensions
        testsTable <- cbind(subTest, yTest, xTest)
        
        # Create one big train-table with all three dimensions
        trainTable <- cbind(subTrain, yTrain, xTrain)
        
        # Combine Test and Train to one big table
        bigTable <- rbind(testsTable, trainTable)
        
        # Read colum descriptions from file
        colnamesRawInput <- read.table("features.txt")
        colnamesVector <- as.vector(colnamesRawInput$V2)
        
        # Join all colum names from file with 2 more colum names to previous generated table
        colnames(bigTable) <- c("ID", "Action", colnamesVector)
        
        subsetTable <- subset(bigTable, select=grep("(.*((mean)|(std))+\\(\\).*)|ID|Action", colnames(bigTable)))
        
        # Read all descriptive actions from file
        actions <- read.table("activity_labels.txt")
        withactions <- left_join(subsetTable, actions, by = c("Action" = "V1"))
        withactions <- withactions[,c(1,ncol(withactions),4:ncol(withactions)-1)]
        
        # Modifying 2nd colname because of previous left_join
        colnames(withactions)[2] <- c("Action")
        
        # tidy data set with the average of each variable for each activity and each subject
        tidydata <- withactions %>%
                group_by(ID, Action) %>%
                summarise_all(mean)