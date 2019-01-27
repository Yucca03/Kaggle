library(randomForest) 
library(caret)
library(rpart)
train = read.csv("C:/Users/yolin/Desktop/DM/團體/train.csv", header = T, sep = ",")
test = read.csv("C:/Users/yolin/Desktop/DM/團體/test.csv", header = T, sep = ",")
names(all)
#########data cleaning############
all = rbind(train[,2:80],test[,2:80])
#有NA的column
lapply(all, function(x) sum(is.na(x)))
#LotFrontage
mean(all$LotFrontage,na.rm = T)#70
all$LotFrontage[is.na(all$LotFrontage)] = 70
#remove Alley ,NA too much
all = all[,-6, drop = F]
#MasVnrTyp
table(all$MasVnrTyp)#None
all$MasVnrTyp[is.na(all$MasVnrTyp)] = "None" #na to none
#MasVnrArea
mean(all$MasVnrArea,na.rm = T)#104
all$MasVnrArea[is.na(all$MasVnrArea)] = 104
#BsmtQual
table(all$BsmtQual)#TA
all$BsmtQual[is.na(all$BsmtQual)] = "TA"
#BsmtCond
table(all$BsmtCond)#TA
all$BsmtCond[is.na(all$BsmtCond)] = "TA"
#BsmtExposure
table(all$BsmtExposure)#No
all$BsmtExposure[is.na(all$BsmtExposure)] = "No"
#BsmtFinType1
table(all$BsmtFinType1)#GLQ
all$BsmtFinType1[is.na(all$BsmtFinType1)] = "GLQ"
#BsmtFinType2
table(all$BsmtFinType2)#Unf
all$BsmtFinType2[is.na(all$BsmtFinType2)] = "Unf"
#Electrical
table(all$Electrical)#SBrkr
all$Electrical[is.na(all$Electrical)] = "SBrkr"
#FireplaceQu
all = all[,-56, drop = F]
names(all)
#GarageType
table(all$GarageType)#Attchd
all$GarageType[is.na(all$GarageType)] = "Attchd"
#GarageYrBlt
mean(all$GarageYrBlt,na.rm = T)#1979
all$GarageYrBlt[is.na(all$GarageYrBlt)] = 1979
#GarageFinish
table(all$GarageFinish)#Unf
all$GarageFinish[is.na(all$GarageFinish)] = "Unf"
#GarageQual
table(all$GarageQual)#TA
all$GarageQual[is.na(all$GarageQual)] = "TA"
#GarageCond
table(all$GarageCond)#TA
all$GarageCond[is.na(all$GarageCond)] = "TA"
#remove PoolQC
names(all)
all = all[,-70, drop = F]
#remove Fence
all = all[,-70, drop = F]
#remove MiscFeature
all = all[,-70, drop = F]
#MSZoning
table(all$MSZoning)#RL
all$MSZoning[is.na(all$MSZoning)] = "RL"
#Utilities
table(all$Utilities)#AllPub
all$Utilities[is.na(all$Utilities)] = "AllPub"
#Exterior1st
table(all$Exterior1st)#Stone
all$Exterior1st[is.na(all$Exterior1st)] = "MetalSd"
#Exterior2nd
table(all$Exterior2nd)#VinylSd
all$Exterior2nd[is.na(all$Exterior2nd)] = "VinylSd"
#BsmtFinSF1
mean(all$BsmtFinSF1,na.rm = T)#441
all$BsmtFinSF1[is.na(all$BsmtFinSF1)] = 441
#BsmtFinSF2
mean(all$BsmtFinSF2,na.rm = T)#50
all$BsmtFinSF2[is.na(all$BsmtFinSF2)] = 50
#BsmtUnfSF
mean(all$BsmtUnfSF,na.rm = T)#561
all$BsmtUnfSF[is.na(all$BsmtUnfSF)] = 561
#TotalBsmtSF
mean(all$TotalBsmtSF,na.rm = T)#1052
all$TotalBsmtSF[is.na(all$TotalBsmtSF)] = 1052
#BsmtFullBath
table(all$BsmtFullBath)#0
all$BsmtFullBath[is.na(all$BsmtFullBath)] = 0
#BsmtHalfBath
table(all$BsmtHalfBath)#0
all$BsmtHalfBath[is.na(all$BsmtHalfBath)] = 0
#KitchenQual
table(all$KitchenQual)#TA
all$KitchenQual[is.na(all$KitchenQual)] = "TA"
#Functional
table(all$Functional)#Gd
all$Functional[is.na(all$Functional)] = "Typ"
#GarageCars
mean(all$GarageCars,na.rm = T)#2
all$GarageCars[is.na(all$GarageCars)] = 2
#GarageArea
mean(all$GarageArea,na.rm = T)#473
all$GarageArea[is.na(all$GarageArea)] = 473
#SaleType
table(all$SaleType)#WD
all$SaleType[is.na(all$SaleType)] = "WD"
#MasVnrType
table(all$MasVnrType)
all$MasVnrType[is.na(all$MasVnrType)] = "None"

#separate data
train_clean = all[1:1460,]
train_clean = cbind(train_clean,(train[,1]))
colnames(train_clean)[76] = "Id"
train_clean = cbind(train_clean,(train[,81]))
colnames(train_clean)[77] = "SalePrice"
test_clean = all[1461:2919,]
test_clean = cbind(test_clean,(test[,1]))
colnames(test_clean)[76] = "Id"
######################
#linear model
hp_lm = lm(SalePrice ~., train_clean)
predict.lm = predict(hp_lm, newdata = test_clean)
submission_lm = write.csv(data.frame(Id = c(1461:2919), SalePrice = predict.lm),
          file = "submission_lm.csv" ,row.names = FALSE)
caret::varImp(hp_lm)

#lm with interaction
hp_lm_in = lm(SalePrice ~(OverallQual + Neighborhood + GrLivArea + GarageCars + ExterQual)^2, train_clean)
predict.lm.in = predict(hp_lm_in, newdata = test_clean)
submission_lm_in = write.csv(data.frame(Id = c(1461:2919), SalePrice = predict.lm.in),
                          file = "submission_lm_in.csv" ,row.names = FALSE)
caret::varImp(hp_lm)

#rf
hp_rf = randomForest(SalePrice ~ .,train_clean,ntree=500)
predict.rf = predict(hp_rf, newdata = test_clean)
submission_rf = write.csv(data.frame(Id = c(1461:2919), SalePrice = predict.rf),
                          file = "submission_rf.csv" ,row.names = FALSE)
varImpPlot(hp_rf)

#rf 5 attributes
hp_rf5 = randomForest(SalePrice ~ OverallQual + Neighborhood + GrLivArea + GarageCars + ExterQual,
                     train_clean,ntree=500)
predict.rf5 = predict(hp_rf5, newdata = test_clean)
submission_rf5 = write.csv(data.frame(Id = c(1461:2919), SalePrice = predict.rf5),
                           file = "submission_rf5.csv" ,row.names = FALSE)

#rf 10 attributes
hp_rf10 = randomForest(SalePrice ~ OverallQual + Neighborhood + GrLivArea + GarageCars + ExterQual + 
                        TotalBsmtSF + X1stFlrSF + GarageArea + KitchenQual + BsmtFinSF1,
                      train_clean,ntree=500)
predict.rf10 = predict(hp_rf10, newdata = test_clean)
submission_rf5 = write.csv(data.frame(Id = c(1461:2919), SalePrice = predict.rf10),
                           file = "submission_rf10.csv" ,row.names = FALSE)

#bagging 
heart_BT = randomForest(SalePrice ~ ., 
                        train_clean, mtry = (ncol(train_clean) - 1))
predict.BT = predict(heart_BT, newdata = test_clean)
write.csv(data.frame(Id = c(1461:2919), SalePrice = predict.BT),file = "submission_BT.csv" ,
          row.names = FALSE)

#svm
library(e1071)
hp_svm = svm(SalePrice ~ OverallQual + Neighborhood + GrLivArea ,train_clean)
predict.svm = predict(hp_svm,test_clean)
write.csv(data.frame(Id = c(1461:2919), SalePrice = predict.svm),
          file = "submission_svm.csv" ,row.names = FALSE)

#decision tree
hp_rt = rpart(SalePrice ~ ., 
              train_clean, control = rpart.control(xval = 10), cp = 0)
predict.rt = predict(hp_rt,test_clean)
write.csv(data.frame(Id = c(1461:2919), SalePrice = predict.rt),
          file = "submission_rt.csv" ,row.names = FALSE)


