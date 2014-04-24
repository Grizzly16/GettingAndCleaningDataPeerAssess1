# Getting and Cleaning Data - peer assess 1
setwd("~/Desktop/Classes/Getting and cleaning data/Programming Assignments")
library(reshape2)
#data is stored in a data folder
subFolder <- c("./UCI HAR Dataset/") # update this if you've moved the folders around

print("Reading labels")
#get the activity lables
actLbl <-read.table(paste(subFolder, "activity_labels.txt", sep=""))
colnames(actLbl) <- c("activityID", "activityName")
head(actLbl)

print("Reading features")
#get our features list
featList <-read.table(paste(subFolder, "features.txt", sep=""))
colnames(featList) <- c("num", "name")
head(featList)

#get the training data
print("Reading training data.")
xTrain <- read.table(paste(subFolder, "train/x_train.txt", sep=""))
yTrain <- read.table(paste(subFolder, "train/y_train.txt", sep=""))
trainSubjectID <- read.table(paste(subFolder, "train/subject_train.txt", sep=""))
print("Training data read in.")

#get the test data
print("Reading Test data.")
xTest <- read.table(paste(subFolder, "test/X_test.txt", sep=""))
yTest <- read.table(paste(subFolder, "test/y_test.txt", sep=""))
testSubjectID<- read.table(paste(subFolder, "test/subject_test.txt", sep=""))
print("Testing data read in.")

#apply column names
colnames(xTest) <- featList[,2]
colnames(xTrain) <- featList[,2]

#combine test and train data
fullDataSet <- rbind(xTrain, xTest)
#combine activity lists & subjects info
activityIds <- rbind(yTrain, yTest)
subjectIds <- rbind(trainSubjectID, testSubjectID)
#merge activty descriptors and numerical equivs
fullActivityMap<- merge(x=activityIds, y=actLbl, by.x="V1", by.y="activityID", sort=FALSE)
#add activity and subject details to our single dataset
colnames(fullActivityMap) <- c("activityID", "activityName")
fullDataSet$activityID <- fullActivityMap$activityID
fullDataSet$activityName <- fullActivityMap$activityName
colnames(subjectIds) <- c("subjectID")

#tada our one dataset!
fullDataSet$subjectID <- subjectIds[,1]
dt<-data.table(fullDataSet)

#melt it!
cl <- colnames(fullDataSet)
usableCols <- cl[grep("(std\\(\\)|mean\\(\\))",cl)] # get the columns we want
meltedDT <- melt(fullDataSet, id=563:564, measure=usableCols) 

# convert to tidy dataset with one entry per activity, subject and measurement
tidy <- dcast(meltedDT, subjectID +activityName +  variable ~., mean)
colnames(tidy) <- c("SubjectID","ActivityName","MeasurementType","MeanValue")
#write out a file, uncomment if you want to do this
write.table(tidy, file=paste(subFolder, "tidy_summary.txt", sep=""))
