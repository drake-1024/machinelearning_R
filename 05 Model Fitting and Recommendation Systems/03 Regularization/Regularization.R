library(dslabs)
library(ggplot2)
library(dplyr)


#### 1. Find the 10 movies with the largest absolute residuals from the test set.

test_set %>% 
  left_join(movie_avgs, by='movieId') %>%  # Join the test set with movie averages by 'movieId'.
  mutate(residual = rating - (mu + b_i)) %>%  # Calculate the residuals (difference between actual and predicted ratings).
  arrange(desc(abs(residual))) %>%  # Sort rows by the absolute value of the residuals in descending order.
  select(title, residual) %>%  # Select the columns 'title' and 'residual'.
  slice(1:10) %>%  # Keep only the top 10 rows.
  pull(title)  # Extract the 'title' column as a vector.



#### 2. Find the 10 best and worst movies based on the predicted average effects (b_i).

# Create a unique mapping of movieId to movie titles from the movielens dataset.
movie_titles <- movielens %>% 
  select(movieId, title) %>%  # Select the columns 'movieId' and 'title'.
  distinct()  # Keep only unique rows to ensure no duplicates.

# Find the 10 best movies
movie_avgs %>% 
  left_join(movie_titles, by="movieId") %>%  # Join movie averages with titles by 'movieId'.
  arrange(desc(b_i)) %>%  # Sort rows by 'b_i' in descending order (best movies).
  select(title, b_i) %>%  # Select the columns 'title' and 'b_i'.
  slice(1:10) %>%  # Keep only the top 10 rows.
  pull(title)  # Extract the 'title' column as a vector.

# Find the 10 worst movies
movie_avgs %>% 
  left_join(movie_titles, by="movieId") %>%  # Join movie averages with titles by 'movieId'.
  arrange(b_i) %>%  # Sort rows by 'b_i' in ascending order (worst movies).
  select(title, b_i) %>%  # Select the columns 'title' and 'b_i'.
  slice(1:10) %>%  # Keep only the top 10 rows.
  pull(title)  # Extract the 'title' column as a vector.



#### 3. Count the number of ratings for the 10 best and worst movies.

# 10 best movies
train_set %>% 
  count(movieId) %>%  # Count the number of ratings for each 'movieId'.
  left_join(movie_avgs) %>%  # Join with movie averages.
  left_join(movie_titles, by="movieId") %>%  # Join with movie titles by 'movieId'.
  arrange(desc(b_i)) %>%  # Sort rows by 'b_i' in descending order (highest effects).
  slice(1:10) %>%  # Keep only the top 10 rows.
  pull(n)  # Extract the 'n' column (number of ratings) as a vector.

# 10 worst movies
train_set %>% 
  dplyr::count(movieId) %>%  # Count the number of ratings for each 'movieId'.
  left_join(movie_avgs) %>%  # Join with movie averages.
  left_join(movie_titles, by="movieId") %>%  # Join with movie titles by 'movieId'.
  arrange(b_i) %>%  # Sort rows by 'b_i' in ascending order (lowest effects).
  slice(1:10) %>%  # Keep only the top 10 rows.
  pull(n)  # Extract the 'n' column (number of ratings) as a vector.



#### 4. Initialize lambda = 3 for regularization.

lambda <- 3



#### 5. Compute regularized movie effects.

movie_reg_avgs <- train_set %>% 
  group_by(movieId) %>%  # Group by movieId to calculate averages for each movie.
  summarize(b_i = sum(rating - mu) / (n() + lambda),  # Regularized movie effect (b_i).
            n_i = n())  # Count of ratings per movie (n_i).



#### 6. Compare original vs. regularized movie effects with a scatter plot.

tibble(original = movie_avgs$b_i,  # Original (unregularized) movie effects.
       regularlized = movie_reg_avgs$b_i,  # Regularized movie effects.
       n = movie_reg_avgs$n_i) %>%  # Count of ratings per movie.
  ggplot(aes(original, regularlized, size = sqrt(n))) +  # Map aesthetics.
  geom_point(shape = 1, alpha = 0.5)  # Add points with transparency.



#### 7. Find the 10 best and worst movies.

# 10 best movies
train_set %>%
  count(movieId) %>%  # Count ratings for each movie.
  left_join(movie_reg_avgs, by = "movieId") %>%  # Join with regularized movie averages.
  left_join(movie_titles, by = "movieId") %>%  # Add movie titles.
  arrange(desc(b_i)) %>%  # Sort by descending b_i.
  select(title, b_i, n) %>%  # Select relevant columns.
  slice(1:10) %>%  # Take the top 10 rows.
  pull(title)  # Extract the titles as a vector.

# 10 worst movies
train_set %>%
  count(movieId) %>%  # Count ratings for each movie.
  left_join(movie_reg_avgs, by = "movieId") %>%  # Join with regularized movie averages.
  left_join(movie_titles, by = "movieId") %>%  # Add movie titles.
  arrange(b_i) %>%  # Sort by ascending b_i.
  select(title, b_i, n) %>%  # Select relevant columns.
  slice(1:10) %>%  # Take the bottom 10 rows.
  pull(title)  # Extract the titles as a vector.



#### 8. Compute RMSE for the model.

# Calculate predicted ratings using regularized movie effects.
predicted_ratings <- test_set %>% 
  left_join(movie_reg_avgs, by = 'movieId') %>%  # Join with regularized movie effects.
  mutate(pred = mu + b_i) %>%  # Compute predicted ratings (global mean + movie effect).
  pull(pred)  # Extract the predicted ratings as a vector.

# Compute RMSE for the model.
model_3_rmse <- RMSE(predicted_ratings, test_set$rating)



#### 9. Tune lambda to minimize RMSE.

lambdas <- seq(0, 10, 0.25)  # Generate a sequence of lambda values to test.
mu <- mean(train_set$rating)  # Calculate global mean rating.
just_the_sum <- train_set %>% 
  group_by(movieId) %>% 
  summarize(s = sum(rating - mu),  # Sum of deviations from the mean.
            n_i = n())  # Count of ratings per movie.
rmses <- sapply(lambdas, function(l){  # Apply a function to calculate RMSE for each lambda.
  predicted_ratings <- test_set %>% 
    left_join(just_the_sum, by = 'movieId') %>%  # Join with summed data.
    mutate(b_i = s / (n_i + l)) %>%  # Calculate regularized b_i.
    mutate(pred = mu + b_i) %>%  # Compute predicted ratings.
    pull(pred)  # Extract predicted ratings.
  return(RMSE(predicted_ratings, test_set$rating))  # Return RMSE.
})

# Create a data frame to hold the data
lambda_data <- data.frame(lambda = lambdas, RMSE = rmses)

# Plot RMSE vs. lambda values.
ggplot(lambda_data, aes(x = lambda, y = RMSE)) +
  geom_line(color = "blue") +  # Add a line plot
  geom_point(color = "red", size = 1) +  # Optionally, add points for each lambda
  labs(title = "RMSE vs Lambda",
       x = "Lambda (Regularization Parameter)",
       y = "RMSE (Root Mean Squared Error)") +
  theme_minimal()  # Use a clean, minimal theme

lambdas[which.min(rmses)]  # Find the lambda value that minimizes RMSE.



#### 10. Extend regularization to include user effects.

lambdas <- seq(0, 10, 0.25)  # Generate lambda values.
rmses <- sapply(lambdas, function(l){
  mu <- mean(train_set$rating)  # Calculate global mean rating.
  b_i <- train_set %>% 
    group_by(movieId) %>%
    summarize(b_i = sum(rating - mu) / (n() + l))  # Regularized movie effects.
  b_u <- train_set %>% 
    left_join(b_i, by = "movieId") %>%
    group_by(userId) %>%
    summarize(b_u = sum(rating - b_i - mu) / (n() + l))  # Regularized user effects.
  predicted_ratings <- 
    test_set %>% 
    left_join(b_i, by = "movieId") %>%
    left_join(b_u, by = "userId") %>%
    mutate(pred = mu + b_i + b_u) %>%  # Compute predicted ratings.
    pull(pred)  # Extract predicted ratings.
  return(RMSE(predicted_ratings, test_set$rating))  # Return RMSE.
})

# Create a data frame to hold the data
lambda_data <- data.frame(lambda = lambdas, RMSE = rmses)

# Plot RMSE vs. lambda values.
ggplot(lambda_data, aes(x = lambda, y = RMSE)) +
  geom_line(color = "blue") +  # Add a line plot
  geom_point(color = "red", size = 1) +  # Optionally, add points for each lambda
  labs(title = "RMSE vs Lambda",
       x = "Lambda (Regularization Parameter)",
       y = "RMSE (Root Mean Squared Error)") +
  theme_minimal()  # Use a clean, minimal theme
lambda <- lambdas[which.min(rmses)]  # Identify the optimal lambda value.
lambda  # Display the optimal lambda value.



#### 11. Compute RMSE for the model.

model_4_rmse <- min(rmses)
