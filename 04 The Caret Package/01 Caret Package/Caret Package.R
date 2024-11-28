#### 1. Load Libraries & Data

# Load necessary libraries
library(tidyverse)  # For data manipulation and visualization
library(dslabs)     # For accessing the mnist_27 dataset
data("mnist_27")    # Load the mnist_27 dataset

# Load the caret package for model training and cross-validation
library(caret)



#### 2. Train Models

# Train a generalized linear model (glm) using training data from mnist_27
train_glm <- train(y ~ ., method = "glm", data = mnist_27$train)

# Train a k-nearest neighbors (knn) model using training data from mnist_27
train_knn <- train(y ~ ., method = "knn", data = mnist_27$train)



#### 3. Make Predictions

# Make predictions using the trained glm model on the test data
y_hat_glm <- predict(train_glm, mnist_27$test, type = "raw")

# Make predictions using the trained knn model on the test data
y_hat_knn <- predict(train_knn, mnist_27$test, type = "raw")

# Compute and print the accuracy of the glm model using confusion matrix
confusionMatrix(y_hat_glm, mnist_27$test$y)$overall[["Accuracy"]]

# Compute and print the accuracy of the knn model using confusion matrix
confusionMatrix(y_hat_knn, mnist_27$test$y)$overall[["Accuracy"]]



#### 4. Explore Models

# Get information about the knn model from caret
getModelInfo("knn")

# Lookup the model details for knn in caret
modelLookup("knn")

# Visualize the k-nearest neighbors (knn) model's results using ggplot
ggplot(train_knn, highlight = TRUE)



#### 5. Tune kNN

# Create a data frame specifying a range of k values for k-nearest neighbors tuning
data.frame(k = seq(9, 67, 2))

# Set the random seed for reproducibility
set.seed(2008)

# Retrain the knn model, tuning for different k values from 9 to 71
train_knn <- train(y ~ ., method = "knn",
                   data = mnist_27$train,
                   tuneGrid = data.frame(k = seq(9, 71, 2)))

# Visualize the tuned knn model’s results using ggplot
ggplot(train_knn, highlight = TRUE)

# Retrieve and print the best tuning parameter (k) for the knn model
train_knn$bestTune

# Retrieve and print the final trained knn model
train_knn$finalModel

# Compute and print the accuracy of the tuned knn model on the test data
confusionMatrix(predict(train_knn, mnist_27$test, type = "raw"),
                mnist_27$test$y)$overall["Accuracy"]



#### 6. Cross-Validation

# Set up cross-validation with 10 folds and 90% of data for training
control <- trainControl(method = "cv", number = 10, p = .9)

# Retrain the knn model with cross-validation and the specified tuning grid
train_knn_cv <- train(y ~ ., method = "knn",
                      data = mnist_27$train,
                      tuneGrid = data.frame(k = seq(9, 71, 2)),
                      trControl = control)

# Visualize the cross-validated knn model’s results using ggplot
ggplot(train_knn_cv, highlight = TRUE)

# View the results of cross-validation, including the accuracy for different k values
train_knn_cv$results



#### 7. Plot Probabilities

# Define a function to plot conditional probability, with an optional argument for predicted probabilities
plot_cond_prob <- function(p_hat=NULL){
  tmp <- mnist_27$true_p
  if(!is.null(p_hat)){
    tmp <- mutate(tmp, p=p_hat)  # Add predicted probabilities to the data
  }
  tmp %>% ggplot(aes(x_1, x_2, z=p, fill=p)) +  # Create a plot with x_1 and x_2 as axes, and p as fill color
    geom_raster(show.legend = FALSE) +  # Plot the raster without the legend
    scale_fill_gradientn(colors=c("#F8766D","white","#00BFC4")) +  # Set gradient color scale
    stat_contour(breaks=c(0.5),color="black")  # Add contour lines at probability = 0.5
}

# Plot the conditional probability from the trained knn model using the true data points
plot_cond_prob(predict(train_knn, mnist_27$true_p, type = "prob")[,2])
