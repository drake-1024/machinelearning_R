#### 1. Load the dataset and inspect the dimensions

# Load the dslabs package, which contains the MNIST dataset utilities
library(dslabs)

# Load the MNIST dataset into the workspace
mnist <- read_mnist()

# Display the dimensions of the training images dataset (rows: number of images, columns: pixels per image)
dim(mnist$train$images)



#### 2. Obtain a subset of the training and testing data

# Set the seed for reproducibility of random sampling
set.seed(1990)

# Randomly sample 10,000 rows from the training images dataset
index <- sample(nrow(mnist$train$images), 10000)

# Subset the sampled training images into a new object `x`
x <- mnist$train$images[index,]

# Subset the corresponding sampled training labels and convert them to factors
y <- factor(mnist$train$labels[index])

# Randomly sample 1,000 rows from the test images dataset
index <- sample(nrow(mnist$test$images), 1000)

# Subset the sampled test images into a new object `x_test`
x_test <- mnist$test$images[index,]

# Subset the corresponding sampled test labels and convert them to factors
y_test <- factor(mnist$test$labels[index])



#### 3. Identify and remove columns with almost zero variability

# Load the matrixStats package to compute statistical summaries of matrices
library(matrixStats)

# Compute the standard deviations of each column (pixel) in the sampled training images
sds <- colSds(x)

# Plot a histogram of the standard deviations with 256 bins and black-colored bars
ggplot(data = data.frame(sds = sds), aes(x = sds)) +
  geom_histogram(bins = 256, color = "black")
  theme_minimal()

# Load the caret package, which includes tools for preprocessing data
library(caret)

# Identify near-zero variance columns (pixels) in the training images
nzv <- nearZeroVar(x)

# Visualize the near-zero variance columns on a 28x28 pixel grid (image size)
image(matrix(1:784 %in% nzv, 28, 28))

# Exclude the near-zero variance columns from the column index
col_index <- (1:ncol(x))[-nzv]

# Output the number of remaining columns after removing near-zero variance columns
length(col_index)
