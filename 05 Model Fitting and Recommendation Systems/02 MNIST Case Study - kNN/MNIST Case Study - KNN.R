#### 1. Assign column names to training and test data

# Assign column names to the training data matrix
colnames(x) <- 1:ncol(mnist$train$images)

# Assign the same column names to the test data matrix
colnames(x_test) <- colnames(x)



#### 2. Train model on a subset of training data to estimate computational time on all training data

# Set parameters for a smaller subset of training
# Adjust parameters to get a sense of computational times
n <- 1000  # Number of rows to sample from the training data
b <- 2    # Number of folds for cross-validation

# Randomly sample n rows from the training data
index <- sample(nrow(x), n)

# Create new control parameters for cross-validation with 2 folds
control <- trainControl(method = "cv", number = b, p = .9)

# Train another kNN model using the smaller subset of data
train_knn <- train(x[index, col_index], y[index],
                   method = "knn",
                   tuneGrid = data.frame(k = c(3, 5, 7)),
                   trControl = control)

# Create control parameters for cross-validation:
# - Use 10-fold cross-validation (cv)
# - 90% of data will be used in each training fold (p = 0.9)
control <- trainControl(method = "cv", number = 10, p = .9)

# Train a k-Nearest Neighbors (kNN) model using the training data
train_knn <- train(x[, col_index], y,
                   method = "knn", 
                   tuneGrid = data.frame(k = c(3, 5, 7)),
                   trControl = control)

# Identify optimal k
# k = 3



#### 3. Train model using all training data and compute accuracy

# Fit a kNN model with k = 3 using all training data
fit_knn <- knn3(x[, col_index], y, k = 3)

# Predict the class labels for the test data using the fitted kNN model
y_hat_knn <- predict(fit_knn,
                     x_test[, col_index],
                     type = "class")

# Compute the confusion matrix to evaluate the predictions
cm <- confusionMatrix(y_hat_knn, factor(y_test))

# Extract the overall accuracy from the confusion matrix
cm$overall["Accuracy"]

# Extract sensitivity (recall) and specificity for each class
cm$byClass[, 1:2]
