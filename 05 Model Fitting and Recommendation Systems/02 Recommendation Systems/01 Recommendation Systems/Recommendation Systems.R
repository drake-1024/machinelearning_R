#### 1. Load the necessary libraries and inspect the dataset

# Load required libraries for data manipulation and visualization
library(tidyverse)  
library(dslabs)

# Load the 'movielens' dataset from the dslabs package
data("movielens")  

# Convert the movielens dataset to a tibble for easier viewing and manipulation
movielens %>% as_tibble()  

# Summarize the dataset by calculating the number of unique users and movies
movielens %>%
  summarize(n_users = n_distinct(userId),  # Count unique users
            n_movies = n_distinct(movieId))  # Count unique movies

# Display the first few rows of the movielens dataset
head(movielens)  




#### 2. Split the data into training and test sets

# Load the caret library for machine learning utilities
library(caret)  

# Set a seed for reproducibility
set.seed(755)  

# Create an index to partition the data into training (80%) and test (20%) sets
test_index <- createDataPartition(y = movielens$rating, times = 1,
                                  p = 0.2, list = FALSE)

# Assign rows not in the test index to the training set
train_set <- movielens[-test_index,]  

# Assign rows in the test index to the test set
test_set <- movielens[test_index,]  

# Filter the test set to include only movies and users present in the training set
test_set <- test_set %>% 
  semi_join(train_set, by = "movieId") %>%  # Retain only movies in both sets
  semi_join(train_set, by = "userId")       # Retain only users in both sets




#### 3. Transform to wide format

# Transform the training set into a wide matrix format (users as rows, movies as columns)
y <- select(train_set, movieId, userId, rating) %>%
  pivot_wider(names_from = movieId, values_from = rating)  

# Save the user IDs as row names for the matrix
rnames <- y$userId  
y <- as.matrix(y[,-1])  # Convert to a matrix, removing the userId column
rownames(y) <- rnames  # Assign user IDs as row names




#### 4. Map movie IDs to their corresponding titles

# Create a mapping of movie IDs to titles by selecting distinct movie IDs and titles
movie_map <- train_set %>%
  select(movieId, title) %>%
  distinct(movieId, .keep_all = TRUE)  



#### 5. Define a function to compute RMSE

# Define a function to calculate the Root Mean Squared Error (RMSE)
RMSE <- function(true_ratings, predicted_ratings){
  sqrt(mean((true_ratings - predicted_ratings)^2))  # Compute RMSE from true and predicted ratings
}
