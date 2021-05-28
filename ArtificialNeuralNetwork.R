#ANN
#Change variables/dataset accordingly
setwd("C:/Users/NPStudent/Desktop/Year 2/Predictive Analytics")
rm(list=ls()) #clear workspace
set.seed(2) #to avoid random result
library(nnet)

source("util.R") #execute the .R file to define user-defined functions 

################### Loading of data ###################
dat_math <- read.csv(file = "Math Data Preparation.csv", stringsAsFactors=FALSE, na.strings=c("NA", "NULL"))
dat_por <- read.csv(file = "Por Data Preparation.csv", stringsAsFactors=FALSE, na.strings=c("NA", "NULL"))




#Retrieve only the selected columns
dat_math <- dat_math[c("schooln","famsizen","Fjobn","Mjobn","schoolsupn","absences","highern","failures"
                  ,"goout","health","age","Medu","Fedu","studytime","G3","binaryfinal","school","Dalc")]
dat_por <- dat_por[c("schooln","famsizen","Fjobn","Mjobn","schoolsupn","absences","highern","failures"
             ,"goout","health","age","Medu","Fedu","studytime","G3","binaryfinal","school","Dalc")]
  

z = dat_por$G3
z = as.numeric(z) #force z into numeric
dat_por$G3 = z


###############################################################################################
#Part 2: Artificial Neural Network
###############################################################################################
#Build with "train_dat"

#initialize hidden neuron size and maximum iteration
hidden_neuron_size <- 5
nnet_max_ite <- 1000

#classification 
nnet1 <- nnet(binaryfinal~failures+absences+Dalc+health+Mjobn+Fjobn, dat_por, size = hidden_neuron_size, rang = 0.1,
              decay = 5e-4, maxit = nnet_max_ite) #rang = initial random weights, maxit = maximum iteration

summary(nnet1)


nn.output <- predict(nnet1, dat_por)
dat_por$nn.output <-nn.output 

Total_Record <- length(dat_por$failures)
nn.output <- replace(nn.output, (nn.output > 0.5), 1)
nn.output <- replace(nn.output, (nn.output <= 0.5), 0)
Correct_Count <- sum((dat_por$binaryfinal == nn.output) == TRUE)
Accuracy395 <- Correct_Count / Total_Record
Accuracy395


#Regression
min_max_G3 <- MIN_MAX(dat_por$G3)
dim(min_max_G3)
min_max_G3

#min-max normalization on G3.
set.seed(2)
dat_por$G3 <- MIN_MAX_NORMALIZATION(dat_por$G3, min_max_G3)

nnet1 <- nnet(G3~failures+absences+Dalc+health+Mjobn+Fjobn, dat_por, size = hidden_neuron_size, rang = 0.1,
              decay = 5e-4, maxit = nnet_max_ite) #rang = initial random weights, maxit = maximum iteration

summary(nnet1)

nn.output <- predict(nnet1, dat_por)
dat_por$nn.output <-nn.output 
#reverse min-max normalization
set.seed(2)
dat_por$G3 <- MIN_MAX_DENORMALIZATION(dat_por$G3, min_max_G3)
dat_por$nn.output <- MIN_MAX_DENORMALIZATION(dat_por$nn.output, min_max_G3)

Rmse <- RMSE(dat_por$G3, dat_por$nn.output)
Rmse

