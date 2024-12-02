#### 1. Compute class probabilities for Random Forest model

# Predict class probabilities for the test data using the Random Forest model
p_rf <- predict(fit_rf, x_test[,col_index], type = "prob")

# Normalize the Random Forest probabilities to ensure they sum to 1 for each observation
p_rf <- p_rf / rowSums(p_rf)



#### 2. Compute class probabilities for k-Nearest Neighbors model

# Predict class probabilities for the test data using the kNN model
p_knn <- predict(fit_knn, x_test[,col_index])



#### 3. Compute average of class probabilities

# Average the predicted probabilities from both Random Forest and kNN models
p <- (p_rf + p_knn)/2



#### 4. Compute accuracy of predictions

# Determine the final predicted class by taking the maximum probability for each observation
# The -1 adjustment ensures the class labels align correctly with the output (e.g., starting at 0)
y_pred <- factor(apply(p, 1, which.max)-1)

# Compute and extract the overall accuracy of the combined model predictions
confusionMatrix(y_pred, y_test)$overall["Accuracy"]
