# Load necessary libraries
library(tidyverse)   # Data manipulation and visualization
library(caret)       # Machine learning functions
library(dslabs)      # Dataset with the MNIST data
library(purrr)       # For functional programming tools



#### 1. Set Range for k

# Define a sequence of values for k
ks <- seq(3, 251, 2)



#### 2. Compute Accuracies

# Calculate accuracy for each k value in the sequence
accuracy <- map_df(ks, function(k) {
  
  # Fit a kNN model to the training data with the specified k
  fit <- knn3(y ~ ., data = mnist_27$train, k = k)
  
  # Predict the training set using the fitted model
  y_hat <- predict(fit, mnist_27$train, type = "class")
  
  # Compute the confusion matrix for the training set predictions
  cm_train <- confusionMatrix(y_hat, mnist_27$train$y)
  
  # Extract the accuracy from the training set confusion matrix
  train_error <- cm_train$overall["Accuracy"]
  
  # Predict the test set using the same fitted model
  y_hat <- predict(fit, mnist_27$test, type = "class")
  
  # Compute the confusion matrix for the test set predictions
  cm_test <- confusionMatrix(y_hat, mnist_27$test$y)
  
  # Extract the accuracy from the test set confusion matrix
  test_error <- cm_test$overall["Accuracy"]
  
  # Return a tibble containing the training and test accuracies
  tibble(train = train_error, test = test_error)
})



#### 3. Visualize Performance

# Add the k values to the accuracy tibble and reshape data for plotting
accuracy %>%
  mutate(k = ks) %>% # Add the k values as a new column
  gather(set, accuracy, -k) %>% # Convert data from wide to long format
  mutate(set = factor(set, levels = c("train", "test"))) %>% # Reorder factor levels
  ggplot(aes(k, accuracy, color = set)) + # Create a ggplot with k on x-axis and accuracy on y-axis
  geom_line() + # Add lines connecting points
  geom_point() # Add points to indicate exact accuracy values



#### 4. Identify Optimal k

# Identify the k value that gives the highest test set accuracy
ks[which.max(accuracy$test)]

# Find the maximum test set accuracy
max(accuracy$test)
