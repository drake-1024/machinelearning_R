# MNIST Case Study - Preprocessing

### Motivation

The goal is to apply machine learning to the MNIST digits dataset by first preprocessing the data to improve efficiency and relevance. This might involve sampling a subset of the data, transforming predictors, and removing uninformative features, such as those with near-zero variance. By doing so, the dataset is reduced to a manageable size, which allows for faster and more effective model training, ultimately improving both performance and computational efficiency.

### Key Steps

1. Load the dataset and inspect the dimensions
2. Obtain a subset of the training and testing data
3. Identify and remove columns with almost zero variability

### Key Takeaways

- Common preprocessing steps include:
  - standardizing or transforming predictors and
  - removing predictors that are not useful, are highly correlated with others, have very few non-unique values, or have close to zero variation. 

### Libraries Used

**`dslabs`**: Contains the MNIST dataset
**`matrixStats`**: For calculating summary statistics
