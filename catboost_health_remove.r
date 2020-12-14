### import packages
# package management
# if(!require(installr)){install.packages(installr)}
#install.packages("deepboost")
# data manipulation
# library(tidyverse)
library(data.table)
library(tidyr)
library(dplyr)
library(readr)
library(tree)
library(rpart)
# modeling 
library(ranger)
# library(tuneRanger)
library(mlr)
library(xgboost)
library(caret)
library(MLmetrics)
library(class)
library(deepboost)
library(catboost)
library("devtools")
install.packages('devtools')
#devtools::install_github('catboost/catboost', subdir = 'catboost/R-package')
library(catboost)

### main process
## import data
dat <- read_csv('C:/Users/Administrator/Desktop/consult/final/data/remove1.csv')
#hea = read_csv('D:/consult_final/health.csv')
## data pre-processing
# check unique values of all columns
lapply(dat, unique)

# transform cat-var to factor
dat <- 
  dat %>%
  # drop 'Person ID'
  select(-`Person ID`) %>% 
  select(-`Approximated Social Grade`) %>% 
  
  mutate_all(as.numeric) %>% 
  # replace all ' ' in column names to '_'
  rename_all(~ gsub(" ", "_", .)) %>% 
  as.data.frame

# check column type
sapply(dat, class)

## modeling
models <- list()




#-----------------------------
set.seed(1)
train_size <- sample(1:445639,400000)
test_size <- -train_size
data_train <- dat[train_size,]
data_test = dat[-train_size,]
heal_train = data_train$Health
heal_test = data_test$Health
data_test_re  = data_test[,-10]
data_train_re = data_train[,-10]
dim(data_test_re)




####
#column_description_vector = rep('numeric', 15)
cat_features <- c(1,2,3,4,5)

pool <- catboost.load_pool(as.matrix(data_train_re),
                           label = as.matrix(heal_train),
                           cat_features = cat_features)
head(pool,1)
