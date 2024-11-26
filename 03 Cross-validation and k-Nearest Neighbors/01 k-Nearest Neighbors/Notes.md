# k-Nearest Neighbors (kNN)

### Motivation

In the previous exercises, we explored **linear regression** and **smoothing techniques** to model relationships between predictors and outcomes. While linear regression is intuitive and broadly applicable, its reliance on linear decision boundaries limits its ability to model complex, non-linear patterns. Smoothing methods like bin smoothing offer more flexibility but can struggle to generalize effectively in higher-dimensional data.  

To address these limitations, this exercise introduces **k-nearest neighbors (kNN)**, a machine learning algorithm capable of capturing non-linear relationships. kNN estimates the conditional probability function by leveraging the proximity of data points in feature space, making it highly adaptable to non-linear decision boundaries. Through this exercise, we transition from parametric methods to a non-parametric approach, enhancing our ability to work with complex datasets.

 The goal is to demonstrate how kNN estimates conditional probabilities for predictions and compares it to previous methods, such as linear regression. This exercise highlights the advantages of kNN, such as its adaptability to nonlinear relationships, while addressing potential pitfalls like over-training.

### Key Steps

1. **Visualize Data**: Plot the predictors (`x_1`, `x_2`) against the target variable (`y`) from the test dataset for a visual understanding of data distribution.

2. **Train kNN Model**: Train a k-nearest neighbors (kNN) model on the training dataset to predict the outcome variable.

3. **Make Predictions & Evaluate Accuracy**: Make predictions on the test dataset using the trained kNN model and evaluate accuracy. Compare this with a logistic regression model.

4. **Visualize Conditional Probability Maps**: Define a function to visualize the true conditional probabilities and the probabilities predicted by the kNN model. Compare these maps side by side.

### Key Takeaways

1. **k-Nearest Neighbors (kNN)** is a flexible and powerful machine learning algorithm that makes predictions based on the majority class of the k nearest neighbors to a data point. 

2. **Comparison of Models**: The kNN model can outperform simpler models, such as logistic regression, especially when the data is more complex and nonlinear. This is evident from the higher accuracy of kNN compared to linear regression in the exercise.

3. **Challenges of kNN**: Over-training can occur, where the model performs better on the training set than the test set.
   
### Libraries Used
- **`caret`**: For implementing kNN using the `knn3()` function.
- **`tidyverse`**: For data manipulation and visualization.
- **`caret`**: Machine learning functions
- **`dslabs`**: Dataset with the MNIST data
- **`gridExtra`**: To arrange multiple plots in a grid
