# Load the necessary datasets
library(tidyverse) # For data manipulation and visualization
library(dslabs) # Contains the mnist_27 and polls_2008 datasets
library(rpart) # For creating decision trees
library(randomForest) # For creating random forests



#### 1. Fit and Visualize Decision Tree

# Fit a decision tree using the polls_2008 dataset,
# where the predictor is "day" and the outcome variable is "margin"
fit <- rpart(margin ~ ., data = polls_2008)

# Plot the decision tree structure and set the margin for text labels
plot(fit, margin = 0.1)

# Add text labels to the tree with smaller font size
text(fit, cex = 0.75)

# Examine the performance of the decision tree model on the polls_2008 dataset
# Create a new column "y_hat" to store the predicted values from the model
polls_2008 %>%  
  mutate(y_hat = predict(fit)) %>% 
  ggplot() +
  # Plot the actual data points (day vs margin)
  geom_point(aes(day, margin)) +
  # Add the decision tree predictions as a step plot (in red)
  geom_step(aes(day, y_hat), col="red")



#### 2. Tune Decision Tree with Cross-Validation

# Fit a classification tree model on the mnist_27 dataset using cross-validation
train_rpart <- train(y ~ .,
                     method = "rpart",
                     # Tune the model by adjusting the complexity parameter (cp)
                     tuneGrid = data.frame(cp = seq(0.0, 0.1, len = 25)),
                     data = mnist_27$train)

# Plot the resulting decision tree from the cross-validation model
plot(train_rpart)

# Calculate the accuracy of the model on the test data
confusionMatrix(predict(train_rpart, mnist_27$test), mnist_27$test$y)$overall["Accuracy"]

# View the final decision tree structure from the model with cross-validation
plot(train_rpart$finalModel, margin = 0.1) # Plot tree structure
text(train_rpart$finalModel) # Add text labels to the tree



#### 3. Train and Evaluate Random Forest

# Train a random forest model using the mnist_27 dataset
train_rf <- randomForest(y ~ ., data=mnist_27$train)

# Calculate the accuracy of the random forest model on the test data
confusionMatrix(predict(train_rf, mnist_27$test), mnist_27$test$y)$overall["Accuracy"]

# Use cross-validation to choose optimal hyperparameters for the random forest model
train_rf_2 <- train(y ~ .,
                    method = "Rborist", # Random forest method with bagging
                    tuneGrid = data.frame(predFixed = 2, minNode = c(3, 50)),
                    data = mnist_27$train)

# Calculate the accuracy of the tuned random forest model on the test data
confusionMatrix(predict(train_rf_2, mnist_27$test), mnist_27$test$y)$overall["Accuracy"]
