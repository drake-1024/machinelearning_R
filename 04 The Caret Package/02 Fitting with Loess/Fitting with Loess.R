#### 1. Install the `gam` package for Generalized Additive Models.

install.packages("gam")



#### 2. Check details of the "gamLoess" model.

modelLookup("gamLoess")



#### 3. Define a hyperparameter grid for tuning.

# 'span' controls the amount of smoothing (range: 0.15 to 0.65, divided into 10 values).
# 'degree = 1' specifies that linear (degree-1) fits are used in the local smoothing.
grid <- expand.grid(span = seq(0.15, 0.65, len = 10), degree = 1)



#### 4. Train a LOESS-based model on the training data.

# The response variable is `y`, and all other variables ('.') are predictors.
# 'tuneGrid=grid' specifies the hyperparameter grid for tuning.
train_loess <- train(y ~ ., 
                     method = "gamLoess",
                     tuneGrid = grid,
                     data = mnist_27$train)



#### 5. Visualize hyperparameter tuning results.

# The `highlight` argument emphasizes the best-performing model.
ggplot(train_loess, highlight = TRUE)



##### 6. Evaluate model accuracy on the test set.

# Generate predictions on the test set using the trained LOESS model.
# Compare the predictions with the true labels in the test set to compute the accuracy.
confusionMatrix(data = predict(train_loess, mnist_27$test), 
                reference = mnist_27$test$y)$overall["Accuracy"]



#### 7. Plot predicted conditional probabilities.

# The `type = "prob"` argument returns class probabilities for the second class (index [ ,2]).
p1 <- plot_cond_prob(predict(train_loess, mnist_27$true_p, type = "prob")[,2])
p1
