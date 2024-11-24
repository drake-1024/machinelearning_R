#### 1. Data setup

# Load required libraries for data manipulation, machine learning, and datasets
library(tidyverse)  # Provides tools for data manipulation and visualization
library(caret)      # Machine learning toolkit, including data splitting and model training
library(dslabs)     # Provides datasets and utilities for data analysis

# Load the heights dataset, which contains heights and sexes of individuals
data(heights)

# Define the target variable (outcome) as `y` and predictor variable as `x`
y <- heights$sex       # Target variable: Male or Female
x <- heights$height    # Predictor variable: Height in inches



#### 2. Data Partitioning

# Set a seed to ensure reproducibility of random operations
set.seed(2024)

# Split the data into training and testing sets, preserving class proportions (stratified sampling)
test_index <- createDataPartition(y, times = 1, p = 0.5, list = FALSE) # Indices for test set
test_set <- heights[test_index, ]  # Extract test set based on indices
train_set <- heights[-test_index, ] # Extract training set (remaining rows)



#### 3. Initial Random Prediction

# Randomly guess the outcome (Male/Female) for the test set
y_hat <- sample(c("Male", "Female"), length(test_index), replace = TRUE) %>% 
  factor(levels = levels(test_set$sex)) # Convert to factor with consistent levels

# Calculate and print the accuracy of the random guesses
mean(y_hat == test_set$sex)



#### 4. Height Comparison

# Compare the average height and standard deviation for males and females
heights %>% group_by(sex) %>% 
  summarize(mean(height), sd(height))  # Summarize height statistics by sex



#### 5. Simple Threshold-Based Model

# Predict "Male" if height is greater than 62 inches; otherwise, "Female"
y_hat <- ifelse(x > 62, "Male", "Female") %>% 
  factor(levels = levels(test_set$sex)) # Convert to factor with consistent levels
mean(y == y_hat)  # Calculate accuracy of this simple rule on the entire dataset

# Evaluate accuracy for different height cutoffs using training data
cutoff <- seq(61, 70)  # Define a sequence of height cutoffs to evaluate
accuracy <- map_dbl(cutoff, function(x) {
  y_hat <- ifelse(train_set$height > x, "Male", "Female") %>% 
    factor(levels = levels(test_set$sex)) # Predict based on the current cutoff
  mean(y_hat == train_set$sex)  # Calculate accuracy for the current cutoff
})



#### 6. Model Tuning

# Visualize the accuracy of predictions across different cutoffs
data.frame(cutoff, accuracy) %>% 
  ggplot(aes(cutoff, accuracy)) +  # Plot cutoff vs. accuracy
  geom_point() +  # Add points for accuracy values
  geom_line()     # Connect points with a line

# Find and print the maximum accuracy
max(accuracy)

# Identify the cutoff value that yields the best accuracy
best_cutoff <- cutoff[which.max(accuracy)]
best_cutoff



#### 7. Final Model

# Use the best cutoff to make predictions on the test set
y_hat <- ifelse(test_set$height > best_cutoff, "Male", "Female") %>% 
  factor(levels = levels(test_set$sex))  # Predict using the optimal cutoff
y_hat <- factor(y_hat)  # Ensure it is a factor

# Calculate and print the final accuracy on the test set
mean(y_hat == test_set$sex)
