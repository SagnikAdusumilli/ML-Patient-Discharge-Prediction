#TBD: Data extration from files
#import packages;
library(dplyr)
library(reshape2)
library(ggplot2)
library(Hmisc)
library(corrplot)
library(mice)
library(VIM)
library(pROC)
library(caret)
library(sqldf)
getwd();
setwd()
hospital=read.csv("./data-set/NRD_2016_Hospital", header = TRUE, na.strings = c("NA","","#NA"))
sevierty=read.csv(file.choose(), header = TRUE, na.strings = c("NA","","#NA"))
head(hospital)
str(hospital)
# how to push to github
#TBD: Data prep for different models (includes visuals)

#TBD: creation of models

#TBD: validation