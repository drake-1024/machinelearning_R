# Basics of Performance Evaluation and Model Metrics

## Motivation

The prediction rule developed in the previous analysis predicts "Male" if the student's height exceeds 64 inches. Given that the average female height is around 64 inches, this rule appears flawed. Shouldn't we predict "Female" for students near the average female height? 

This situation demonstrates that **overall accuracy** can be misleading. To illustrate, we construct a **confusion matrix** that tabulates predictions versus actual values. Upon closer examination, the confusion matrix reveals an imbalance in the accuracy for males and females: the model predicts too many females as males. 

This discrepancy arises due to data imbalance: only 22% of the observations are female because the data was collected from courses with predominantly male participants. The overall accuracy is high because the correct predictions for males overshadow the high error rate for females. In extreme cases, if 99% of the data were males, always predicting "Male" would yield a high accuracy, but this approach would fail on a balanced dataset. 

This example highlights a critical issue in machine learning: biased training data can lead to biased algorithms. Using a test set derived from the same biased data does not solve the problem. Understanding such biases and exploring evaluation metrics beyond overall accuracy—such as **sensitivity** and **specificity**—is crucial for ethical and effective machine learning. 

## Key Steps

1. **Tabulate Predictions vs Actual Values**: Use the `table()` function to create a confusion matrix-like summary showing counts of predicted values (`y_hat`) against actual values (`test_set$sex`).

2. **Group Data and Compute Group-Specific Accuracy**: Add predictions as a new column (`y_hat`), Group the data by the actual sex variable (`sex`), and compute accuracy for each group by comparing predictions (`y_hat`) with actual values (`sex`).

3. **Calculate Prevalence of Males**: Determine the proportion of "Male" in the dataset.

4. **Generate a Confusion Matrix and Statistics**: Use the `confusionMatrix()` function to compute:


| | Actually positive | Actually negative |
|------------|:------------:|:------------:|
| Predicted positive | True positives (TP) | False positives (FP) |
| Predicted negative | False negatives (FN) | True negatives (TN) |

		
  - **Accuracy**: Overall percentage of correct predictions.
  - **Sensitivity (Recall, or True Positive Rate (TPR))**: Ability to correctly identify positive cases `TP/(TP+FN)`.
  - **Specificity (True Negative Rate (TNR))**: Ability to correctly identify negative cases `TN/(TN+FP)`. Specificity can also be quantified by the proportion of outcomes called positives that are actually positives `TP/(TP+FP)`. This quantity is called the **Positive Predicitve Value (PPV)** or **Precision**.
  - **Prevalence**: The proportion of positives (Females here because Females precedes Males alphabetically)
  - Other metrics (e.g., F1 score)


## Key Takeaways:

- Using only overall accuracy as a metric has a potential pitfall. It is important to also consider sensitivity and specificity
- Imbalanced datasets can lead to biased models and motivates the use of representative datasets and ethical considerations in machine learning.

## Libraries Used:

- **`tidyverse`**: A collection of R packages for data manipulation and visualization.
- **`caret`**: A package for machine learning that provides tools for data splitting, model training, and evaluation.
- **`dslabs`**: A package that contains the `heights` dataset and other example datasets.

 
