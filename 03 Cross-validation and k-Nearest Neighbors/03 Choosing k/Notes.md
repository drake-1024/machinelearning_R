# Choosing k
_Note: The R codes in this section requires the codes from the previous sections to be executed first in order to run correctly._

### Motivation

In the previous exercise, we saw how the choice of `k` in kNN affects model performance. Small `k` values often lead to overfitting, while large `k` values result in over-smoothing. This highlights the need for a thoughtful approach to selecting `k`.

In this exercise, we’ll explore how to evaluate kNN models for multiple values of `k` using both training and test sets. We’ll analyze how randomness in data affects accuracy estimates and why using the test set to choose `k` can lead to misleading conclusions. This sets the stage for understanding the importance of cross-validation for robust hyperparameter tuning.

### Key Steps

1. **Set Range for `k`**: Define a sequence of values from 3 to 251.

2. **Compute Accuracies**: Use `map_df()` to fit kNN models for each `k`, predict outcomes for both training and test sets, and calculate and store accuracies for each `k`. Save the training and test accuracies for each `k`in a tibble.

3. **Visualize Performance**: Create a plot of training and test accuracies against `k` to identify trends.

4. **Identify Optimal `k`**: Find the `k` value with the highest test set accuracy.

### Key Takeaways

- Due to overtraining, the accuracy estimates obtained with the test set will be generally lower than the estimates obtained with the training set.

- We prefer to minimize the expected loss rather than the loss we observe in just one dataset. Also, if we were to use the test set to pick k, we should not expect the accompanying accuracy estimate to extrapolate to the real world. This is because even here we broke a golden rule of machine learning: we selected the  using the test set. Cross validation provides an estimate that takes these into account.

### Libraries Used

- **`caret`**: For implementing kNN using the `knn3()` function.
- **`tidyverse`**: For data manipulation and visualization.
- **`caret`**: Machine learning functions
- **`dslabs`**: Dataset with the MNIST data
- **`purrr`**: For functional programming tools
