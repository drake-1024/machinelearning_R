# Fitting with Loess
_Note: The R codes in this section requires the codes from the previous sections to be executed first in order to run correctly._

### Motivation

In the previous exercise, we explored the **`caret` package** to streamline the process of training, tuning, and evaluating machine learning models. The package provided a unified framework for handling a wide variety of algorithms, making it easier to experiment with different models and hyperparameters.

Building on this foundation, this exercise focuses on applying **LOESS (Locally Estimated Scatterplot Smoothing)**, a powerful non-parametric regression method that can capture complex relationships in data. Using the `caret` package, we will train and tune a **LOESS-based Generalized Additive Model (GAM)**. This allows us to combine the flexibility of LOESS smoothing with the structured workflow of `caret`. By the end of this exercise, we'll see how to leverage LOESS for smoothing and prediction tasks while further solidifying our understanding of model evaluation and hyperparameter tuning.

### Key Steps

1. Install the `gam` package for Generalized Additive Models.
2. Check details of the "gamLoess" model.
3. Define a hyperparameter grid for tuning.
4. Train a LOESS-based model on the training data.
5. Visualize hyperparameter tuning results.
6. Evaluate model accuracy on the test set.
7. Plot predicted conditional probabilities.

### Key Takeaways

- The "gam" package allows us to fit a model using the gamLoess method in caret. This method produces a smoother estimate of the conditional probability than kNN.

### Libraries Used

- **`caret`**: For training and tuning machine learning models.
- **`tidyverse`**: For data manipulation and visualization.
- **`dslabs`**: Dataset with the MNIST data
- **`gam`**:  For building Generalized Additive Models (GAMs), which extend traditional regression by modeling non-linear relationships using smooth functions.
