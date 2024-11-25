# Load the necessary libraries
library(tidyverse)  # For data manipulation and visualization
library(dslabs)     # Contains data like 'polls_2008'

# Load the polls_2008 dataset from the dslabs package
data("polls_2008")

# Create a scatter plot to visualize the relationship between day and margin
ggplot(polls_2008, aes(x = day, y = margin)) +  # Initialize the plot with 'day' on the x-axis and 'margin' on the y-axis
  geom_point() +  # Adds points for each pair of day and margin
  labs(title = "Poll Margin Over Time", x = "Day", y = "Margin")  # Adds a title and axis labels to the plot

# Fit a linear regression model to estimate the trend in margin over time (using day as predictor)
resid <- ifelse(lm(margin~day, data = polls_2008)$resid > 0, "+", "-")  # Get the residuals from the linear model and classify them as "+" or "-" based on their sign

# Create a plot that shows the margin over time with a linear regression line and points colored by residuals
polls_2008 %>% 
  mutate(resid = resid) %>%  # Add a new column 'resid' to the data frame based on the calculated residuals
  ggplot(aes(day, margin)) +  # Initialize the plot with 'day' on the x-axis and 'margin' on the y-axis
  geom_smooth(method = "lm", se = FALSE, color = "black") +  # Adds a linear regression line without confidence intervals (se = FALSE)
  geom_point(aes(color = resid), size = 3)  # Adds points colored by their residuals, with a size of 3
