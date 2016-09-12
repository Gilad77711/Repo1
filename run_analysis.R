##step1&4:
##reading the data:
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
X_train<-read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"))
y_train<-read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"))
subject_train<-read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"))
X_test<-read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))
y_test<-read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"))
subject_test<-read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"))
f<-read.table(unz(temp,"UCI HAR Dataset/features.txt"))
features_names<-f[,2]
unlink(temp)

##Checking the dim of the data sets:
dim(X_train)
dim(y_train)
dim(subject_train)
dim(X_test)
dim(y_test)
dim(subject_test)

##adding the features names to X_train and X_test
names(X_train)<-features_names
names(X_test)<-features_names

##Merge according to the dims we found:
test<-cbind(subject_test,y_test,X_test)
train<-cbind(subject_train,y_train,X_train)

##checking the dims of the new data sets and merging them:
dim(test)
dim(train)
my_data<-rbind(test,train)
names(my_data)[1]<-"subject_id"
names(my_data)[2]<-"activity_id"
dim(my_data)
View(my_data)

##step2:
##pulling out only the average of each variable for each activity and each subject.
n<-names(my_data)
meanandsd_colnumbers<-grep("[Mm]ean|[Ss]td",n)
mean_and_sd<-my_data[,c(1,2,meanandsd_colnumbers)]
View(mean_and_sd)

##step3:
##Using descriptive activity names to name the activities in the data set:
mean_and_sd[(mean_and_sd[,2]==1),2]<-"LAYING"
mean_and_sd[(mean_and_sd[,2]==2),2]<-"WALKING"
mean_and_sd[(mean_and_sd[,2]==3),2]<-"WALKING_UPSTAIRS"
mean_and_sd[(mean_and_sd[,2]==4),2]<-"WALKING_DOWNSTAIRS"
mean_and_sd[(mean_and_sd[,2]==5),2]<-"SITTING"
mean_and_sd[(mean_and_sd[,2]==6),2]<-"STANDING"
View(mean_and_sd)

##step5:
##calculating the mean of each variable for each activity and each subject:
r1<-aggregate(mean_and_sd[,3:81],by=list(mean_and_sd$subject_id), mean)
r2<-aggregate(mean_and_sd[,3:81],by=list(mean_and_sd$activity_id), mean)
final_data<-rbind(r1,r2)
names(final_data)[1]<-"subject_id/activity"
View(final_data)
if(!file.exists("./data")){dir.create("./data")}
write.csv(final_data,"./data/final_data.csv")

