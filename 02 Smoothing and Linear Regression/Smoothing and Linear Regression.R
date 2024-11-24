#### 1. Loading the Dataset

# Load necessary libraries
library(tidyverse)  # For data manipulation and visualization
library(dslabs)     # For the mnist_27 dataset
library(gridExtra)  # For arranging multiple plots in a grid
library(caret)      # For training and evaluating machine learning models

# Load the mnist_27 dataset which contains binary digits (2 and 7)
data("mnist_27")



#### 2. Data Exploration

# Explore the data by plotting the two predictors (x_1 and x_2) colored by the outcome y (digit)
mnist_27$train %>% 
  ggplot(aes(x_1, x_2, color = y)) + 
  geom_point()  # Create a scatter plot with x_1 and x_2 as axes and color points by digit y



#### 3. Identifying Extreme Values

# Find the smallest and largest values of x_1 and x_2, and visualize corresponding images
# First check if the "mnist" dataset exists, if not, load it
if(!exists("mnist")) mnist <- read_mnist()

# Find indices of the smallest and largest values of x_1
is <- mnist_27$index_train[c(which.min(mnist_27$train$x_1), which.max(mnist_27$train$x_1))]
titles <- c("smallest", "largest")

# Visualize images corresponding to smallest and largest x_1
tmp <- lapply(1:2, function(i){
  expand.grid(Row=1:28, Column=1:28) %>%  # Create a grid for 28x28 pixel image
    mutate(label=titles[i],                # Add label (smallest or largest)
           value = mnist$train$images[is[i],])  # Extract image values
})
tmp <- Reduce(rbind, tmp)  # Combine the two images into one dataframe

# Create a plot for the largest and smallest x_1 values
p1 <- tmp %>% 
  ggplot(aes(Row, Column, fill=value)) +  # Fill the image with pixel values
  geom_raster(show.legend = FALSE) + 
  scale_y_reverse() +  # Reverse y-axis to match image orientation
  scale_fill_gradient(low="white", high="black") +  # Color scale from white to black
  facet_grid(.~label) +  # Create separate panels for smallest and largest labels
  geom_vline(xintercept = 14.5) +  # Draw vertical line in the center of the image
  geom_hline(yintercept = 14.5) +  # Draw horizontal line in the center of the image
  ggtitle("Largest and smallest x_1")

# Repeat the process for x_2
is <- mnist_27$index_train[c(which.min(mnist_27$train$x_2), which.max(mnist_27$train$x_2))]
tmp <- lapply(1:2, function(i){
  expand.grid(Row=1:28, Column=1:28) %>%  
    mutate(label=titles[i],  
           value = mnist$train$images[is[i],])
})
tmp <- Reduce(rbind, tmp)

# Create a plot for the largest and smallest x_2 values
p2 <- tmp %>% 
  ggplot(aes(Row, Column, fill=value)) + 
  geom_raster(show.legend = FALSE) + 
  scale_y_reverse() +
  scale_fill_gradient(low="white", high="black") +
  facet_grid(.~label) + 
  geom_vline(xintercept = 14.5) +
  geom_hline(yintercept = 14.5) +
  ggtitle("Largest and smallest x_2")

# Display the two plots side by side
gridExtra::grid.arrange(p1, p2, ncol = 2)



#### 4. Fitting the Model (Linear Regression)

# Fit a linear model to predict the digit based on x_1 and x_2
fit <- mnist_27$train %>%
  mutate(y = ifelse(y == 7, 1, 0)) %>%  # Recode y as binary (1 for 7, 0 for 2)
  lm(y ~ x_1 + x_2, data = .)  # Fit a linear model with x_1 and x_2 as predictors



#### 5. Making Predictions and Evaluating Accuracy

# Make predictions on the test set
p_hat <- predict(fit, newdata = mnist_27$test, type = "response")  # Predict probabilities for test data
y_hat <- factor(ifelse(p_hat > 0.5, 7, 2))  # Classify as 7 if p_hat > 0.5, else classify as 2

# Calculate and display the accuracy of the model
confusionMatrix(y_hat, mnist_27$test$y)$overall[["Accuracy"]]  # Print the accuracy from the confusion matrix



#### 6. Visualizing Probabilities

# Plot the true probabilities (p) of class 7 in the test set
mnist_27$true_p %>% 
  ggplot(aes(x_1, x_2, z = p, fill = p)) +
  geom_raster() +  # Create a raster plot
  scale_fill_gradientn(colors=c("#F8766D", "white", "#00BFC4")) +  # Color scale from red to green
  stat_contour(breaks=c(0.5), color="black")  # Draw contour for p=0.5

# Visualize the predicted probabilities p_hat on the test set
p_hat <- predict(fit, newdata = mnist_27$true_p)  # Predict probabilities for the true_p data
p_hat <- scales::squish(p_hat, c(0, 1))  # Ensure the predictions are within [0, 1]

# Create a plot of the predicted probabilities p_hat
p1 <- mnist_27$true_p %>% mutate(p_hat = p_hat) %>%
  ggplot(aes(x_1, x_2,  z=p_hat, fill=p_hat)) +
  geom_raster() + 
  scale_fill_gradientn(colors=c("#F8766D","white","#00BFC4")) +
  stat_contour(breaks=c(0.5), color="black")  # Plot contours for p_hat=0.5

# Create another plot with the test points overlaid on the predicted probability contours
p2 <- mnist_27$true_p %>% mutate(p_hat = p_hat) %>%
  ggplot() +
  stat_contour(aes(x_1, x_2, z=p_hat), breaks=c(0.5), color="black") +  # Contours for p_hat=0.5
  geom_point(mapping = aes(x_1, x_2, color=y), data = mnist_27$test)  # Plot test points

# Display both plots side by side
gridExtra::grid.arrange(p1, p2, ncol = 2)
