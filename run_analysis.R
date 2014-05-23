require(data.table)
require(reshape2)  ## fordecasting
## Reading all required data files
read.table("test\\X_test.txt")->X_test
read.table("train\\x_train.txt")->X_train
read.table("test\\subject_test.txt",col.names=c("Subject"))->subject_test
read.table("train\\subject_train.txt",,col.names=c("Subject"))->subject_train
read.table("features.txt")->features
read.table("activity_labels.txt")-> act_desc
read.table("test\\Y_test.txt",col.names = c("act_no"))->y_test
read.table("train\\Y_train.txt",col.names = c("act_no"))->y_train
##Selecting mean and Std column numbers from features
grep("mean()",features$V2,fixed = TRUE)->reqfea1
grep("std()",features$V2,fixed = TRUE)->reqfea2
sort(c(reqfea1,reqfea2))->reqfeatures
##getting required column names
features$V2[reqfeatures]->reqfeanames
##Cleaning colum header
sub("Body","",reqfeanames, fixed = TRUE)->tempnames
sub("()","",tempnames,fixed = TRUE )->tempnames
sub("_","",tempnames,fixed = TRUE)->tempnames
gsub("-","",tempnames,fixed = TRUE)->tempnames
sub("mean","_Mean",tempnames, fixed = TRUE)->tempnames
sub("std","_Std",tempnames, fixed = TRUE)->reqfeanames
rm(tempnames)
##Selecting required column form X files (test and train)
X_test[reqfeatures]->X_test_req
X_train[reqfeatures]->X_train_req
##Including cleaned column headers for X files
colnames(X_test_req) <- reqfeanames
colnames(X_train_req) <- reqfeanames
act_name<- act_desc$V2
act_name[y_test$act_no]->test_act_desc
act_name[y_train$act_no]->train_act_desc
Subject<-subject_test
act_Desc<-test_act_desc
cbind(Subject,act_Desc,X_test_req)->test_clean
Subject<- subject_train
act_Desc<-train_act_desc
cbind(Subject,act_Desc,X_train_req)->train_clean
data.table(rbind(test_clean,train_clean))->clean_set
melt(clean_set,i=1:2,measure=3:ncol(clean_set))->melt_clean_set
dcast.data.table(melt_clean_set,Subject+act_Desc~variable,fun=mean)->Clean_tiny_set
write.csv(Clean_tiny_set, file = "Tiny_set.csv")
