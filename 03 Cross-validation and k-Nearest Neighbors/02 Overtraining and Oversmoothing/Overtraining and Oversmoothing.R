# Load necessary libraries
library(tidyverse)   # Data manipulation and visualization
library(caret)       # Machine learning functions
library(dslabs)      # Dataset with the MNIST data
library(gridExtra)   # To arrange multiple plots in a grid



#### 1. Fit k-NN Model (k = 1)

# Fit a k-NN model with k = 1 using the training data
knn_fit_1 <- knn3(y ~ ., data = mnist_27$train, k = 1)

# Predict the class labels for the training data using the k-NN model
y_hat_knn_1 <- predict(knn_fit_1, mnist_27$train, type = "class")

# Calculate and display the accuracy of the k-NN model on the training data
confusionMatrix(y_hat_knn_1, mnist_27$train$y)$overall["Accuracy"]

# Predict the class labels for the test data using the k-NN model
y_hat_knn_1 <- predict(knn_fit_1, mnist_27$test, type = "class")

# Calculate and display the accuracy of the k-NN model on the test data
confusionMatrix(y_hat_knn_1, mnist_27$test$y)$overall["Accuracy"]



#### 2. Visualize Conditional Probability for k-NN (k = 1)

# Create a plot for the training set with contour lines representing the predicted probabilities from the k-NN model (k = 1)
p1 <- mnist_27$true_p %>% 
  mutate(knn = predict(knn_fit_1, newdata = .)[,2]) %>%
  ggplot() +
  geom_point(data = mnist_27$train, aes(x_1, x_2, color= y), pch=21) +  # Plot the training set points
  scale_fill_gradientn(colors=c("#F8766D", "white", "#00BFC4")) +  # Set color gradient for the contour plot
  stat_contour(aes(x_1, x_2, z = knn), breaks=c(0.5), color="black") +  # Add contour lines at z = 0.5
  ggtitle("Train set")  # Title for the plot

# Create a plot for the test set with contour lines representing the predicted probabilities from the k-NN model (k = 1)
p2 <- mnist_27$true_p %>% 
  mutate(knn = predict(knn_fit_1, newdata = .)[,2]) %>%
  ggplot() +
  geom_point(data = mnist_27$test, aes(x_1, x_2, color= y), 
             pch=21, show.legend = FALSE) +  # Plot the test set points
  scale_fill_gradientn(colors=c("#F8766D", "white", "#00BFC4")) +  # Set color gradient for the contour plot
  stat_contour(aes(x_1, x_2, z = knn), breaks=c(0.5), color="black") +  # Add contour lines at z = 0.5
  ggtitle("Test set")  # Title for the plot

# Arrange the training and test set plots side by side
grid.arrange(p1, p2, nrow=1)



#### 3. Fit k-NN Model (k = 401)

# Fit a k-NN model with k = 401 using the training data
knn_fit_401 <- knn3(y ~ ., data = mnist_27$train, k = 401)

# Predict the class labels for the test data using the k-NN model (k = 401)
y_hat_knn_401 <- predict(knn_fit_401, mnist_27$test, type = "class")

# Calculate and display the accuracy of the k-NN model with k = 401 on the test data
confusionMatrix(y_hat_knn_401, mnist_27$test$y)$overall["Accuracy"]



#### 4. Fit Logistic Regression Model

# Fit a logistic regression model using the training data
fit_glm <- glm(y ~ x_1 + x_2, data=mnist_27$train, family="binomial")



#### 5. Compare Models

# Plot the conditional probability estimates for the logistic regression model
p1 <- plot_cond_prob(predict(fit_glm, mnist_27$true_p)) +
  ggtitle("Regression")

# Plot the conditional probability estimates for the k-NN model (k = 401)
p2 <- plot_cond_prob(predict(knn_fit_401, mnist_27$true_p)[,2]) +
  ggtitle("kNN-401")

# Arrange the regression and k-NN plots side by side for comparison
grid.arrange(p1, p2, nrow=1)
