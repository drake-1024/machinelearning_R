# Introduction to Machine Learning in R

Welcome to the "Introduction" section of my Machine Learning journey in R. This branch serves as an introduction to the basics of machine learning, including how to prepare data, set up training and test sets, and apply simple predictive models. Throughout this project, I will explore different machine learning concepts and techniques using R.

## Motivation

The goal of this section is to understand the fundamental concepts of machine learning and to begin working with simple models. In this particular exercise, we will use the **`caret`** package to partition data into training and test sets, and explore a basic classification problem — predicting the sex of individuals based on height.

The primary motivation behind this section is to:
- Understand how to split data into training and test sets.
- Get familiar with basic classification models.
- Explore the impact of different model thresholds on prediction accuracy.

## Code Walkthrough

In this notebook, we begin by loading the necessary libraries: **`tidyverse`**, **`caret`**, and **`dslabs`**. We then load a dataset called `heights` from **`dslabs`** that contains the height and sex of individuals.

### Key Steps:

1. **Data Setup**:
   We load the `heights` dataset and define `y` as the outcome variable (sex) and `x` as the predictor (height).

2. **Data Partitioning**:
   The data is split into **training** and **test** sets, using the `createDataPartition()` function from **`caret`**. A 50-50 split is used for training and testing.

3. **Initial Prediction**:
   We start with a very simple model, where we randomly predict whether an individual is "Male" or "Female" and calculate the accuracy of these random predictions.

4. **Height Comparison**:
   We explore the relationship between height and sex in the dataset by calculating the mean and standard deviation of height for both males and females.

5. **Simple Threshold-Based Model**:
   Using a simple rule-based model, we predict "Male" if the height is above a certain threshold (in this case, 62 inches). We evaluate the accuracy of this model.

6. **Model Tuning**:
   We experiment with different height cutoffs (ranging from 61 to 70 inches) to find the cutoff that yields the highest accuracy in predicting sex. A plot is generated to visualize how the accuracy changes with the cutoff values.

7. **Final Model**:
   The best cutoff is determined, and the model is applied to the test set to predict sex based on the optimal height threshold.

### Key Takeaways:
- By using a simple threshold-based approach, we were able to make reasonably accurate predictions about an individual's sex based on their height.
- The process of model tuning and validation using different thresholds is a fundamental concept in machine learning, and this exercise provides a hands-on introduction to it.
- This is a simple classification problem, but it introduces important concepts such as training-test splits, accuracy metrics, and model evaluation.

## Libraries Used

- **`tidyverse`**: A collection of R packages for data manipulation and visualization.
- **`caret`**: A package for machine learning that provides tools for data splitting, model training, and evaluation.
- **`dslabs`**: A package that contains the `heights` dataset and other example datasets.
