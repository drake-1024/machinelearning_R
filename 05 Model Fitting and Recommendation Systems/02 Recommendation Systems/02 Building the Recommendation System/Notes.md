# Building the Recommendation System
_Note: The R codes in this section requires the codes from the previous sections to be executed first in order to run correctly._

### Motivation

The goal of this exercise is to create a predictive model for a movie recommendation system. This model aims to predict user ratings for movies based on historical data, an essential task for platforms that rely on personalized recommendations to enhance user experience and engagement.  

We start with a simple baseline model that predicts all ratings using the global average rating. This provides a benchmark for comparison with more sophisticated approaches.  

Next, we improve the model by incorporating movie-specific effects, adjusting predictions based on the average deviation of individual movie ratings from the global mean. This step accounts for movies that are inherently rated higher or lower than others.  

Finally, we introduce user-specific effects, acknowledging that some users tend to rate movies consistently higher or lower. By combining the global average, movie effects, and user effects, we refine our predictions further.  

Each stage is evaluated using the Root Mean Squared Error (RMSE), providing a measure of prediction accuracy. This exercise illustrates how to iteratively enhance recommendation systems by layering statistical insights and progressively increasing model complexity.

### Key Steps

#### A First (Naive) Model

1. Obtain estimate of mean
2. Compute RMSE

#### Modeling Movie Effects

- _Fit a linear model predicting ratings based on user IDs. Note, we can build a model this way, but it's computationally heavy, so we will not_
3. Compute movie-specific bias (b_i)
4. Group the training data by movieId and calculate the movie-specific bias (b_i)
5. Visualize the distribution of movie-specific biases (b_i)
6. Predict ratings for the test set using the overall mean and movie-specific bias
7. Compute RMSE for the model that includes movie-specific effects

#### Modeling User Effects

8. Visualize the distribution of user-specific effects for users who rated 100+ movies
- Fit a linear model predicting ratings based on movieId and userId. Note, we can build a model this way, but it's computationally heavy, so we will not
9. Calculate user-specific biases (b_u) by subtracting the overall mean and movie bias
10. Predict ratings for the test set using the overall mean, movie-specific biases, and user-specific biases
11. Compute RMSE for the model that includes both movie and user-specific effects

### Key Takeaways

- **Baseline Model**: Start by predicting all ratings using the global average rating to establish a benchmark for accuracy.
- **Movie-Specific Effects**: Incorporate movie-specific deviations from the global average to account for movies that are consistently rated higher or lower than others.
- **User-Specific Effects**: Factor in user-specific deviations to reflect individual rating tendencies, refining the prediction further.
- **Improved Accuracy**: Combining the baseline model with movie- and user-specific effects significantly improved the RMSE of the model. 

### Libraries Used

- **`tidyverse`**: For data manipulation and visualization.
- **`dslabs`**: Contains the `movielens` dataset.
