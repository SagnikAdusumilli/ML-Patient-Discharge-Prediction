###############################################################################################################
#import packages
###############################################################################################################
install.packages(c("dplyr", "reshape2", "ggplot2", "Hmisc", "corrplot", "mice", "VIM", "pROC","caret", "sqldf","data.table", "R.utils", "rpart", "rpart.plot", "randomForest"))

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
library(data.table)
library(R.utils)
library(rpart) # Classification Tree with rpart
library(rpart.plot)
library(randomForest) # classification algorithm

#NRD_2016_Core=read.csv(file.choose(), header = TRUE, na.strings = c("NA","","#NA"), nrows = 10000)
#NRD_2016_Severity=read.csv(file.choose(), header = TRUE, na.strings = c("NA","","#NA"))
#NRD_2016_Hospital=read.csv(file.choose(), header = TRUE, na.strings = c("NA","","#NA"))
##write.csv(NRD_2016_Core, file = "~/M/NRD_2016/NRD_2016_Core_FirstMillion.CSV")
#TBD: Data extration from files

setwd("/Users/aliel-sharif/DeskTop/York/data")
getwd()

###############################################################################################################
#pre-validate the files
###############################################################################################################
nRowsCore <- countLines("NRD_2016_Core.CSV")
nRowsSeverity <- countLines("NRD_2016_Severity.CSV")
nRowsHospital <- countLines("NRD_2016_Hospital.CSV")

print(nRowsCore) #17,197,683
print(nRowsSeverity)  # 17,197,683
print(nRowsHospital) #2355

###############################################################################################################
#read the core file and extract heart failure patients
###############################################################################################################

NRD_2016_Core1=read.csv("NRD_2016_Core.CSV", header = TRUE, na.strings = c("NA","","#NA"), nrows = 10000000)
NRD_2016_Core2=read.csv("NRD_2016_Core.CSV", header = TRUE, na.strings = c("NA","","#NA"), skip = 10000000)
#NRD_2016_Core=read.csv("NRD_2016_Core.CSV", header = TRUE, na.strings = c("NA","","#NA"), nrows = 1000000)

NRD_2016_Core_Colnames <- c("AGE",
                            "AWEEKEND",
                            "DIED",
                            "DISCWT",
                            "DISPUNIFORM",
                            "DMONTH",
                            "DQTR",
                            "DRG",
                            "DRGVER",
                            "DRG_NoPOA",
                            "I10_DX1",
                            "I10_DX2",
                            "I10_DX3",
                            "I10_DX4",
                            "I10_DX5",
                            "I10_DX6",
                            "I10_DX7",
                            "I10_DX8",
                            "I10_DX9",
                            "I10_DX10",
                            "I10_DX11",
                            "I10_DX12",
                            "I10_DX13",
                            "I10_DX14",
                            "I10_DX15",
                            "I10_DX16",
                            "I10_DX17",
                            "I10_DX18",
                            "I10_DX19",
                            "I10_DX20",
                            "I10_DX21",
                            "I10_DX22",
                            "I10_DX23",
                            "I10_DX24",
                            "I10_DX25",
                            "I10_DX26",
                            "I10_DX27",
                            "I10_DX28",
                            "I10_DX29",
                            "I10_DX30",
                            "I10_DX31",
                            "I10_DX32",
                            "I10_DX33",
                            "I10_DX34",
                            "I10_DX35",
                            "I10_ECAUSE1",
                            "I10_ECAUSE2",
                            "I10_ECAUSE3",
                            "I10_ECAUSE4",
                            "ELECTIVE",
                            "FEMALE",
                            "HCUP_ED",
                            "HOSP_NRD",
                            "KEY_NRD",
                            "LOS",
                            "MDC",
                            "MDC_NoPOA",
                            "I10_NDX",
                            "I10_NECAUSE",
                            "I10_NPR",
                            "NRD_DaysToEvent",
                            "NRD_STRATUM",
                            "NRD_VisitLink",
                            "PAY1",
                            "PL_NCHS",
                            "I10_PR1",
                            "I10_PR2",
                            "I10_PR3",
                            "I10_PR4",
                            "I10_PR5",
                            "I10_PR6",
                            "I10_PR7",
                            "I10_PR8",
                            "I10_PR9",
                            "I10_PR10",
                            "I10_PR11",
                            "I10_PR12",
                            "I10_PR13",
                            "I10_PR14",
                            "I10_PR15",
                            "PRDAY1",
                            "PRDAY2",
                            "PRDAY3",
                            "PRDAY4",
                            "PRDAY5",
                            "PRDAY6",
                            "PRDAY7",
                            "PRDAY8",
                            "PRDAY9",
                            "PRDAY10",
                            "PRDAY11",
                            "PRDAY12",
                            "PRDAY13",
                            "PRDAY14",
                            "PRDAY15",
                            "REHABTRANSFER",
                            "RESIDENT",
                            "SAMEDAYEVENT",
                            "TOTCHG",
                            "YEAR",
                            "ZIPINC_QRTL",
                            "DXVER",
                            "PRVER")

names(NRD_2016_Core1) <- NRD_2016_Core_Colnames
names(NRD_2016_Core2) <- NRD_2016_Core_Colnames


#select heart failure patients from the dataset based on ICD-10 codes I50*
where_clause <- 
"where I10_DX1 like 'I50%'
or I10_DX2 like 'I50%'
or I10_DX3 like 'I50%'
or I10_DX4 like 'I50%'
or I10_DX5 like 'I50%'
or I10_DX6 like 'I50%'
or I10_DX7 like 'I50%'
or I10_DX8 like 'I50%'
or I10_DX9 like 'I50%'
or I10_DX10 like 'I50%'
or I10_DX11 like 'I50%'
or I10_DX12 like 'I50%'
or I10_DX13 like 'I50%'
or I10_DX14 like 'I50%'
or I10_DX15 like 'I50%'
or I10_DX16 like 'I50%'
or I10_DX17 like 'I50%'
or I10_DX18 like 'I50%'
or I10_DX19 like 'I50%'
or I10_DX20 like 'I50%'
or I10_DX21 like 'I50%'
or I10_DX22 like 'I50%'
or I10_DX23 like 'I50%'
or I10_DX24 like 'I50%'
or I10_DX25 like 'I50%'
or I10_DX26 like 'I50%'
or I10_DX27 like 'I50%'
or I10_DX28 like 'I50%'
or I10_DX29 like 'I50%'
or I10_DX30 like 'I50%'
or I10_DX31 like 'I50%'
or I10_DX32 like 'I50%'
or I10_DX33 like 'I50%'
or I10_DX34 like 'I50%'
or I10_DX35 like 'I50%'" 

NRD_2016_Core_1_HeartFailure <- sqldf(paste("select * from NRD_2016_Core1", where_clause))
NRD_2016_Core_2_HeartFailure <- sqldf(paste("select * from NRD_2016_Core2", where_clause))
NRD_2016_Core_HeartFailure <- rbind(NRD_2016_Core_1_HeartFailure, NRD_2016_Core_2_HeartFailure) 
remove(NRD_2016_Core1)
remove(NRD_2016_Core2)
remove(NRD_2016_Core_Colnames)
remove(where_clause)
remove(NRD_2016_Core_1_HeartFailure)
remove(NRD_2016_Core_2_HeartFailure)

###############################################################################################################
#read the Severity file
###############################################################################################################

NRD_2016_Severity=read.csv("NRD_2016_Severity.CSV", header = FALSE, na.strings = c("NA","","#NA"))

names(NRD_2016_Severity) <- c("APRDRG",
                              "APRDRG_Risk_Mortality",
                              "APRDRG_Severity",
                              "HOSP_NRD",
                              "KEY_NRD")

NRD_2016_Hospital=read.csv("NRD_2016_Hospital.CSV", header = FALSE, na.strings = c("NA","","#NA"))

names(NRD_2016_Hospital) <- c("HOSP_BEDSIZE",
                              "H_CONTRL",
                              "HOSP_NRD",
                              "HOSP_URCAT4",
                              "HOSP_UR_TEACH",
                              "NRD_STRATUM",
                              "N_DISC_U",
                              "N_HOSP_U",
                              "S_DISC_U",
                              "S_HOSP_U",
                              "TOTAL_DISC",
                              "YEAR")

#disable KEY_NRD in scientific notation
options(scipen = 999)

Sev_Hosp <- merge(NRD_2016_Severity, NRD_2016_Hospital, by="HOSP_NRD")
Core_HeartFailure_Sev_Hosp <- merge(NRD_2016_Core_HeartFailure, Sev_Hosp, by="KEY_NRD")

remove(NRD_2016_Severity)
remove(NRD_2016_Hospital)
remove(Sev_Hosp)

#View(Core_HeartFailure_Sev_Hosp)

#View(Core_HeartFailure_Sev_Hosp)
#if not missing(LOS) and not missing(NRD_DaysToEvent) then PseudoDDate = NRD_DaysToEvent + LOS; discharge date is NRD_DaysToEvent + LOS */
Core_HeartFailure_Sev_Hosp$PseudoDDate <- Core_HeartFailure_Sev_Hosp$NRD_DaysToEvent + Core_HeartFailure_Sev_Hosp$LOS

#limited the selection of index events to predict readmission. IndexEvent =1 will be included for prediction; 0 is not an event we care about
# only include patients admitted between Jan and Nov and did not die
Core_HeartFailure_Sev_Hosp$IndexEvent <-ifelse(Core_HeartFailure_Sev_Hosp$DMONTH >= 1 & Core_HeartFailure_Sev_Hosp$DMONTH <= 11 &
                                        Core_HeartFailure_Sev_Hosp$DIED == 0 & Core_HeartFailure_Sev_Hosp$LOS >= 0  &
                                        grepl("I50", Core_HeartFailure_Sev_Hosp$I10_DX1) , 1, 0)

#retain index events = 1; these are the events we will predict on
Core_HeartFailure_Sev_Hosp<-Core_HeartFailure_Sev_Hosp[(Core_HeartFailure_Sev_Hosp$IndexEvent==1),]
#View(Core_HeartFailure_Sev_Hosp)


#i-> visit; c-> readmissiomn
Visits_Readmissions <- sqldf("select 
                                      i.NRD_VisitLink, 
                                      i.KEY_NRD, 
                                      i.NRD_DaysToEvent, 
                                      i.LOS, 
                                      i.PseudoDDate, 
                                      i.I10_DX1, 
                                      i.I10_DX2, 
                                      i.I10_DX3, 
                                      i.IndexEvent, 
                                      c.KEY_NRD, 
                                      c.NRD_DaysToEvent, 
                                      c.NRD_DaysToEvent-i.PseudoDDate As Diff, 
                                      c.I10_DX1, 
                                      c.I10_DX2, 
                                      c.I10_DX3, 
                                      c.IndexEvent
                             from Core_HeartFailure_Sev_Hosp as i inner join Core_HeartFailure_Sev_Hosp as c
                             on i.NRD_VisitLink=c.NRD_VisitLink and 
                                i.KEY_NRD <> c.KEY_NRD and 
                                i.IndexEvent=1 and 
                                (c.NRD_DaysToEvent-i.PseudoDDate) >= 0 
                             order by i.NRD_VisitLink, i.NRD_DaysToEvent, i.PseudoDDate, c.NRD_DaysToEvent")

#View(Visits_Readmissions)

#this is the classification output we are looking to predict 1 (1 if readmission is less than <= 30 day, o if readmission is less than 30 days)
Visits_Readmissions$ReadmittedWithin30Days <- ifelse(Visits_Readmissions$Diff <= 30, 1, 0)

#if the same patient has multiple visits, how to figure out which of the revisits counts as a readmission?

#prediction; does this visit (key_nrd), have at least one subsequent visit in which the difference is less than or equal to 30 days

#default value of 0
Core_HeartFailure_Sev_Hosp$ReadmittedWithin30Days <- 0
#if at least one admission subsequent to this encounter occurs within 30 days, assign readmission to 30 days to a value of 1
Core_HeartFailure_Sev_Hosp <- sqldf(c("Update Core_HeartFailure_Sev_Hosp
                                      Set ReadmittedWithin30Days = 1
                                        where KEY_NRD in (select KEY_NRD from Visits_Readmissions where ReadmittedWithin30Days = 1)", "select * from Core_HeartFailure_Sev_Hosp"))

#View(Core_HeartFailure_Sev_Hosp)

#str(Core_HeartFailure_Sev_Hosp) # check the structure of the data frame
#ncol(Core_HeartFailure_Sev_Hosp)  #check # ofcolumns - 121
#nrow(Core_HeartFailure_Sev_Hosp)  #check # of rows - 401,116

#drop columns holding constant values have no predictive value
Core_HeartFailure_Sev_Hosp2= subset(Core_HeartFailure_Sev_Hosp, select = -c(YEAR.y, DXVER, PRVER, DIED))
View(Core_HeartFailure_Sev_Hosp2)
ncol(Core_HeartFailure_Sev_Hosp2)  #check # ofcolumns - 118
nrow(Core_HeartFailure_Sev_Hosp2)  #check # of rows - 401,116
                                   #check for data balance

remove(Core_HeartFailure_Sev_Hosp)

#write.csv(Core_HeartFailure_Sev_Hosp2, file = "Core_HeartFailure_Sev_Hosp2.CSV")
#Core_HeartFailure_Sev_Hosp2=read.csv("Core_HeartFailure_Sev_Hosp2.CSV", header = TRUE, na.strings = c("NA","","#NA"))

temp1 <- sqldf("select count(*) from Core_HeartFailure_Sev_Hosp2 where ReadmittedWithin30Days = 1") 
View(temp1)

temp0 <- sqldf("select count(*) from Core_HeartFailure_Sev_Hosp2 where ReadmittedWithin30Days = 0")
View(temp0)

View(Core_HeartFailure_Sev_Hosp2)

####################################################################################################################################################
# Random Forest 
####################################################################################################################################################

# Split the data back into a train set and a test set
train <- Core_HeartFailure_Sev_Hosp2[1:200000,]
test <- Core_HeartFailure_Sev_Hosp2[200001:401116,]

# Set a random seed
set.seed(754)

# Build the model (note: not all possible variables are used)
rf_model <- randomForest(factor(ReadmittedWithin30Days) ~ AGE + AWEEKEND +  DISPUNIFORM + DMONTH  + DQTR + DRG + DRG_NoPOA + I10_DX1 + MDC + ELECTIVE +
                           FEMALE + LOS + RESIDENT+ HOSP_NRD.y + HOSP_BEDSIZE + HOSP_UR_TEACH+  PAY1 + PL_NCHS + ZIPINC_QRTL + SAMEDAYEVENT,
                         data = train)
# Show model error
plot(rf_model, ylim=c(0,0.36))
legend('topright', colnames(rf_model$err.rate), col=1:3, fill=1:3)

prediction <- predict(rf_model, test) # Predict using the test set
actualTest = test[,ncol(test)] # actual outputs for test set
confMatrixTest = table(prediction,actualTest) # compute confusion matrix
confMatrixTest #show confusion matrix

#compute accuracy
accuracyTest = sum(diag(confMatrixTest))/sum(confMatrixTest)
accuracyTest #show accuracy


#############################################################
# Decision Tree -- use the rpart library
#set.seed(1984)

#training = createDataPartition(Core_HeartFailure_Sev_Hosp2$ReadmittedWithin30Days, p = 0.6, list=FALSE)
#The createDataPartition command is giving me this error
#Error in cut.default(y, unique(quantile(y, probs = seq(0, 1, length = groups))),  : 
#                       invalid number of intervals
#trainData = Core_HeartFailure_Sev_Hosp2[training,]
#testData = Core_HeartFailure_Sev_Hosp2[-training,]

# train model, rand generate tree
#mod = rpart(ReadmittedWithin30Days~, data =trainData, method = "class") 
#mod = rpart(ReadmittedWithin30Days ~ ., data =train, method = "class") 
#prp(mod) # plot tree


# 2) Validate
#validation =  # read validation
#predicted = predict(mod, validation) # predict;
#actual = validation[,11] # actual outputs for
#table(actual,predicted) # show confusion matrix

# 3) Test
#test =  # read test data
#str(test) # check the structure of the data frame
#test$Y = predict(mod, test) # add predicted values to test
#test



