#library(R.utils)
#numberOfLines <- countLines("~/Machine Learning/ML 1000 - Machine Learning in Business Context/Assignment 1 - due Feb 17 2019/dataset/NRD_2016/NRD_2016_Core.CSV")
#numberOfLines #17,197,683

#library(sqldf)
#NRD_2016_Core <- read.csv.sql("~/Machine Learning/ML 1000 - Machine Learning in Business Context/Assignment 1 - due Feb 17 2019/dataset/NRD_2016/NRD_2016_Core.CSV",
#                              sql="select * from file")

NRD_2016_Core_1 <- read.csv("~/Machine Learning/ML 1000 - Machine Learning in Business Context/Assignment 1 - due Feb 17 2019/dataset/NRD_2016/NRD_2016_Core.CSV",
                          header=FALSE,
                          nrows=10000000)

NRD_2016_Core_2 <- read.csv("~/Machine Learning/ML 1000 - Machine Learning in Business Context/Assignment 1 - due Feb 17 2019/dataset/NRD_2016/NRD_2016_Core.CSV",
                            header=FALSE,
                            skip=10000000)

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

names(NRD_2016_Core_1) <- NRD_2016_Core_Colnames
names(NRD_2016_Core_2) <- NRD_2016_Core_Colnames

View(NRD_2016_Core_2)

library(sqldf)

where_clause <- "where I10_DX1 like 'I50%'
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

NRD_2016_Core_1_HeartFailure <- sqldf(paste("select * from NRD_2016_Core_1", where_clause))

NRD_2016_Core_2_HeartFailure <- sqldf(paste("select * from NRD_2016_Core_2", where_clause))

NRD_2016_Core_HeartFailure <- rbind(NRD_2016_Core_1_HeartFailure, NRD_2016_Core_2_HeartFailure) 

remove(NRD_2016_Core_1)
remove(NRD_2016_Core_2)
remove(NRD_2016_Core_Colnames)
remove(where_clause)
remove(NRD_2016_Core_1_HeartFailure)
remove(NRD_2016_Core_2_HeartFailure)

NRD_2016_Severity <- read.csv("~/Machine Learning/ML 1000 - Machine Learning in Business Context/Assignment 1 - due Feb 17 2019/dataset/NRD_2016/NRD_2016_Severity.CSV",
                              header=FALSE)

names(NRD_2016_Severity) <- c("APRDRG",
                              "APRDRG_Risk_Mortality",
                              "APRDRG_Severity",
                              "HOSP_NRD",
                              "KEY_NRD")

View(NRD_2016_Severity)

NRD_2016_Hospital <- read.csv("~/Machine Learning/ML 1000 - Machine Learning in Business Context/Assignment 1 - due Feb 17 2019/dataset/NRD_2016/NRD_2016_Hospital.CSV",
                              header=FALSE)

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

View(NRD_2016_Hospital)

# to eliminate showing KEY_NRD in scientific notation
options(scipen = 999)

Sev_Hosp <- merge(NRD_2016_Severity, NRD_2016_Hospital, by="HOSP_NRD")
View(Sev_Hosp)

Core_HeartFailure_Sev_Hosp <- merge(NRD_2016_Core_HeartFailure, Sev_Hosp, by="KEY_NRD")
View(Core_HeartFailure_Sev_Hosp)

remove(NRD_2016_Severity)
remove(NRD_2016_Hospital)
remove(Sev_Hosp)

#write.csv(NRD_2016_Core_HeartFailure, file = "~/Machine Learning/ML 1000 - Machine Learning in Business Context/Assignment 1 - due Feb 17 2019/dataset/NRD_2016/NRD_2016_Core_HeartFailure.CSV")
#write.csv(Core_HeartFailure_Sev_Hosp, file = "~/Machine Learning/ML 1000 - Machine Learning in Business Context/Assignment 1 - due Feb 17 2019/dataset/NRD_2016/Core_HeartFailure_Sev_Hosp.CSV")

Core_HeartFailure_Sev_Hosp$PseudoDDate <- Core_HeartFailure_Sev_Hosp$NRD_DaysToEvent + Core_HeartFailure_Sev_Hosp$LOS

#Core_HeartFailure_Sev_Hosp$IndexEvent <- (Core_HeartFailure_Sev_Hosp$I10_DX1 == 'I509') & (Core_HeartFailure_Sev_Hosp$SAMEDAYEVENT == 0) & (Core_HeartFailure_Sev_Hosp$DIED == 0)
#Core_HeartFailure_Sev_Hosp$IndexEvent <- ifelse(grepl("I50", Core_HeartFailure_Sev_Hosp$I10_DX1) | grepl("I50", Core_HeartFailure_Sev_Hosp$I10_DX2) | grepl("I50", Core_HeartFailure_Sev_Hosp$I10_DX3), 1, 0)
Core_HeartFailure_Sev_Hosp$IndexEvent <- ifelse(Core_HeartFailure_Sev_Hosp$DMONTH >= 1 & Core_HeartFailure_Sev_Hosp$DMONTH <= 11 &
                                                Core_HeartFailure_Sev_Hosp$DIED == 0 & Core_HeartFailure_Sev_Hosp$LOS >= 0  &
                                                grepl("I50", Core_HeartFailure_Sev_Hosp$I10_DX1), 1, 0)


Visits_Readmissions <- sqldf("select i.NRD_VisitLink, i.KEY_NRD, i.NRD_DaysToEvent, i.LOS, i.PseudoDDate, i.I10_DX1, i.I10_DX2, i.I10_DX3, i.IndexEvent, c.KEY_NRD, c.NRD_DaysToEvent, c.NRD_DaysToEvent-i.PseudoDDate As Diff, c.I10_DX1, c.I10_DX2, c.I10_DX3, c.IndexEvent
	                                               /*case when c.KEY_NRD is not null then 'TRUE' else 'FALSE' end as Readmit,
                                                 c.TOTCHG as ReadmitCHG,
                                                 c.NRD_DaysToEvent as DaysToReadmit,
                                                 c.PseudoDDate as PseudoDDate_R*/
                                                 from Core_HeartFailure_Sev_Hosp as i 
                                                 inner join Core_HeartFailure_Sev_Hosp as c
                                                 on i.NRD_VisitLink=c.NRD_VisitLink and i.KEY_NRD <> c.KEY_NRD
                                                 and i.IndexEvent=1
                                                 and (c.NRD_DaysToEvent-i.PseudoDDate) >= 0 /*between 0 and 30*/
                                                 /*where i.NRD_VisitLink = 'd00306n'*/
                                                 order by i.NRD_VisitLink, i.NRD_DaysToEvent, i.PseudoDDate, c.NRD_DaysToEvent/*i.NRD_VisitLink, i.KEY_NRD, c.NRD_DaysToEvent, c.PseudoDDate*/")

View(Visits_Readmissions)

Visits_Readmissions$ReadmittedWithin30Days <- ifelse(Visits_Readmissions$Diff <= 30, 1, 0)

#temp <- sqldf("select NRD_VisitLink, KEY_NRD, NRD_DaysToEvent, LOS, PseudoDDate, I10_DX1, I10_DX2, I10_DX3, IndexEvent from Core_HeartFailure_Sev_Hosp where NRD_VisitLink = 'd00306n' order by NRD_DaysToEvent")
#View(temp)

Core_HeartFailure_Sev_Hosp_Y <- Core_HeartFailure_Sev_Hosp[(Core_HeartFailure_Sev_Hosp$IndexEvent==1),]

Core_HeartFailure_Sev_Hosp_Y$ReadmittedWithin30Days <- 0

View(Core_HeartFailure_Sev_Hosp_Y)

#temp <- sqldf("select distinct(KEY_NRD) from Visits_Readmissions where ReadmittedWithin30Days = 1")
#View(temp)  86,933 records

Core_HeartFailure_Sev_Hosp_Y <- sqldf(c("Update Core_HeartFailure_Sev_Hosp_Y
                                      Set ReadmittedWithin30Days = 1
                                      where KEY_NRD in (select KEY_NRD from Visits_Readmissions where ReadmittedWithin30Days = 1)", "select * from Core_HeartFailure_Sev_Hosp_Y"))

#temp <- sqldf("select * from Core_HeartFailure_Sev_Hosp_Y where ReadmittedWithin30Days = 1")
#View(temp)

#Core_HeartFailure_Sev_Hosp_Y
#ReadmittedWithin30Days = 1      86,933
#ReadmittedWithin30Days = 0     314,183
#Total                          401,116

#write.csv(Visits_Readmissions, file = "~/Machine Learning/ML 1000 - Machine Learning in Business Context/Assignment 1 - due Feb 17 2019/dataset/NRD_2016/Visits_Readmissions.CSV")
#write.csv(Core_HeartFailure_Sev_Hosp_Y, file = "~/Machine Learning/ML 1000 - Machine Learning in Business Context/Assignment 1 - due Feb 17 2019/dataset/NRD_2016/Core_HeartFailure_Sev_Hosp_Y.CSV")

# use Core_HeartFailure_Sev_Hosp_Y for modelling
train <- Core_HeartFailure_Sev_Hosp_Y[1:200558,]
test <- Core_HeartFailure_Sev_Hosp_Y[200559:401116,]

table(train$ReadmittedWithin30Days)
prop.table(table(train$ReadmittedWithin30Days))

library(ROSE)

#over sampling
train_balanced_over <- ROSE::ovun.sample(ReadmittedWithin30Days ~ ., data = train, method = "over",N = 314696)$data
table(train_balanced_over$ReadmittedWithin30Days)

#under sampling
train_balanced_under <- ROSE::ovun.sample(ReadmittedWithin30Days ~ ., data = train, method = "under", N = 86420, seed = 1)$data
table(train_balanced_under$ReadmittedWithin30Days)

#both over sampling and under sampling
train_balanced_both <- ROSE::ovun.sample(ReadmittedWithin30Days ~ ., data = train, method = "both", p=0.5, N=200558, seed = 1)$data
table(train_balanced_both$ReadmittedWithin30Days)


set.seed(754)

library(randomForest)

summary(train$AGE)

rf_model <- randomForest(factor(ReadmittedWithin30Days) ~ AGE + AWEEKEND +  DISPUNIFORM + DMONTH  + DQTR + DRG + DRG_NoPOA + I10_DX1 + MDC + ELECTIVE +
                           FEMALE + LOS + RESIDENT+ HOSP_NRD.y + HOSP_BEDSIZE + HOSP_UR_TEACH+  PAY1 + PL_NCHS + ZIPINC_QRTL + SAMEDAYEVENT,
                         ntree=5, data = train)

rf_model_over <- randomForest(factor(ReadmittedWithin30Days) ~ AGE + AWEEKEND +  DISPUNIFORM + DMONTH  + DQTR + DRG + DRG_NoPOA + I10_DX1 + MDC + ELECTIVE +
                           FEMALE + LOS + RESIDENT+ HOSP_NRD.y + HOSP_BEDSIZE + HOSP_UR_TEACH+  PAY1 + PL_NCHS + ZIPINC_QRTL + SAMEDAYEVENT,
                         ntree=5, data = train_balanced_over)

rf_model_under <- randomForest(factor(ReadmittedWithin30Days) ~ AGE + AWEEKEND +  DISPUNIFORM + DMONTH  + DQTR + DRG + DRG_NoPOA + I10_DX1 + MDC + ELECTIVE +
                           FEMALE + LOS + RESIDENT+ HOSP_NRD.y + HOSP_BEDSIZE + HOSP_UR_TEACH+  PAY1 + PL_NCHS + ZIPINC_QRTL + SAMEDAYEVENT,
                         ntree=5, data = train_balanced_under)

rf_model_both <- randomForest(factor(ReadmittedWithin30Days) ~ AGE + AWEEKEND +  DISPUNIFORM + DMONTH  + DQTR + DRG + DRG_NoPOA + I10_DX1 + MDC + ELECTIVE +
                           FEMALE + LOS + RESIDENT+ HOSP_NRD.y + HOSP_BEDSIZE + HOSP_UR_TEACH+  PAY1 + PL_NCHS + ZIPINC_QRTL + SAMEDAYEVENT,
                         ntree=5, data = train_balanced_both)

#rf_model <- randomForest(factor(ReadmittedWithin30Days) ~ FEMALE + PL_NCHS + RESIDENT + ZIPINC_QRTL + HOSP_URCAT4,
#                         ntree=51, data = train)

rf_model
rf_model_over
rf_model_under
rf_model_both

# HOSP_NRD.y, AGE, DMONTH, LOS, I10_DX1
varImpPlot(rf_model,
           sort=T,
           n.var=10,
           main="Top 10 Var. Imp. - unbalanced test data")

prediction <- predict(rf_model, test)

solution <- data.frame(VisitID = test$KEY_NRD, ReadmittedWithin30Days = prediction)

View(solution)

temp <- sqldf("select Count(*) from test where ReadmittedWithin30Days = 1")
View(temp)  #43,723

temp1 <- sqldf("select Count(*) from solution where ReadmittedWithin30Days = 1")
View(temp1) #17,855

# HOSP_NRD.y, AGE, LOS, DMONTH, I10_DX1
varImpPlot(rf_model_over,
           sort=T,
           n.var=10,
           main="Top 10 Var. Imp. - balanced oversampled test data")

prediction_over <- predict(rf_model_over, test)

solution_over <- data.frame(VisitID = test$KEY_NRD, ReadmittedWithin30Days = prediction_over)

View(solution)

temp <- sqldf("select Count(*) from test where ReadmittedWithin30Days = 1")
View(temp)  #43,723

temp1 <- sqldf("select Count(*) from solution_over where ReadmittedWithin30Days = 1")
View(temp1) #39,820

# HOSP_NRD.y, AGE, LOS, DMONTH, I10_DX1
varImpPlot(rf_model_under,
           sort=T,
           n.var=10,
           main="Top 10 Var. Imp. - balanced undersampled test data")

prediction_under <- predict(rf_model_under, test)

solution_under <- data.frame(VisitID = test$KEY_NRD, ReadmittedWithin30Days = prediction_under)

View(solution_under)

temp <- sqldf("select Count(*) from test where ReadmittedWithin30Days = 1")
View(temp)  #43,723

temp1 <- sqldf("select Count(*) from solution_under where ReadmittedWithin30Days = 1")
View(temp1) #98,308

# HOSP_NRD.y, AGE, LOS, DMONTH, I10_DX1
varImpPlot(rf_model_both,
           sort=T,
           n.var=10,
           main="Top 10 Var. Imp. - balanced both over & under sampled test data")

prediction_both <- predict(rf_model_both, test)

solution_both <- data.frame(VisitID = test$KEY_NRD, ReadmittedWithin30Days = prediction_both)

View(solution_both)

temp <- sqldf("select Count(*) from test where ReadmittedWithin30Days = 1")
View(temp)  #43,723

temp1 <- sqldf("select Count(*) from solution_both where ReadmittedWithin30Days = 1")
View(temp1) #67,149



# Build the model (note: not all possible variables are used)
rf_model <- randomForest(factor(ReadmittedWithin30Days) ~ AGE + AWEEKEND +  DISPUNIFORM + DMONTH  + DQTR + DRG + DRG_NoPOA + I10_DX1 + MDC + ELECTIVE +
                           FEMALE + LOS + RESIDENT+ HOSP_NRD.y + HOSP_BEDSIZE + HOSP_UR_TEACH+  PAY1 + PL_NCHS + ZIPINC_QRTL + SAMEDAYEVENT,
                         data = train)
# Show model error
plot(rf_model, ylim=c(0,0.36))
legend('topright', colnames(rf_model$err.rate), col=1:3, fill=1:3)

prediction <- predict(rf_model, test) # Predict using the test set
ncol(test)
View(test)
actualTest = test[,ncol(test)] # actual outputs for test set
View(actualTest)
View(prediction)

confMatrixTest = table(prediction,actualTest) # compute confusion matrix
View(confMatrixTest)
confMatrixTest #show confusion matrix
diag(confMatrixTest)
sum(diag(confMatrixTest))
sum(confMatrixTest)
#compute accuracy
accuracyTest = sum(diag(confMatrixTest))/sum(confMatrixTest)
accuracyTest #show accuracy

library(caret)
#sensitivity
sensitivity(confMatrixTest)

#specificity
specificity(confMatrixTest)

#ROC
library(ROCR)

# List of predictions
#preds_list <- list(dt_preds, bag_preds, rf_preds, gbm_preds)
preds_list <- list(prediction)

# List of actual values (same for all)
m <- length(preds_list)
actuals_list <- rep(list(actualTest), m)

# Plot the ROC curves
#pred <- prediction(preds_list, actuals_list)
pred <- prediction(as.numeric(prediction_under), as.numeric(actualTest))
rocs <- performance(pred, "tpr", "fpr")
#plot(rocs, col = as.list(1:m), main = "Test Set ROC Curves")
plot(rocs, col = 1, main = "Test Set ROC Curves")
legend(x = "bottomright", 
       legend = c("Decision Tree", "Bagged Trees", "Random Forest", "GBM"),
       fill = 1:m)
