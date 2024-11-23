# Generate a sequence of cutoff values from 61 to 70
cutoff <- 61:70

# Compute the F_1 score for each cutoff value
F_1 <- map_dbl(cutoff, function(x) {
  # Predict "Male" if height > cutoff, otherwise predict "Female"
  y_hat <- ifelse(train_set$height > x, "Male", "Female") %>% 
    factor(levels = levels(test_set$sex)) # Convert predictions to a factor
  
  # Calculate the F_1 score for the predictions
  F_meas(data = y_hat, reference = factor(train_set$sex))
})

# Combine the cutoff values and their respective F_1 scores into a data frame
# Plot the F_1 scores against cutoff values
data.frame(cutoff, F_1) %>% 
  ggplot(aes(cutoff, F_1)) +  # Define the x-axis as cutoff and y-axis as F_1
  geom_point() +             # Add points for each F_1 score
  geom_line()                # Connect the points with a line

# Find the maximum F_1 score
max(F_1)

# Identify the cutoff value that gives the highest F_1 score
best_cutoff_2 <- cutoff[which.max(F_1)]
best_cutoff_2

# Use the best cutoff to make predictions on the test set
y_hat <- ifelse(test_set$height > best_cutoff_2, "Male", "Female") %>% 
  factor(levels = levels(test_set$sex)) # Convert predictions to a factor

# Compute the sensitivity of the predictions (True Positive Rate)
sensitivity(data = y_hat, reference = test_set$sex)

# Compute the specificity of the predictions (True Negative Rate)
specificity(data = y_hat, reference = test_set$sex)
