# Titanic Exercise

#Q1

library(titanic)    # loads titanic_train data frame
library(caret)
library(tidyverse)
library(rpart)

# 3 significant digits
options(digits = 3)

# clean the data - `titanic_train` is loaded with the titanic package
titanic_clean <- titanic_train %>%
  mutate(Survived = factor(Survived),
         Embarked = factor(Embarked),
         Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age), # NA age to median age
         FamilySize = SibSp + Parch + 1) %>%    # count family members
  select(Survived,  Sex, Pclass, Age, Fare, SibSp, Parch, FamilySize, Embarked)

set.seed(42)
test_index <- createDataPartition(titanic_clean$Survived, times = 1, p = 0.2, list = FALSE)
test_set <- titanic_clean[test_index,]
train_set <- titanic_clean[-test_index,]

nrow(train_set)
# 712
nrow(test_set)
# 179
mean(titanic_clean$Survived == "1")
# 0.384



# Q2

set.seed(3)

guess <- sample(c(0,1), nrow(test_set), replace = TRUE)
mean(guess == test_set$Survived)
# 0.542



# Q3a

library(dplyr)

train_set %>% group_by(Sex) %>% summarise(survival_rate = mean(Survived == 1))
# Female 0.733
# Male 0.193



# Q3b

sex_model <- ifelse(test_set$Sex == "female", 1, 0)
mean(sex_model == test_set$Survived)
# 0.81



# Q4a

train_set %>% group_by(Pclass) %>% summarise(survival_rate = mean(Survived == 1)) 
# 1 is more likely to survive



# Q4b

class_model <- ifelse(test_set$Pclass == 1, 1, 0)
mean(class_model == test_set$Survived)
# 0.682



# Q4c

train_set %>% group_by(Sex, Pclass) %>% summarise(survival_rate = mean(Survived == 1)) 
# female 1 & female 2 are more likely to survive



# Q4d

sex_class_model <- ifelse(test_set$Pclass != 3 & test_set$Sex == "female", 1, 0)
mean(sex_class_model == test_set$Survived)
# 0.793



# Q5a

confusionMatrix(factor(sex_model), test_set$Survived)
confusionMatrix(factor(class_model), test_set$Survived)
confusionMatrix(factor(sex_class_model), test_set$Survived)
# 'Positive' Class = "0"
# sex_class_model has the highest sensitivity
# sex_model has the highest specificity
# sex_model has the highest balanced accuracy


# Q5b

confusionMatrix(factor(sex_model), test_set$Survived)$byClass["Balanced Accuracy"]
# 0.791



# Q6

F_meas(factor(sex_model), test_set$Survived)
F_meas(factor(class_model), test_set$Survived)
F_meas(factor(sex_class_model), test_set$Survived)

# sex_class_model has the highest F1 Score
#0.855



# Q7

set.seed(1)

train_loess <- train(Survived ~ Fare, method = "gamLoess", data = train_set)
loess_preds <- predict(train_loess, test_set)
mean(loess_preds == test_set$Survived)
# 0.665


# Q8

set.seed(1)

train_glm_age <- train(Survived ~ Age, method = "glm", data = train_set)
glm_age_preds <- predict(train_glm_age, test_set)
mean(glm_age_preds == test_set$Survived)
# 0.615


set.seed(1)

train_glm_4 <- train(Survived ~ Sex + Pclass + Fare + Age, method = "glm", data = train_set)
glm_4_preds <- predict(train_glm_4, test_set)
mean(glm_4_preds == test_set$Survived)
# 0.821


set.seed(1)

train_glm_all <- train(Survived ~ ., method = "glm", data = train_set)
glm_all_preds <- predict(train_glm_all, test_set)
mean(glm_all_preds == test_set$Survived)
# 0.827



# Q9a

set.seed(6)

train_knn <- train(Survived ~ .,
                   method = "knn",
                   data = train_set,
                   tuneGrid = data.frame(k = seq(3, 51, 2)))
train_knn$bestTune
# k = 15



# Q9b

ggplot(train_knn)
# k = 15



# Q9c

knn_preds <- predict(train_knn, test_set)
mean(knn_preds == test_set$Survived)
# 0.732



k = seq(3, 51, 2)



# Q10

set.seed(8)

control <- trainControl(method = "cv", number = 10, p = 0.9)

train_knn_cv <- train(Survived ~ .,
                   method = "knn",
                   data = train_set,
                   tuneGrid = data.frame(k = seq(3, 51, 2)),
                   trControl = control)
train_knn_cv$bestTune
# k = 23

knn_cv_preds <- predict(train_knn_cv, test_set)
mean(knn_cv_preds == test_set$Survived)
# 0.737



# Q11a

set.seed(10)

train_rpart <- train(Survived ~ .,
                     method = "rpart",
                     # Tune the model by adjusting the complexity parameter (cp)
                     tuneGrid = data.frame(cp = seq(0, 0.05, 0.002)),
                     data = train_set)
# 0.02

rpart_preds <- predict(train_rpart, test_set)
mean(rpart_preds == test_set$Survived)
# 0.849



# Q11b

plot(train_rpart$finalModel, margin = 0.1) # Plot tree structure
text(train_rpart$finalModel) # Add text labels to the tree
# Sex, Age, Pclass, Fare, (and SibSp)



# Q11c

# A 28-year-old male would NOT survive
# A female in second passenger class would survive
# A third-class female who paid a fare of $8 would survive
# A 5-year-old male with 4 siblings would NOT survive
# A third-class female who paid a fare of $25 would NOT survive
# A first-class 17-year-old female with 2 siblings would survive
# A first-class 17-year-old male with 2 siblings would NOT survive



# Q12

set.seed(14)

train_rf <- train(Survived ~ .,
                     method = "rf",
                     # Tune the model by adjusting the complexity parameter (cp)
                     tuneGrid = data.frame(mtry = seq(1:7)),
                     data = train_set,
                     ntree = 100)
train_rf$bestTune

rf_preds <- predict(train_rf, test_set)
mean(rf_preds == test_set$Survived)
# 0.883
