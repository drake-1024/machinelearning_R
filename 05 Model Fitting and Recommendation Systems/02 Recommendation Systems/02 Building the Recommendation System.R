#### A First (Naive) Model

### 1. Obtain estimate of mean

# Calculate the overall mean rating (mu) across all movies and users in the training set
mu <- mean(train_set$rating)
mu



### 2. Compute RMSE

# Compute RMSE using the naive model (predicting the mean rating for all movies/users)
naive_rmse <- RMSE(test_set$rating, mu)
naive_rmse



#### Modeling Movie Effects

# Fit a linear model predicting ratings based on user IDs
# Note: We can build a model this way, but it's computationally heavy, so we will not
# fit <- lm(rating ~ as.factor(userId), data = movielens)



### 3. Compute movie-specific bias (b_i)

b_i <- colMeans(y - mu, na.rm = TRUE)



### 4. Group the training data by movieId and calculate the movie-specific bias (b_i)

movie_avgs <- train_set %>%
  group_by(movieId) %>%
  summarize(b_i = mean(rating - mu))



### 5. Visualize the distribution of movie-specific biases (b_i)

ggplot(data = data.frame(movie_avgs), aes(x = b_i)) +
  geom_histogram(bins = 10, color = "black")



### 6. Predict ratings for the test set using the overall mean and movie-specific bias

predicted_ratings <- mu + test_set %>%
  left_join(movie_avgs, by = 'movieId') %>%
  pull(b_i)



### 7. Compute RMSE for the model that includes movie-specific effects

model_1_rmse <- RMSE(predicted_ratings, test_set$rating)
model_1_rmse



#### Modeling User Effects

### 8. Visualize the distribution of user-specific effects for users who rated 100+ movies

train_set %>% 
  group_by(userId) %>% 
  summarize(b_u = mean(rating)) %>% 
  filter(n() >= 100) %>%  # Filter for users who have rated at least 100 movies
  ggplot(aes(b_u)) + 
  geom_histogram(bins = 30, color = "black")

# Fit a linear model predicting ratings based on movieId and userId
# Note: We can build a model this way, but it's computationally heavy, so we will not
# lm(rating ~ as.factor(movieId) + as.factor(userId))



### 9. Calculate user-specific biases (b_u) by subtracting the overall mean and movie bias

user_avgs <- train_set %>%
  left_join(movie_avgs, by = 'movieId') %>%
  group_by(userId) %>%
  summarize(b_u = mean(rating - mu - b_i))



### 10. Predict ratings for the test set using the overall mean, movie-specific biases, and user-specific biases

predicted_ratings <- test_set %>% 
  left_join(movie_avgs, by = 'movieId') %>%
  left_join(user_avgs, by = 'userId') %>%
  mutate(pred = mu + b_i + b_u) %>%
  pull(pred)

### 11. Compute RMSE for the model that includes both movie and user-specific effects

model_2_rmse <- RMSE(predicted_ratings, test_set$rating)
model_2_rmse
