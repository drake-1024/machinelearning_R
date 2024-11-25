# Load the necessary libraries
library(tidyverse)    # For data manipulation and visualization
library(dslabs)       # Contains the `polls_2008` dataset
library(broom)        # For tidying model outputs



#### 1. Calculate Span and Weights

# Calculate the span as a proportion of the total range of days in polls_2008
span <- 21 / diff(range(polls_2008$day))

# Prepare a temporary dataset for visualization
tmp <- polls_2008 %>%
  crossing(center = polls_2008$day) %>%  # Create combinations of every day with all other days
  mutate(dist = abs(day - center)) %>%  # Compute the absolute distance between days
  filter(rank(dist) / n() <= span) %>%  # Keep rows where the distance falls within the span
  mutate(weight = (1 - (dist / max(dist)) ^ 3) ^ 3)  # Assign weights using the Tukey tri-weight function



#### 2. Filter Data and Visualize

tmp %>% 
  filter(center %in% c(-125, -55)) %>%  # Filter for two specific center days
  ggplot(aes(day, margin)) +  # Initialize ggplot with day on x-axis and margin on y-axis
  scale_size(range = c(0, 3)) +  # Scale the size of points
  geom_smooth(aes(group = center, weight = weight),  # Add smoothed lines with weights
              method = "lm", se = FALSE) +
  geom_point(data = polls_2008, size = 3, alpha = .5, color = "grey") +  # Plot original data points in grey
  geom_point(aes(size = weight)) +  # Highlight points with their weights
  facet_wrap(~center)  # Create separate plots for each center value



#### 3. Fit Loess Model and Plot

total_days <- diff(range(polls_2008$day))  # Calculate the total range of days
span <- 21 / total_days  # Recalculate span as a proportion

fit <- loess(margin ~ day, degree = 1, span = span, data = polls_2008)  # Fit a loess model

polls_2008 %>% mutate(smooth = fit$fitted) %>%  # Add smoothed values to the dataset
  ggplot(aes(day, margin)) +
  geom_point(size = 3, alpha = .5, color = "grey") +  # Plot original data points in grey
  geom_line(aes(day, smooth), color = "red")  # Add the smoothed line in red



#### 4. Define span values

spans <- c(.66, 0.25, 0.15, 0.10)  # Define a set of spans to compare



#### 5. Fit loess models for each span

fits <- data_frame(span = spans) %>%  # Create a dataframe with span values
  group_by(span) %>%  # Group by span
  do(broom::augment(loess(margin ~ day, degree = 1, span = .$span, data = polls_2008)))  # Fit and augment loess for each span



#### 6. Visualize and Compare

# Create a temporary dataset with weights for visualization
tmp <- fits %>%
  crossing(center = polls_2008$day) %>%  # Cross every day with all other days
  mutate(dist = abs(day - center)) %>%  # Compute absolute distance between days
  filter(rank(dist) / n() <= span) %>%  # Keep rows where the distance falls within the span
  mutate(weight = (1 - (dist / max(dist)) ^ 3) ^ 3)  # Assign weights using Tukey tri-weight

# Visualize the loess fits for different spans
tmp %>% ggplot(aes(day, margin)) +
  geom_point(size = 2, alpha = .5, color = "grey") +  # Plot original data points in grey
  geom_line(aes(day, .fitted), data = fits, color = "red") +  # Add smoothed lines in red
  facet_wrap(~span)  # Create separate plots for each span
