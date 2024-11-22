# Tabulate each combination of predicted and actual values for the test set
# Creates a confusion matrix-like table summarizing predictions vs actual values
table(predicted = y_hat, actual = test_set$sex)

# Add predictions (y_hat) as a new column to the test_set dataset
# Group the data by the actual 'sex' and calculate accuracy within each group
test_set %>%
  mutate(y_hat = y_hat) %>%       # Add the predictions as a new column
  group_by(sex) %>%               # Group data by the actual 'sex' (Male/Female)
  summarize(accuracy = mean(y_hat == sex))  # Compute accuracy for each group

# Calculate the prevalence of males in the original dataset
# Prevalence is the proportion of instances where the actual label is "Male"
prev <- mean(y == "Male")

# Generate a detailed confusion matrix for the predictions
# Includes metrics like accuracy, sensitivity, specificity, and others
confusionMatrix(data = y_hat, reference = test_set$sex)
