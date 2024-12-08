# Regularization
_Note: The R codes in this section requires the codes from the previous sections to be executed first in order to run correctly._

### Motivation

In the previous exercise, we used simple averages and movie-specific biases (`b_i`) to predict user ratings. While this method captures general trends, it can overfit, especially for movies with few ratings. For example, a movie with just one rating may have an extreme bias that doesn't reflect its true quality. Regularization helps solve this problem by penalizing extreme values, shrinking the biases of movies with limited data. This makes the model more robust, improving prediction accuracy for both popular and less-rated movies. In this exercise, we'll apply regularization to the movie biases, adjusting them based on the number of ratings, and explore how this improves the accuracy of our movie recommendation model.

### Key Steps
1. Find the 10 movies with the largest absolute residuals from the test set.
2. Find the 10 best and worst movies based on the predicted average effects (b_i).
3. Count the number of ratings for the 10 best and worst movies.
4. Initialize lambda = 3 for regularization.
5. Compute regularized movie effects.
6. Compare original vs. regularized movie effects with a scatter plot.
7. Find the 10 best and worst movies.
8. Compute RMSE for the model.
9. Tune lambda to minimize RMSE.
10. Extend regularization to include user effects.
11. Compute RMSE for the model.

### Key Takeaways

- Regularization permits us to penalize large estimates that are formed using small sample sizes.
- Lambda (λ) is a tuning parameter that controls the strength of the penalty applied.
- Penalized estimates provide a large improvement over the least squares estimates

### Libraries Used

- **`dslabs`**: Contains the `movielens` dataset.
- **`ggplot2`**: For creating visualizations.
- **`dplyr`**: For data manipulation.
