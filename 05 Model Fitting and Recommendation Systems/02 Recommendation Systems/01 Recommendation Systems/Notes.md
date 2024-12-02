# Recommendation Systems

### Motivation

Recommendation systems use user-item ratings to make predictions and recommendations. Companies like Amazon and Netflix leverage these systems to suggest products or movies based on predicted user preferences. For example, Netflix predicts star ratings for movies, where higher stars indicate better user satisfaction. 

In 2006, Netflix challenged the data science community to improve its recommendation algorithm by 10% for a $1 million prize. We will explore some of their key data analysis techniques.

### Exercise

The Netflix data isn't public, but GroupLens created a dataset with 20M+ ratings for 27K+ movies by 138K+ users. A subset is available in the `dslabs` package.

Each row represents a user's rating for a movie. While there are many users and movies, not every user rates every movie, creating a sparse matrix of ratings. Converting the full dataset into this matrix format (users as rows, movies as columns) would crash R, but we can view smaller samples. Recommendation systems aim to fill in the missing ratings (NAs), highlighting the matrix's sparsity.

This challenge is complex because each rating has a unique set of predictors. Ratings for a movie or user can serve as predictors, but users rate different movies and at varying frequencies. Similar movies or users may also provide insights. Essentially, the entire matrix can act as predictors for each cell. Key observations: some movies are rated more often (e.g., blockbusters), and some users are more active in rating than others.

Recommendation systems involve building algorithms based on collected data to predict ratings and recommend movies. To evaluate model accuracy, we create a test set, only including users who rated over 100 movies and movies rated at least five times. We assign 20% of each user's ratings to the test set and use `semi_join` to ensure all movies appear in both sets. Finally, we use `pivot_wider` to create a matrix of users (rows) and movies (columns) and a table mapping movie IDs to titles.

The Netflix challenge used residual mean squared error (RMSE) to evaluate models. A function can be written to compute RMSE for actual and predicted ratings.


### Key Steps

1. Load the necessary libraries and inspect the `movielens` dataset
2. Split the data into training and test sets
3. Transform to wide format
4. Map movie IDs to their corresponding titles
5. Define a function to compute RMSE

### Key Takeaways

- **Recommendation Systems**:  These systems predict user preferences for items (e.g., movies, products) based on historical data, enabling personalized recommendations.
- **Data Sparsity**: Ratings data is often sparse, with many user-item combinations unrated. Efficient handling of this sparsity is crucial in recommendation systems.
- **Machine Learning Challenge**: Each prediction involves unique combinations of predictors (e.g., user preferences, item similarities), making this task more complex than traditional supervised learning.
- **Matrix Representation**: Ratings can be represented as a user-item matrix, where the goal is to predict missing values (ratings) based on existing ones.
- **Loss Function**: RMSE is a common metric to assess model accuracy, representing the typical prediction error. Lower RMSE values indicate better model performance.

### Libraries Used

- **`tidyverse`**: For data manipulation and visualization.
- **`dslabs`**: Contains the `movielens` dataset.
