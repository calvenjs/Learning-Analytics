#Random Forest
#Change variables/dataset accordingly
################### Initialize ###################
#install.packages("randomForest")
#install.packages("Metrics")
library(caret)
library(rpart)
library(randomForest)
library(e1071)
library(rpart.plot)
library(caret)
library(Metrics)
library(foreach)
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




#RF
#Classification
control <- trainControl(method = "cv", number = 5)

#random forest model

set.seed(2)
rf_model <- train(binaryfinal~failures+absences+schoolsupn+age+highern+Mjobn, data = dat_math, trControl = control)

#check optimal parameters
print(rf_model)
set.seed(2)
forest_model <-randomForest(as.factor(binaryfinal)~failures+absences+schoolsupn+age+highern+Mjobn,data=dat_math,mtry=2)
predictedbinary <- predict(forest_model,data=dat_math)
head(predictedbinary,10)
head(dat$binaryfinal,10)
Total_Record <- length(dat_math$failures)
Correct_Count <- sum((dat_math$binaryfinal == predictedbinary) == TRUE)
Accuracy395 <- Correct_Count / Total_Record
Accuracy395




#Regression
#set tuning parameters
control <- trainControl(method = "cv", number = 5)

#random forest model
set.seed(2)
rf_model <- train(G3~failures+absences+schoolsupn+age+highern+Mjobn, data = dat_por, method = "parRF", trControl = control, prox = TRUE, allowParallel = TRUE)

#check optimal parameters
print(rf_model)
set.seed(2)
forest_model <-randomForest(G3~failures+absences+schoolsupn+age+highern+Mjobn,dat=dat_por,mtry=2)
predictedG3 <- predict(forest_model,data=dat_por)
rmse(dat_por$G3,predictedG3)





