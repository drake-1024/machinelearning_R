# Trees and Random Forests

### Decision Trees

A decision tree is a flowchart-like structure used to make predictions based on a series of decision rules. At each step, the tree splits the data into subsets based on features, aiming to create partitions that are as "pure" as possible. This recursive process continues until stopping criteria are met, resulting in a tree with terminal nodes (leaves) that provide the final predictions.

#### Why Decision Trees?

- **Interpretability**: Decision trees are easy to understand and visualize, making them suitable for domains where explainability is critical
- **Non-linearity**: They can capture complex, non-linear relationships between features and outcomes.
- **Flexibility**: They handle both numeric and categorical data and require minimal preprocessing.

However, decision trees have limitations. They tend to overfit the data, making them sensitive to noise, and their performance can vary significantly depending on the specific training data.

### Random Forests

To address the limitations of decision trees, random forests extend the idea by combining multiple decision trees into an ensemble. Each tree in the forest is trained on a random subset of the data, and predictions are aggregated through voting (for classification) or averaging (for regression). The randomness introduced during training reduces the risk of overfitting and increases the model's robustness.

#### Why Random Forests
- **Improved Accuracy**: By averaging over multiple trees, random forests achieve better generalization compared to a single tree.
- **Robustness**: They are less sensitive to noise and variations in the training data.
- **Feature Importance**: Random forests can rank the importance of features, aiding in data-driven decision-making.

Despite their strengths, random forests can be computationally intensive, and their ensemble nature makes them less interpretable compared to individual decision trees.

### Motivation

The following exercise aims to explore decision trees and random forests, two essential tools in machine learning. We will first build and analyze decision trees to understand how they partition data and make predictions, as well as their limitations, such as overfitting. To address these challenges, we will then transition to random forests, leveraging their ensemble approach to improve accuracy and robustness. Through hands-on experimentation with parameter tuning, cross-validation, and performance evaluation, we will compare these methods and gain insight into their practical applications and strengths.

### Key Steps

1. **Fit and Visualize Decision Tree**: Train a decision tree on the `polls_2008` dataset. Plot the tree structure and visualize predictions against actual data.
2. **Tune Decision Tree with Cross-Validation**: Train a decision tree on the `mnist_27` dataset using cross-validation to optimize the complexity parameter. Evaluate the accuracy of the model.
3. **Train and Evaluate Random Forest**: Train a random forest on the `mnist_27` dataset. Use cross-validation to tune hyperparameters and compare model accuracy.

### Key Insights

- **Curse of dimensionality**: For kernel methods such as kNN or local regression, when they have multiple predictors used,  the span/neighborhood/window made to include a given percentage of the data become large. With larger neighborhoods, our methods lose flexibility. The dimension here refers to the fact that when we have predictors, the distance between two observations is computed in -dimensional space.
- **Metrics**: Two of the more popular metrics to choose the partitions of decision trees are the **Gini index** and **entropy**.
- **Decision Tree Pros**: Decision trees are highly interpretable and easy to visualize. They can model human decision processes and don’t require use of dummy predictors for categorical variables.
- **Decision Tree Cons**: The approach via recursive partitioning can easily over-train and is therefore a bit harder to train than kNN. Furthermore, in terms of accuracy, it is rarely the best performing method since it is not very flexible and is highly unstable to changes in training data. 
- **Random Forests** address the shortcomings of decision trees. The goal is to improve prediction performance and reduce instability by averaging multiple decision trees (a forest of trees constructed with randomness).
- **Bootstrap**: Random forests generate many predictors, each using regression or classification trees, and then forming a final prediction based on the average prediction of all these trees. To assure that the individual trees are not the same, we use the **bootstrap **to induce randomness. 
- **Random Forest Cons**: A disadvantage of random forests is that we **lose interpretability**.
- **Variable Importance**: An approach that helps with interpretability is to examine variable importance. To define variable importance we count how often a predictor is used in the individual trees. The `caret` package includes the function `varImp` that extracts variable importance from any model in which the calculation is implemented.

### Libraries Used

- **`caret`**: For training and tuning machine learning models.
- **`tidyverse`**: For data manipulation and visualization.
- **`dslabs`**: Dataset with the MNIST and polls_2008 data.
- **`rpart`**: For creating decision trees. 
- **`randomForest`**: To create random forests.
