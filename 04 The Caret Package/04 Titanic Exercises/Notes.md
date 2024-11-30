# Titanic Exercises

### Motivation

The Titanic was a British ocean liner that struck an iceberg and sunk on its maiden voyage in 1912 from the United Kingdom to New York. More than 1,500 of the estimated 2,224 passengers and crew died in the accident, making this one of the largest maritime disasters ever outside of war. The ship carried a wide range of passengers of all ages and both genders, from luxury travelers in first-class to immigrants in the lower classes. However, not all passengers were equally likely to survive the accident. We will use real data about a selection of 891 passengers to predict which passengers survived.

### Instructions

Use the `titanic_train` data frame from the `titanic` library as the starting point for this project.

```
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
```


#### Question 1: Training and test sets

Split `titanic_clean` into test and training sets - after running the setup code, it should have 891 rows and 9 variables.

Set the seed to 42, then use the `caret` package to create a 20% data partition based on the `Survived` column. Assign the 20% partition to `test_set` and the remaining 80% partition to `train_set`.

How many observations are in the training set?

How many observations are in the test set?

What proportion of individuals in the training set survived?



####  Question 2: Baseline prediction by guessing the outcome

The simplest prediction method is randomly guessing the outcome without using additional predictors. These methods will help us determine whether our machine learning algorithm performs better than chance. How accurate are two methods of guessing Titanic passenger survival?

Set the seed to 3. For each individual in the test set, randomly guess whether that person survived or not by sampling from the vector `c(0,1)` (Note: use the default argument setting of `prob` from the `sample` function).

What is the accuracy of this guessing method?



####  Question 3a: Predicting survival by sex

Use the training set to determine whether members of a given sex were more likely to survive or die.

What proportion of training set females survived?

What proportion of training set males survived?



####  Question 3b: Predicting survival by sex

Predict survival using sex on the test set: if the survival rate for a sex is over 0.5, predict survival for all individuals of that sex, and predict death if the survival rate for a sex is under 0.5.

What is the accuracy of this sex-based prediction method on the test set?



#### Question 4a: Predicting survival by passenger class

n the training set, which class(es) (`Pclass`) were passengers more likely to survive than die? Note that "more likely to survive than die" (probability > 50%) is distinct from "equally likely to survive or die" (probability = 50%).



#### Question 4b: Predicting survival by passenger class

Predict survival using passenger class on the test set: predict survival if the survival rate for a class is over 0.5, otherwise predict death.

What is the accuracy of this class-based prediction method on the test set?



#### Question 4c: Predicting survival by passenger class 

Use the training set to group passengers by both sex and passenger class.

Which sex and class combinations were more likely to survive than die (i.e. >50% survival)?



####  Question 4d: Predicting survival by passenger class

Predict survival using both sex and passenger class on the test set. Predict survival if the survival rate for a sex/class combination is over 0.5, otherwise predict death.

What is the accuracy of this sex- and class-based prediction method on the test set?



####  Question 5a: Confusion matrix

Use the `confusionMatrix()` function to create confusion matrices for the sex model, class model, and combined sex and class model. You will need to convert predictions and survival status to factors to use this function.

What is the "positive" class used to calculate confusion matrix metrics?

Which model has the highest sensitivity?

Which model has the highest specificity?

Which model has the highest balanced accuracy?



#### Question 5b: Confusion matrix

What is the maximum value of balanced accuracy from Q5a?



#### Question 6: F1 scores

Use the `F_meas()` function to calculate scores for the sex model, class model, and combined sex and class model. You will need to convert predictions to factors to use this function.

Which model has the highest score?



####  Question 7: Survival by fare - Loess

Set the seed to 1. Train a model using Loess with the `caret` `gamLoess` method using fare as the only predictor.

What is the accuracy on the test set for the Loess model?

Note: Use the S3 method for class formula rather than the default S3 method of `caret` `train()`.



#### Question 8: Logistic regression models

Set the seed to 1. Train a logistic regression model with the `caret` `glm` method using age as the only predictor.

What is the accuracy of your model (using age as the only predictor) on the test set ?

Set the seed to 1. Train a logistic regression model with the `caret` `glm` method using four predictors: sex, class, fare, and age.

What is the accuracy of your model (using these four predictors) on the test set?

Set the seed to 1. Train a logistic regression model with the `caret` `glm` method using all predictors. Ignore warnings about rank-deficient fit.

What is the accuracy of your model (using all predictors) on the test set ?



#### Question 9a: kNN model

Set the seed to 6. Train a kNN model on the training set using the `caret` `train()` function. Try tuning with `k = seq(3, 51, 2)`.

What is the optimal value of the number of neighbors `k`?



#### Question 9b: kNN model

Plot the kNN model to investigate the relationship between the number of neighbors and accuracy on the training set.

Of these values of `k`, which yields the highest accuracy?



####  Question 9c: kNN model

What is the accuracy of the kNN model on the test set?



####  Question 10: Cross-validation

Set the seed to 8 and train a new kNN model. Instead of the default training control, use 10-fold cross-validation where each partition consists of 10% of the total. Try tuning with `k = seq(3, 51, 2)`.

What is the optimal value of k using cross-validation?

What is the accuracy on the test set using the cross-validated kNN model?



#### Question 11a: Classification tree model

Set the seed to 10. Use `caret` to train a decision tree with the `rpart` method. Tune the complexity parameter with cp = seq(0, 0.05, 0.002).

What is the optimal value of the complexity parameter (`cp`)?

What is the accuracy of the decision tree model on the test set?



#### Question 11b: Classification tree model

Inspect the final model and plot the decision tree.

Which variables are used in the decision tree?



####  Question 11c: Classification tree model

Using the decision rules generated by the final model, predict whether the following individuals would survive. Note that going down to the left node means yes.

A 28-year-old male
A female in the second passenger class
A third-class female who paid a fare of $8
A 5-year-old male with 4 siblings
A third-class female who paid a fare of $25
A first-class 17-year-old female with 2 siblings
A first-class 17-year-old male with 2 siblings



#### Question 12: Random forest model

Set the seed to 14. Use the `caret` `train()` function with the `rf` method to train a random forest. Test values of `mtry = seq(1:7)`. Set `ntree` to 100.

What mtry value maximizes accuracy?

What is the accuracy of the random forest model on the test set?
