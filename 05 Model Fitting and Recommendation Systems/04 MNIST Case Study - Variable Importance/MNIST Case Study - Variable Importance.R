#### 1. Extract Feature Importance

# Extract the importance scores of features from the trained Random Forest model
imp <- importance(fit_rf)  



#### 2. Visualize Importance

# Initialize a zero vector to store feature importance for all columns
mat <- rep(0, ncol(x))

# Assign the importance scores to the relevant columns (used features)
mat[col_index] <- imp

# Visualize feature importance as a 28x28 grid (original MNIST dimensions)
image(matrix(mat, 28, 28))



#### 3. Predict Probabilities

# Predict probabilities for each class on the test data using the Random Forest model
p_max <- predict(fit_rf, x_test[,col_index], type = "prob")

# Normalize the probabilities to ensure they sum to 1 for each observation
p_max <- p_max / rowSums(p_max)

# Extract the maximum probability for each prediction
p_max <- apply(p_max, 1, max)



#### 4. Analyze Misclassifications

# Identify indices of misclassified test samples
ind  <- which(y_hat_rf != y_test)

# Order misclassified samples by their prediction confidence
ind <- ind[order(p_max[ind], decreasing = TRUE)]



#### 5. Visualize Misclassified Samples

# Set up a plotting layout with 1 row and 4 columns
for (i in ind[1:4]) {  # Loop over the top 4 misclassified samples with the lowest confidence
  image(
    matrix(x_test[i,], 28, 28)[, 28:1],  # Display the 28x28 image of the sample, flipped vertically
    main = paste0(
      "Pr(", y_hat_rf[i], ")=", round(p_max[i], 2),  # Display predicted class and confidence
      " but is a ", y_test[i]  # Display the true class
    ),
    xaxt = "n", yaxt = "n"  # Suppress axis ticks for a cleaner visualization
  )
}
