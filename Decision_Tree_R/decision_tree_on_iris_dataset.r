#give details of iris dataset
library(C50)
library (datasets)
data("iris")

#display attributes of iris dataset
names(iris)
#display dimensions of dataset
dim(iris)
#view the contents of dataset
View(iris)
#internal strucutre of dataset
str(iris)
#minimum value
# symbol "$" is used to choose attribute of dataset
min(iris$Sepal.Length)
#max value
max(iris$Sepal.Length)
#mean value
mean(iris$Sepal.Length)
# range of attribute value
range(iris$Sepal.Length)
#standard deviation
sd(iris$Sepal.Length)
#variance
var(iris$Sepal.Length)







# 1st 2nd and all quantile
quantile(iris$Sepal.Length)

# 1st 2nd and all quantile
quantile(iris$Sepal.Length,c(0.3,0.6))


#drawing histogram
#hist(v,main,xlab,xlim,ylim,breaks,col,border)
#v is a vector containing numeric values used in histogram.
#main indicates title of the chart.
#col is used to set color of the bars.
#border is used to set border color of each bar.
#xlab is used to give description of x-axis.
#xlim is used to specify the range of values on the x-axis.
#ylim is used to specify the range of values on the y-axis.
#breaks is used to mention the width of each bar.

hist(iris$Petal.Length)
h<-hist(iris$Sepal.Length,main= "sepal length frequency- histogram", xlab="sepal length", xlim=c(3.5,8.5), col="blue",border = "red")


h<-hist(iris$Sepal.Length,main= "sepal length frequency- histogram", xlab="sepal length", xlim=c(3.5,8.5), col="blue", labels=
          
          TRUE, breaks =3)


h<-hist(iris$Sepal.Length,main= "sepal length frequency- histogram", xlab="sepal length", xlim=c(3.5,8.5), col="blue", labels=TRUE, breaks =3, border = "green",las = 2)

#boxplot code

boxplot(iris$Sepal.Length)

#display summary of boxplot

summary(iris$Sepal.Length)

#combined boxplot for all 4 feature
boxplot(iris[,-5])

#identify outliers
myboxplot<-boxplot(iris[,-5])
myboxplot$out

#OPTIONAL
par(mar=c(7,5,1,1)) # more space to labels
boxplot(iris,las=2)
irisVer <- subset(iris, Species == "versicolor")
irisSet <- subset(iris, Species == "setosa")
irisVir <- subset(iris, Species == "virginica")
par(mfrow=c(1,3),mar=c(6,3,2,1))
boxplot(irisVer[,1:4], main="Versicolor",ylim = c(0,8),las=2)
boxplot(irisSet[,1:4], main="Setosa",ylim = c(0,8),las=2)
boxplot(irisVir[,1:4], main="Virginica",ylim = c(0,8),las=2)


#Classification with Decision Trees
input <- iris[,1:4]
output <- iris[,5]
model1 <- C5.0(input, output, control = C5.0Control(noGlobalPruning = TRUE,minCases=1))
plot(model1, main="C5.0 Decision Tree - Unpruned, min=1")
