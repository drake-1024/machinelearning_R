# Load necessary libraries
library(tidyverse)   # Data manipulation and visualization
library(caret)       # Machine learning functions
library(dslabs)      # Dataset with the MNIST data
library(gridExtra)   # To arrange multiple plots in a grid

# Load the mnist_27 dataset (a subset of MNIST for binary classification: 2 vs. 7)
data("mnist_27")

# Plot the first two features (x_1 and x_2) of the test dataset with color-coded labels (y)
mnist_27$test %>%
  ggplot(aes(x_1, x_2, color = y)) +  # Plot x_1 vs x_2 with color according to the label y
  geom_point()  # Add points to the plot

# Fit a k-nearest neighbors (kNN) model using all predictors (x_1, x_2) to predict y
knn_fit <- knn3(y ~ ., data = mnist_27$train)

# Use the fitted kNN model to predict the class labels for the test data and calculate accuracy
y_hat_knn <- predict(knn_fit, mnist_27$test, type = "class")
confusionMatrix(y_hat_knn, mnist_27$test$y)$overall["Accuracy"]  # Get the accuracy of the kNN model on the test set

# Fit a logistic regression model (as a baseline) by converting the target variable to binary (7 = 1, else = 0)
fit_lm <- mnist_27$train %>% 
  mutate(y = ifelse(y == 7, 1, 0)) %>%  # Recode target variable (7 as 1, others as 0)
  lm(y ~ x_1 + x_2, data = .)  # Fit logistic regression model using x_1 and x_2 as predictors

# Use the fitted logistic regression model to predict the probabilities on the test set
p_hat_lm <- predict(fit_lm, mnist_27$test)

# Convert the continuous predictions to binary predictions (7 as 7, others as 2) and evaluate accuracy
y_hat_lm <- factor(ifelse(p_hat_lm > 0.5, 7, 2))  # Threshold at 0.5 to classify as 7 or 2
confusionMatrix(y_hat_lm, mnist_27$test$y)$overall["Accuracy"]  # Get the accuracy of the logistic regression model on the test set

# Define a function to plot the conditional probability map
plot_cond_prob <- function(p_hat=NULL){
  tmp <- mnist_27$true_p  # Get the true conditional probability data
  if(!is.null(p_hat)){
    tmp <- mutate(tmp, p=p_hat)  # If predictions are provided, add them as a new column
  }
  # Plot the conditional probability map with colors corresponding to p values
  tmp %>% ggplot(aes(x_1, x_2, z=p, fill=p)) +
    geom_raster(show.legend = FALSE) +  # Create a raster plot without showing the legend
    scale_fill_gradientn(colors=c("#F8766D", "white", "#00BFC4")) +  # Customize color gradient
    stat_contour(breaks=c(0.5), color="black")  # Add contour lines at p=0.5 to separate classes
}

# Plot the true conditional probability map
p1 <- plot_cond_prob() +
  ggtitle("True conditional probability")

# Plot the kNN estimated conditional probability map
p2 <- plot_cond_prob(predict(knn_fit, mnist_27$true_p)[,2]) +
  ggtitle("kNN-5 estimate")

# Arrange the two plots side by side for comparison
grid.arrange(p2, p1, nrow=1)

# Predict on the training set using the fitted kNN model and calculate accuracy
y_hat_knn <- predict(knn_fit, mnist_27$train, type = "class")
confusionMatrix(y_hat_knn, mnist_27$train$y)$overall["Accuracy"]  # Get the accuracy on the training set

# Predict on the test set using the fitted kNN model and calculate accuracy
y_hat_knn <- predict(knn_fit, mnist_27$test, type = "class")
confusionMatrix(y_hat_knn, mnist_27$test$y)$overall["Accuracy"]  # Get the accuracy on the test set
