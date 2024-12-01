# MNIST Case Study - Ensembles
_Note: The R codes in this section requires the codes from the previous sections to be executed first in order to run correctly._

### Motivation

Ensemble methods combine multiple models to improve predictive performance. By aggregating the predictions of several models, ensemble techniques reduce errors and increase robustness, often leading to better generalization on unseen data. Common ensemble methods include **bagging**, **boosting**, and **stacking**, where models work together to correct each other's mistakes, enhancing accuracy and stability.

# Key Takeaways from the Ensembles Exercise

- **Improved Performance**: Combining multiple models, such as kNN and Random Forest (RF), can improve predictive performance compared to individual models.
- **Model Averaging**: A simple ensemble approach is to average the predictions from different models. For example, combining the probability predictions from RF and kNN results in better accuracy than using a single model.
- **Voting for Predictions**: In classification, predictions from multiple models can be combined using majority voting or probability averaging, leading to more robust results.

### Key Steps

1. Compute class probabilities for Random Forest model
2. Compute class probabilities for k-Nearest Neighbors model
3. Compute average of class probabilities
4. Compute accuracy of predictions

### Key Takeaways



### Libraries Used

- **`caret`**: For training and tuning machine learning models.
- **`tidyverse`**: For data manipulation and visualization.
- **`dslabs`**: Contains the MNIST dataset.
- **`randomForest`**: To create random forests.
