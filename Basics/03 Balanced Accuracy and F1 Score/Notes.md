# Balanced Accuracy and F1 Score

## Motivation

When optimizing a classification model, a single-number summary metric is often more useful than separately analyzing sensitivity (True Positive Rate) and specificity (True Negative Rate). One such metric is the **F1 Score**, which is the harmonic mean of **Precision** and **Recall**. 

The F1 Score offers a balanced measure of a model's performance, particularly useful in cases of imbalanced datasets where certain types of errors (e.g., false positives vs. false negatives) have different costs. The F1 Score can also be adapted to prioritize either sensitivity or specificity depending on the context. This flexibility makes it a powerful tool for evaluating classification algorithms.

In this exercise, the **`F_meas()`** function from the `caret` package is used to compute the F1 Score for different thresholds. This approach helps identify the optimal threshold that balances the trade-offs between precision and recall, improving the model's overall performance.


## Key Steps

1. **Define Cutoff Sequence**  
   Generate a sequence of height cutoff values (61 to 70 inches) for threshold analysis.

2. **Compute F1 Scores**  
   For each cutoff value, make predictions and calculate the corresponding F1 Score to evaluate model performance.

3. **Visualize Performance**  
   Plot the F1 Scores against the cutoff values to identify trends and the optimal threshold.

4. **Identify Optimal Cutoff**  
   Select the cutoff value that yields the highest F1 Score.

5. **Test Set Evaluation**  
   Apply the optimal cutoff to the test dataset and compute additional metrics like sensitivity and specificity.


## Key Takeaways

- **F1 Score as a Metric**: Useful for optimizing models, especially with imbalanced datasets, as it considers both false positives and false negatives.
- **Visualization**: Provides a clear way to identify the most effective threshold by observing trends in the F_1 score.
- **Sensitivity and Specificity**: These metrics supplement the F1 Score by offering insights into the balance between true positives and true negatives.
- **Threshold Tuning**: Highlights how small adjustments to the decision boundary can significantly impact performance metrics.


## Libraries Used

- **tidyverse**: For data manipulation and visualization.
- **caret**: For computing metrics like sensitivity, specificity, and F_1 score.
- **dslabs**: To access datasets used for classification tasks.
