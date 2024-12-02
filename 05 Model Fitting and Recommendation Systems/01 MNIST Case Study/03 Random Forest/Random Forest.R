# Load the randomForest library for Random Forest models
library(randomForest)



#### 1. Set hyperparameters and train model

# Define 5-fold cross-validation settings
control <- trainControl(method = "cv", number = 5)

# Create a grid of mtry values to test (number of predictors randomly sampled at each split)
grid <- data.frame(mtry = c(1, 5, 10, 25, 50, 100))

# Train a Random Forest model using the caret package
train_rf <- train(x[, col_index], y,    # Training data and target variable
                  method = "rf",        # Specify the Random Forest algorithm
                  nTree = 150,          # Use 150 trees in the Random Forest
                  trControl = control,  # Use the cross-validation control settings
                  tuneGrid = grid,      # Test multiple mtry values from the grid
                  nSamp = 5000)         # Randomly sample 5,000 observations per tree for efficiency

# Fit a Random Forest model using the best mtry value found during training
fit_rf <- randomForest(x[, col_index], y,                # Training data and target variable
                       mtry = train_rf$bestTune$mtry)    # Set mtry to the optimal value determined during training



#### 2. Obtain predictions for test data and compute accuracy

# Predict class labels for the test set using the trained Random Forest model
y_hat_rf <- predict(fit_rf, x_test[, col_index])

# Compute the confusion matrix to evaluate predictions
cm <- confusionMatrix(y_hat_rf, y_test)

# Extract and display the overall accuracy from the confusion matrix
cm$overall["Accuracy"]
