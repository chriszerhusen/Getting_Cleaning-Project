library(dplyr)

#-----------------------------------------------------------------------------------
# READING AND CONSOLIDATING DATA
#-----------------------------------------------------------------------------------

wd <- getwd()

setwd("UCI HAR Dataset")

# Create vectors to be used as names/labels
features <- read.table("features.txt")
        features <- as.character(features$V2)
        
        # Find the variables measuring mean and standard deviation. 
        means <- grep("mean", features, ignore.case=TRUE)
        stds <- grep("std", features, ignore.case=TRUE)
        names <- sort.int(union(means, stds))


activities <- c("Walking", "Walking Up Stairs", "Walking Down Stairs", "Sitting",
                "Standing", "Laying")

# Read in the test data
setwd("test")
subjects_test <- read.table("subject_test.txt")
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")

# Make activity labels clear
y_test$V1 <- (factor(y_test$V1, levels = c(1,2,3,4,5,6), labels = activities))

# Consolidate data into a new data table
testdata <- subjects_test
testdata <- cbind(testdata, (y_test), x_test)
names(testdata) <- c("Subject", "Activity", features)

rm(subjects_test, x_test, y_test)

# Read in the training data
setwd("../train")
subjects_train <- read.table("subject_train.txt")
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")

# Make activity labels clear
y_train$V1 <- factor(y_train$V1, levels = c(1,2,3,4,5,6), labels = activities)

# Consolidate data into a new data table
traindata <- cbind(subjects_train, y_train, x_train)
names(traindata) <- c("Subject", "Activity", features)

rm(subjects_train, x_train, y_train)

# Return to original directory for convenience
setwd(wd)

# Combine test and training data into one data set
dat <- rbind(testdata, traindata)

rm(testdata, traindata)

# Extract relavent columns for analysis
dat <- dat[,c(1,2, names + 2)]

# Make variable names pretty
prettynames <- names(dat)
        prettynames <- gsub("Body", "Body ", prettynames)
        prettynames <- gsub("tBody", "Body", prettynames)
        prettynames <- gsub("Body Body", "Body", prettynames)
        prettynames <- gsub("tGravity", "Gravity ", prettynames)
        prettynames <- gsub("Acc", "Acceleration ", prettynames)
        prettynames <- gsub("Jerk", "Jerk ", prettynames)
        prettynames <- gsub("-mean()-", "- Mean in ", prettynames, fixed=TRUE)
        prettynames <- gsub("-std()-", "- Standard Deviation ", prettynames, fixed=TRUE)
        prettynames <- gsub("X", "X Direction", prettynames)
        prettynames <- gsub("Y", "Y Direction", prettynames)
        prettynames <- gsub("Z", "Z Direction", prettynames)
        prettynames <- gsub("Gyro", "Gyroscope ", prettynames)
        prettynames <- gsub("f", "Fourier ", prettynames)
        prettynames <- gsub("Mag", "Magnitude ", prettynames)
        prettynames <- gsub(",", ", ", prettynames)
        prettynames <- gsub("yM", "y M", prettynames)
        prettynames <- gsub("nF", "n F", prettynames)
        prettynames <- gsub("Freq()", "Frequency ", prettynames, fixed=TRUE)
        prettynames <- gsub("-mean()", "- Mean ", prettynames, fixed=TRUE)
        prettynames <- gsub("-std()", "- Standard Deviation ", prettynames, fixed=TRUE)
        prettynames <- gsub("-mean", "- Mean ", prettynames, fixed=TRUE)
        prettynames <- gsub("-X", "- X", prettynames, fixed=TRUE)
        prettynames <- gsub("-Y", "- Y", prettynames, fixed=TRUE)
        prettynames <- gsub("-Z", "- Z", prettynames, fixed=TRUE)
        prettynames <- gsub("angle", "Angle ", prettynames)
        prettynames <- gsub("gravity", "Gravity ", prettynames)
        
names(dat) <- prettynames
        
# Sort by Subject and Activity
dat <- arrange(dat, Subject, Activity)


#------------------------------------------------------------------------------------
# CREATE NEW TIDY DATA SET WITH AVERAGES FOR EACH SUBJECT/ACTIVITY COMBO
#------------------------------------------------------------------------------------

# Create vectors to become the first two columns of our clean data set
Subject <- rep(1:30, each=6)
Activity <- rep(activities, 30)

# Calculate the mean value for every Subject ID-Activity pair and save it in a list
fulldat <- lapply(dat[,3:88], tapply, list(dat$Subject, dat$Activity), mean)

# Create our clean data set by combining the above created columns
cleandat <- as.data.frame(cbind(Subject, Activity))
cleandat <- cbind(cleandat, lapply(fulldat, as.vector))


# Write the data to a file
write.table(cleandat, file="Clean Data.txt", row.name=FALSE)
