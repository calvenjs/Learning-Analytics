# Learning-Analytics Predictive Analytics Module Final Project

## Project Overview
In Portugal, the student failure and dropping out rates remains high in Europe. The failure in the core classes of Mathematics and Portuguese is important and severe as it will affect their other remaining subjects. Hence, there is a compelling need to enhance the learning of these two subjects. With the help of Learning Analytics, educators can predict these students’ performance on the two subjects, provide them with personalized learning experience and increase retention rate. Hence, a roll out of collecting students’ data is implemented. The data were collected from school reports based on paper sheets and questionnaires were designed with closed questions for students to answer. The questions were reviewed by school professionals and tested on 15 students for feedback. The questionnaire was later modified to contain 37 questions in a single A4 sheet.
This project aims to predict student's achievement and identify key factors that affect education success or failure for the two core subjects; math and portuguese.

## Data Source
The dataset is a public data provided by Paulo Cortex and Alice Silva from University of Minho in Portugal. Paulo Cortex is an associate professor of Information Systems and a coordinator of the research group of Algorithmi Research Centre in the University. Algorithmi is a research unit that develops R&D activity in Information and Communications Technology and Electronics. They focus its activities that explore a strong link with the community, namely public administration. Data is dated back in 2005 and 2006, and contains student grades, demographics, social and school-releated features.

## Data Understanding
This dataset approaches the student performance by grades in two public secondary school from Alentejo district in Portugal. These two datasets are provided regarding the performance of the students in two distinct subjects: Mathematics and Portuguese. The dataset comprises real-world data of students’ grades, demographic, social and school related features which are collected by using school reports and questionnaires in 2005 and 2006. The database of school reports includes a few attributes (the three period grades, number of absences) while the questionnaires are used to complement this information like student’s demographics (mother’s education, family income), social or emotional (alcohol consumption, romance relationship) and school related variables (number of failures, extra-curricular activities, extra paid classes) that were expected to affect student performance. The data contains 395 records for Mathematics and 649 records for Portuguese language classes.
There are 32 explanatory variables and 1 response variable.
The explanatory variables are school, sex, address, family size (famsize), parent’s cohabitation status (Pstatus), mother’s education (Medu), father’s education (Fedu), mother’s job (Mjob), father’s job (Fjob), reason, guardian, traveltime, studytime, failures, extra educational support (schoolsup), family education support (famsup), paid, activities, nursery, interest in higher education (higher), internet, romantic, quality of family relationships (famrel), freetime, goout, workday alcohol consumption (Dalc), weekend alcohol consumption (Walc), health, absences, G1 and G2.
The response variable is G3.

The data used for the models will **not include** past evaluations (G1, G2) to predict their final grade (G3) in order to identify other features other than past grades that may affect G3.

### Scope
The two different datasets are not conjunct, will not be joined and will be treated separately at all times. This is to ensure accuracy as both of these core subjects may have different factors that affect the performance. Hence, the prediction and discovering the factors that affect students’ performance is unique and special to each of the two core subjects.

## Data Preparation
* Min-max normalization on G3
* Integer encoding on categorical variables
* Binary classification for G3 (pass, fail)


## Models
* Support Vector Machine
* Random Forest
* ANN
* CART + Logistic Regression with supervisor model RF, 10-fold cross validation

## Model Evaluation





