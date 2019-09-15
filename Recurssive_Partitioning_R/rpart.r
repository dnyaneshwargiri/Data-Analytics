library(e1071)
library(caTools)
library(rpart)

mydata<-read.csv(file="/home/mmcoe/Downloads/pfa/tripdata.csv",header=TRUE,sep=",")
View(mydata)
dim(mydata)
#consider column1,4,6,9 - output class
subset_mydata <- mydata[,c(1,4,6,9)]
temp_field <- sample.split(subset_mydata,SplitRatio=0.9)
train <- subset(subset_mydata, temp_field==TRUE)
View(train)
test <- subset(subset_mydata, temp_field==FALSE)
View(test)
summary(train)
summary(test)
head(train)
head(test)
train(1:10,)
View(train)
tail(train)
tail(test)
dim(test)
dim(train)
View(mydata[1:10,])

fit <- rpart(train$Member.type~.,data=train,method="class")
text(fit)
plot(fit)

#test excluding last colm
pred<- predict(fit,newdata=test[,-4],type=("class"))
mean(pred==test$Member.type)
table(pred,test$Member.type,dnn=c("predicted","actual"))
output <- cbind(test,pred)
View(output)

#fit<- rpart(train$Member.type~., data=train)
printcp(fit)
opt<- which.min(fit$cptable[,"xerror"])
cp <- fit$cptable[opt,"CP"]
#prune tree
pruned_model<-prune(fit,cp)

plot(fit)
text(fit)

#find proportion of correct prediction using test set
rpart_pruned_predict<- predict(pruned_model,test[,-4],type="class")
mean(rpart_pruned_predict==test$Member.type)
output1 <- cbind(test,pred)
View(output1)