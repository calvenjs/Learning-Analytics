#Support Vector Machine
#Change dataset/variables accordingly
library(e1071)
library(Metrics)
setwd("C:/Users/NPStudent/Desktop/Year 2/Predictive Analytics")
rm(list=ls()) #clear workspace
set.seed(2) #to avoid random result

source("util.R") #execute the .R file to define user-defined functions 

################### Loading of data ###################
dat <- read.csv(file = "Math Data Preparation.csv", stringsAsFactors=FALSE, na.strings=c("NA", "NULL"))
dat_math <- dat
dat_por <- read.csv(file = "Por Data Preparation.csv", stringsAsFactors=FALSE, na.strings=c("NA", "NULL"))

#Retrieve only the selected columns
dat_math <- dat_math[c("Mjobn","schoolsupn","absences","highern","failures"
                  ,"goout","health","age","Medu","Fedu","studytime","G3","binaryfinal","school")]
dat_por <- dat_por[c("schooln","famsizen","Fjobn","Mjobn","schoolsupn","absences","highern","failures"
                     ,"goout","health","age","Medu","Fedu","studytime","G3","binaryfinal","school","Dalc")]


#binary
model<-svm(binaryfinal~failures+absences+Dalc+health+Mjobn+Fjobn,data=dat_por)
svm.pred <- predict(model,dat_por)

Total_Record <- length(dat_por$failures)
svm.pred <- replace(svm.pred, (svm.pred > 0.5), 1)
svm.pred <- replace(svm.pred, (svm.pred <= 0.5), 0)
Correct_Count <- sum((dat_por$binaryfinal == svm.pred) == TRUE)
Accuracy395 <- Correct_Count / Total_Record
Accuracy395

obj = tune.svm(G3~failures+absences+Dalc+schoolsupn+goout+Medu,data=dat_por,cost=1:10,gamma=seq(0,1,0.5)) 
obj
#regression
model<-svm(G3~failures+absences+Dalc+health+Mjobn+Fjobn,data=dat_por)
predictedG3 <- predict(model,data=dat_por)
rmse(dat_por$G3,predictedG3)

#perform a grid search
tuneResult <- tune(svm,G3~failures+absences+schoolsupn+age+highern+Mjobn,data=dat_por,ranges=list(epsilon=seq(0,1,0.1),cost=2^(2:9)))
print(tuneResult)
plot(tuneResult)

tunedModel <- tuneResult$best.model
tunedModelG3 <- predict(tunedModel,data=dat_por)
rmse(dat_por$G3,tunedModelG3)

