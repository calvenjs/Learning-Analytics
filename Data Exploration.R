################### Initialize ###################
require(ggplot2) #to plot diagrams
require(cowplot) #to use "plot_grid" (divide ggplot into grid)

setwd("C:/Users/NPStudent/Desktop/Year 2/Predictive Analytics")
rm(list=ls()) #clear workspace
set.seed(2) #to avoid random result
library(dplyr)

#Set ylim for ggplot
ylim_min <- 0
ylim_max <- 200
xlim_max <- 300

#Read math csv
dat1 <- read.csv(file = "Math.csv", stringsAsFactors=FALSE, na.strings=c("NA", "NULL"))
math_full <- dat1

#Read por csv
dat2 <- read.csv(file = "Por.csv", stringsAsFactors=FALSE, na.strings=c("NA", "NULL"))
por_full <- dat2

#Exploring the data
summary(math_full)
summary(por_full)
rowSums(is.na(math_full)) #finding missing values in row
colSums(is.na(math_full)) #find missing values in column
rowSums(is.na(por_full))
colSums(is.na(por_full))
#Por (Counting number of rows for each variable category)
nrow(por_full)
GP <-subset(por_full,por_full$school == "GP")
nrow(GP)
MS <-subset(por_full,por_full$school == "MS")
nrow(MS)
Male <- subset(por_full, por_full$sex == "M")
nrow(Male)
Female <- subset(por_full,por_full$sex=="F")
nrow(Female)
Other <- subset(por_full,por_full$failures=="0")
nrow(Other)
549+70+16+14
14/649*100

# Pie Chart with Percentages for Math
slices <- c(65,35)
lbls <- c("GP", "MS")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels
lbls <- paste(lbls,"%",sep="") # ad % to labels
pie(slices,labels = lbls,
    main="Pie Chart of Por") 

# Pie Chart with Percentages for Por
slices <- c(13,87)
lbls <- c("Yes", "No")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels
lbls <- paste(lbls,"%",sep="") # ad % to labels
pie(slices,labels = lbls,
    main="Pie Chart of Math") 


#Boxplot for Math
boxplot(G3~higher,data=math_full, main="higher vs G3 (Math) ",xlab="higher", ylab="G3")
# Boxplot for Por 
boxplot(G3~higher,data=por_full, main="higher vs G3 (Por)",xlab="higher", ylab="G3") 

max(por_full$age)
min(por_full$age)
mean(math_full$age)
mean(por_full$age)
sd(math_full$age)
sd(por_full$age)
summary(por_full$absences)
sd(math_full$absences)

#Barplot for address
barplot(table(por_full$address))

tablemath <- table(math_full$famsize,math_full$Level.Grade)
tablepor <- table(por_full$famsize,por_full$Level.Grade)

#Histogram for medu for math/por
dat_Medu <- math_full$Medu #Just change the por/math to por/math accordingly
dat_Medu_Unique <- unique(dat_Medu)
dat_Medu_Unique <- sort(dat_Medu_Unique)
dat_Medu_Unique <- data.frame(dat_Medu_Unique)
colnames(dat_Medu_Unique)

dat_Medu_Count <- table(dat_Medu)
print(dat_Medu_Count)
dat_Medu_Count <- data.frame(dat_Medu_Count)
colnames(dat_Medu_Count) <- c("Education", "Freq")

ylim <- c(0, 1.2 * max(dat_Medu_Count$Freq)) #to extend the range of the y axis
chart <- barplot(dat_Medu_Count$Freq, main="Math Histogram for Mother's Edu", xlab="Education", ylab="Frequency", ylim=ylim)
## Add text at top of bars
text(x=chart, y = dat_Medu_Count$Freq, label=dat_Medu_Count$Freq , pos=3)
## Add x-axis labels 
axis(1, at=chart, labels=dat_Medu_Count$'Education', tick=FALSE, las=2)


#Histogram for age for math/por
dat_Age <- math_full$age #Just change the por/math to por/math accordingly
dat_Age_Unique <- unique(dat_Age)
dat_Age_Unique <- sort(dat_Age_Unique)
dat_Age_Unique <- data.frame(dat_Age_Unique)
colnames(dat_Age_Unique)

dat_Age_Count <- table(dat_Age)
dat_Age_Count <- data.frame(dat_Age_Count)
colnames(dat_Age_Count) <- c("Age", "Freq")


ylim <- c(0, 1.2 * max(dat_Age_Count$Freq)) #to extend the range of the y axis
chart <- barplot(dat_Age_Count$Freq, main="Math Histogram for Age", xlab="Age", ylab="Frequency", ylim=ylim)
## Add text at top of bars
text(x=chart, y = dat_Age_Count$Freq, label=dat_Age_Count$Freq , pos=3)
## Add x-axis labels 
axis(1, at=chart, labels=dat_Age_Count$'Age', tick=FALSE, las=2)


#Histogram for G3 for math/por
dat_G3 <- por_full$G3 #Just change the por/math to por/math accordingly
dat_G3_Unique <- unique(dat_G3)
dat_G3_Unique <- sort(dat_G3_Unique)
dat_G3_Unique <- data.frame(dat_G3_Unique)
colnames(dat_G3_Unique)

dat_G3_Count <- table(dat_G3)
dat_G3_Count <- data.frame(dat_G3_Count)
colnames(dat_G3_Count) <- c("G3", "Freq")


ylim <- c(0, 1.2 * max(dat_G3_Count$Freq)) #to extend the range of the y axis
chart <- barplot(dat_G3_Count$Freq, main="Por Histogram for G3", xlab="G3", ylab="Frequency", ylim=ylim)
## Add text at top of bars
text(x=chart, y = dat_G3_Count$Freq, label=dat_G3_Count$Freq , pos=3)
## Add x-axis labels 
axis(1, at=chart, labels=dat_G3_Count$'G3', tick=FALSE, las=2)

#Histogram for G1 for math/por
dat_G1 <- por_full$G1 #Just change the por/math to por/math accordingly
dat_G1_Unique <- unique(dat_G1)
dat_G1_Unique <- sort(dat_G1_Unique)
dat_G1_Unique <- data.frame(dat_G1_Unique)
colnames(dat_G1_Unique)

dat_G1_Count <- table(dat_G1)
dat_G1_Count <- data.frame(dat_G1_Count)
colnames(dat_G1_Count) <- c("G1", "Freq")


ylim <- c(0, 1.2 * max(dat_G1_Count$Freq)) #to extend the range of the y axis
chart <- barplot(dat_G1_Count$Freq, main="Por Histogram for G1", xlab="G1", ylab="Frequency", ylim=ylim)
## Add text at top of bars
text(x=chart, y = dat_G1_Count$Freq, label=dat_G1_Count$Freq , pos=3)
## Add x-axis labels 
axis(1, at=chart, labels=dat_G1_Count$'G1', tick=FALSE, las=2)



#Scatterplot for G3 vs Absences
plot(por_full[c("absences","G3")],ylim=c(0,20),xlim=c(0,93),main="G3 VS Absences (Por) ", col=c("red"))

plot(por_full[c("studytime","G3")],ylim=c(0,20),main="G3 VS studytime (Por) ", col=c("blue"))

plot(por_full[c("Dalc","G3")],ylim=c(0,20),main="G3 VS Dalc (Por) ", col=c("red"))
 
#Density plot for studytime
dv1 = density(math_full$studytime)
dv2 = density(por_full$studytime)
plot(range(dv1$x, dv2$x), range(dv1$y, dv2$y), type = "n", xlab = "Math(blue) and Por(red)", 
     ylab = "Density")
lines(dv1, col = "blue")
lines(dv2, col = "red")


#Exploring scales of selected configuration
conf2 <- data.frame(failures=dat$failures,goout=dat$goout,health=dat$health,absences=dat$absences,schoolsup=dat$schoolsup,Medu=dat$Medu)
head(subset(conf2, select=c("failures", "goout","health","absences","schoolsup","Medu")),n=10)

conf3 <- data.frame(failures=dat$failures,absences=dat$absences,schoolsup=dat$schoolsup,higher=dat$higher,Mjob=dat$Mjob,age=dat$age)
head(subset(conf3, select=c("failures", "absences","schoolsup","higher","Mjob","age")),n=10)




