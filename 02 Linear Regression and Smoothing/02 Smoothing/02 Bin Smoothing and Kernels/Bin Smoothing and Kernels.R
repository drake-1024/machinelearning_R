# Load the necessary libraries
library(tidyverse)    # For data manipulation and visualization
library(dslabs)       # Contains the `polls_2008` dataset

# Load the polls_2008 dataset
data("polls_2008")

#### 1. Define Span and Prepare Data

span <- 3.5  # Define the span (distance threshold) for bin smoothing.
tmp <- polls_2008 %>%  # Create a temporary dataset
  crossing(center = polls_2008$day) %>%  # Cross every day with all other days to form all combinations.
  mutate(dist = abs(day - center)) %>%  # Calculate the distance between each day and the center.
  filter(dist <= span)  # Filter rows where the distance is within the span.



#### 2. Filter and Visualize Specific Centers

tmp %>% filter(center %in% c(-125, -55)) %>%  # Filter temporary data for specific center values.
  ggplot(aes(day, margin)) +  # Initialize a ggplot with day on the x-axis and margin on the y-axis.
  geom_point(data = polls_2008, size = 3, alpha = 0.5, color = "grey") +  # Plot original data points in grey.
  geom_point(size = 2) +  # Plot smoothed data points for the selected centers.
  geom_smooth(aes(group = center),  # Add smooth lines for each center.
              method = "lm", formula=y~1, se = FALSE) +  # Use linear model smoothing with no confidence intervals.
  facet_wrap(~center)  # Create separate plots for each center value.



#### 3. Apply Kernel Smoothing with Box Kernel

span <- 7  # Update the span to a larger value.
fit <- with(polls_2008,  # Apply kernel smoothing using the "box" kernel and the new span.
            ksmooth(day, margin, kernel = "box", bandwidth = span))

polls_2008 %>% mutate(smooth = fit$y) %>%  # Add the smoothed values as a new column to the dataset.
  ggplot(aes(day, margin)) +  # Initialize a ggplot with day on the x-axis and margin on the y-axis.
  geom_point(size = 3, alpha = .5, color = "grey") +  # Plot original data points in grey.
  geom_line(aes(day, smooth), color="red")  # Add the smoothed line in red.




#### 4. Apply Kernel Smoothing with Normal Kernel

span <- 7  # Define the span for smoothing.
fit <- with(polls_2008,  # Apply kernel smoothing using the "normal" kernel.
            ksmooth(day, margin, kernel = "normal", bandwidth = span))

polls_2008 %>% mutate(smooth = fit$y) %>%  # Add the smoothed values as a new column to the dataset.
  ggplot(aes(day, margin)) +  # Initialize a ggplot with day on the x-axis and margin on the y-axis.
  geom_point(size = 3, alpha = .5, color = "grey") +  # Plot original data points in grey.
  geom_line(aes(day, smooth), color="red")  # Add the smoothed line in red.
