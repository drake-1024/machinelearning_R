# MNIST Case Study - Random Forest
_Note: The R codes in this section requires the codes from the previous sections to be executed first in order to run correctly._

### Motivation

We'll explore the **random forest** algorithm, which can achieve even better accuracy than kNN. Since random forest is computationally intensive, especially during training, we'll use 5-fold cross-validation and tweak the algorithm for faster execution. After running the code, the algorithm is optimized, and we fit the final model, we can see a higher accuracy than kNN. Further tuning could improve accuracy even more.




### Key Steps

1. Set hyperparameters and train model
2. Obtain predictions for test data and compute accuracy

### Key Takeaways

- **Computational Intensity**: Training is slower for random forest, but predictions are faster compared to kNN.
- **Accuracy**: With random forest, higher accuracy may be possible, with room for further improvement through additional tuning.

### Libraries Used

- **`caret`**: For training and tuning machine learning models.
- **`tidyverse`**: For data manipulation and visualization.
- **`dslabs`**: Contains the MNIST dataset.
- **`randomForest`**: To create random forests.
