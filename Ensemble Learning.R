#Stacking Ensemble
#install.packages("caretEnsemble")
#install.packages("kernlab")
library(kernlab)
library(caretEnsemble)
library(caret)
library(rpart)
library(randomForest)
library(e1071)
library(rpart.plot)
library(caret)
library(Metrics)
library(foreach)
library(ipred)

setwd("C:/Users/NPStudent/Desktop/Year 2/Predictive Analytics")
rm(list=ls()) #clear workspace
set.seed(2) #to avoid random result

source("util.R") #execute the .R file to define user-defined functions 

################### Loading of data ###################
dat <- read.csv(file = "Math Preparation.csv", stringsAsFactors=FALSE, na.strings=c("NA", "NULL"))
dat_math <- dat


#Retrieve only the selected columns
dat <- dat_math[c("Mjobn","schoolsupn","absences","highern","failures"
                  ,"goout","health","age","Medu","Fedu","studytime","G3","binaryfinal","school")]



control <- trainControl(method="repeatedcv", number=10, repeats=3, savePredictions=TRUE, classProbs=TRUE)
algorithmList <- c('rpart', 'glm','svmRadial')
set.seed(2)
models <- caretList(G3~failures+absences+goout+schoolsupn+health+Medu, data=dat, trControl=control, methodList=algorithmList)
results <- resamples(models)
summary(results)
#splom(results)


# stack using random forest
set.seed(2)
stack.rf <- caretStack(models, method="rf", metric="RMSE", trControl=stackControl)
print(stack.rf)


#Bagging
control <- trainControl(method="repeatedcv", number=10, repeats=3)
seed <- 7
metric <- "Accuracy"
# Bagged CART
set.seed(seed)
fit.treebag <- train(G3~failures+absences+goout+schoolsupn+health+Medu, data=dat, method="treebag", metric=metric, trControl=control)
# Random Forest
set.seed(seed)
fit.rf <- train(G3~failures+absences+goout+schoolsupn+health+Medu, data=dat, method="rf", metric=metric, trControl=control)
# summarize results
bagging_results <- resamples(list(treebag=fit.treebag, rf=fit.rf))
summary(bagging_results)
dotplot(bagging_results)
