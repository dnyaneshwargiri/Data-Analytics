#install "caTools" 
#go to tools menu. Give name caTools and click intall
#this is required for the splitting of data

library(caTools)

#for naive bayes install "e1071" package in the same way as caTools

library(e1071)


#open a dataset in the dormat of csv file
#this is not built in dataset of r

mydata <-read.csv(file = "/home/mmcoe/Downloads/diabetes.csv",header=TRUE,sep=",")
View(mydata)


#split the data
temp_field<-sample.split(mydata,SplitRatio = 0.7)

#keep 70% for training
train<-subset(mydata,temp_field==TRUE)

#keep 30% for testing
test<-subset(mydata,temp_field==FALSE)

#display few samples

head(train)
head(test)
tail(train)
tail(test)
summary(mydata)
#Create age category column 
mydata$Age_Cat <- ifelse(mydata$Age < 21, "<21",
                        ifelse((mydata$Age>=21), ">=21"))
mydata$Age_Cat<- factor(mydata$Age_Cat, levels = c('<21','>=21'))
table(mydata$Age_Cat)

# use of naive bayes algorithm
#create a learning model
# in train data outcome field indicates class value (0/1)
# naive bayes want the output not in numeric form but in the category form so use "as.factor"
# use of "~." indicates the outcome to be learned against all other fields of dataset

my_model <-naiveBayes(as.factor(train$Outcome)~.,train)
my_model

#prediction class
#from test data exclude 9th column wmodel,test[,-9])model,test[,-9])hich is outcome column


pred1<-predict(my_model,test[,-9])
pred1

 # to display the probability of outcome use type="raw"

pred1<-predict(my_model,test[,-9],type="raw")
pred1

# to display the prediction class of outcome use type="class"

pred1<-predict(my_model,test[,-9],type="class")
pred1

#generate the confusion matrix
table(pred1,test$Outcome,dnn=c("predicted","actual"))

#save the predictiolibrary(e1071)n
output<-cbind(test,pred1)
View(output)