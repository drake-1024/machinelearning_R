# Linear Regression

## Motivation

In this exercise, the task is to distinguish between two handwritten digits: **2** and **7**. This challenge arises because digits like **2** and **7** can appear quite similar, especially when parts of the digit are missing, such as the base of a **2**. By focusing on only two features derived from 784 image pixels, we simplify the problem to a more manageable size. These features are:
- `x_1`: The proportion of dark pixels in the upper-left quadrant of the image.
- `x_2`: The proportion of dark pixels in the lower-right quadrant of the image.

This simplification allows us to illustrate how machine learning techniques can be applied, even with high-dimensional data, by first reducing it to just two features.

## Key Steps

1. **Loading the Dataset:** The dataset `mnist_27`, which contains a subset of the MNIST dataset for digits **2** and **7**, is loaded from the `dslabs` package.

2. **Data Exploration:** A scatter plot is created to visualize the relationship between the two predictors (`x_1` and `x_2`) and the outcome variable `y` (the digit label). Points are colored based on the digit class (either **2** or **7**) to help identify patterns.

3. **Identifying Extreme Values:** The smallest and largest values for each predictor (`x_1` and `x_2`) are identified, and the corresponding images from the MNIST dataset are visualized. These images help illustrate how the predictors relate to the actual digits.

4. **Fitting the Model (Linear Regression):** A **linear regression** model is fit to the data, with the outcome variable `y` recoded to binary (1 for **7**, 0 for **2**). The predictors `x_1` and `x_2` are used to predict the probability that the digit is a **7**.

5. **Making Predictions and Evaluating Accuracy:** The model's predictions are evaluated on the test data. A decision rule is created based on the predicted probabilities: if the probability is greater than 0.5, the prediction is classified as a **7**, otherwise as a **2**. The model's accuracy is computed using a confusion matrix.

6. **Visualizing Probabilities:** The predicted probabilities (`p_hat`) are visualized to examine how the model is making its predictions. This is done using contour plots and raster plots, which help visualize the decision boundary and how well the model distinguishes between the two digits.

## Key Takeaways

- **Simplifying the Problem:** Reducing the MNIST dataset from 784 features to just two predictors allows for easier exploration and illustrates fundamental machine learning concepts, making it more approachable.
  
- **Linear Regression for Classification:** Linear regression can be used for classification tasks, but it has limitations. In this example, it shows that a linear model cannot capture complex, non-linear boundaries between classes.

- **Model Evaluation:** Accuracy is a useful metric, but visualizing the decision boundary and understanding the model’s predictions provides deeper insights into its strengths and weaknesses.

- **Visualizing Decision Boundaries:** The use of visualizations, such as predicted probabilities and decision contours, helps understand how the model makes decisions and highlights areas where it might fail to accurately classify complex patterns.

## Libraries Used

- **`tidyverse`:** For data manipulation, visualization
- **`dslabs`:** Contains the `mnist_27` dataset.
- **`caret`:** For training and evaluating machine learning models, which is used here to calculate the accuracy of the predictions.
- **`gridExtra`:** To arrange multiple plots in a grid, making it easier to compare the visualizations of the smallest and largest values for the predictors.
