# Overtraining and Oversmoothing
_Note: The R codes in this section requires the codes from the previous sections to be executed first in order to run correctly._

### Motivation

In the previous exercise, we explored k-nearest neighbors (k-NN) as a classification technique. While k-NN is a powerful model, the choice of the number of neighbors, `k`, plays a critical role in determining its performance. When `k = 1`, the model tends to over-train by fitting the decision boundary too closely to the training data, resulting in a high training accuracy but poor generalization to the test set.

In this exercise, we will examine the effects of different values of `k` on model performance. We begin by training a k-NN model with `k = 1`, which will show over-training with high accuracy on the training set but a much lower accuracy on the test set. On the other hand, larger values of `k`, such as `k = 401`, leads to oversmoothing of data, similar to what we saw in the regression exercise.

In principle, we want to pick the `k` that maximizes accuracy or minimizes the expected MSE. The goal of cross-validation (next section) is to estimate these quantities for any given algorithm and any set of tuning parameters, such as `k`.

### Key Steps

1. **Fit k-NN Model (k = 1)**: Fit k-NN model (`k = 1`) and predict class labels for training and test data. Calculate accuracy using `confusionMatrix()`.

2. **Visualize Conditional Probability for k-NN (k = 1)**: Create contour plots for training and test data showing the estimated conditional probabilities.

3. **Fit k-NN Model (k = 401)**: Repeat step 1 using `k = 401`.

4. **Fit Logistic Regression Model**: Fit a logistic regression model and predict conditional probabilities.

5. **Compare Models**: Compare conditional probability estimates from k-NN and logistic regression models with side-by-side plots.

### Key Takeaways

- **Overfitting with Small `k`**: When `k` is too small, the k-NN model overfits the training data. This leads the model to become too complex, capturing every small detail of the training set, which can result in poor performance on new, unseen data. 

- **Over-smoothing with Large `k`**: A large value of `k` results in over-smoothing and the decision boundary becomes much less sensitive to individual data points

- **Tuning Hyperparameters**: Choosing the right `k` is crucial, and cross-validation can help find the best value for optimal performance.

- **Visualizing Predictions**: Plotting decision boundaries and conditional probabilities helps identify overfitting or over-smoothing issues.

### Libraries Used

- **`caret`**: For implementing kNN using the `knn3()` function.
- **`tidyverse`**: For data manipulation and visualization.
- **`caret`**: Machine learning functions
- **`dslabs`**: Dataset with the MNIST data
- **`gridExtra`**: To arrange multiple plots in a grid
