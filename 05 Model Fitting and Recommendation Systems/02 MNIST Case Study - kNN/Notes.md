# MNIST Case Study - kNN
_Note: The R codes in this section requires the codes from the previous sections to be executed first in order to run correctly._

### Motivation

After preprocessing, we can fit models, starting with kNN. Column names must be added to feature matrices, as required by `caret`. The first step is optimizing `k`, which involves significant computations to calculate distances between test and training observations. Performing test runs with subsets of the data is recommended to estimate timing before running code that might take hours or days. By adjusting parameters `n` and `b`, we can understand their impact on computation time. Once `k = 3` is identified as optimal, we train the kNN algorithm, achieving over 95% accuracy. However, sensitivity and specificity reveal that 8's are hardest to detect, and 7 is the most commonly misclassified digit.

### Key Steps

1. Assign column names to training and test data
2. Train model on a subset of training data to estimate computational time on all training data
3. Train model using all training data and compute accuracy

### Key Takeaways

- The caret package requires that we add column names to the feature matrices.
- In general, it is a good idea to test out a small subset of the data first to get an idea of how long your code will take to run.

### Libraries Used

- **`caret`**: For training and tuning machine learning models.
- **`tidyverse`**: For data manipulation and visualization.
- **`dslabs`**: Contains the MNIST dataset
- **`matrixStats`**: For calculating summary statistics
