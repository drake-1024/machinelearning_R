# Local Weighted Regression (loess)
_Note: The R codes in this section requires the codes from the previous sections to be executed first in order to run correctly._

### Motivation

The motivation behind this exercise is to explore how local weighted regression, or **loess** (locally estimated scatterplot smoothing), can provide a more flexible approach to fitting smooth curves to data compared to traditional methods like bin smoothing. Unlike bin smoothing, which assumes that the data is approximately constant within a fixed window, loess assumes the data is **locally linear**. This allows for a more accurate representation of the underlying trends in the data, especially when those trends are non-linear. By fitting a linear model within each local window around a data point, loess adapts to changes in the data more effectively, making it ideal for time series or other datasets where relationships may change over time.

A key part of this exercise is to understand the impact of different **window** sizes, or **spans**, on the smoothness of the fitted curve. By adjusting the span, we can control how much data is considered in each local model and how closely the fitted curve follows the data. A larger span means that more points are included in the fit, resulting in a smoother curve, while a smaller span focuses on fewer points, allowing the model to better capture local fluctuations. This exercise demonstrates the trade-off between smoothing the data too much, losing important details, and smoothing too little, resulting in overfitting.

Additionally, this method incorporates a **weighted** approach to fitting, where closer points to the center of each window are given more weight. This helps emphasize the more relevant data points for fitting the local model, making the regression more accurate and reflective of the true trend. The use of different spans and the incorporation of weights allow loess to provide a robust, flexible tool for handling complex datasets and capturing underlying patterns that other smoothing methods may miss.

### Key Steps

#### Visualizing Loess Smoothing with Weights

1. **Calculate Span and Weights**: Calculate the span as a proportion of the total range of days, then compute the weights for each data point using the Tukey tri-weight function based on the distance from a center point.
2. **Filter Data and Visualize**: Filter the dataset for specific center days, then visualize the original data points along with smoothed lines, highlighting the influence of the calculated weights.

#### Fitting and Visualizing Loess Smoothing

3. **Fit Loess Model and Plot**: Calculate the span as a proportion of the total range of days. Fit a loess model, add the smoothed values to the dataset, and visualize.

#### Compare Loess Fits with Different Spans

4. **Define span values**: Choose a set of span values (e.g., 0.66, 0.25, 0.15, and 0.10).
5. **Fit loess models for each span**: Fit separate loess models for each span value and augment the results using `broom::augment` to add fitted values to the dataset.
6. **Visualize and Compare**: Visualize the different loess fits for each span by plotting the smoothed lines for each span value.

### Key Takeaways

- **Flexible**: Loess offers a flexible approach to smoothing data by fitting a local linear model within each window of data points, rather than assuming constant values as in bin smoothing. This allows for better handling of non-linear trends in the data.
- **Impact of Window Size (Span)**: Larger spans result in smoother curves, as more data points are used, while smaller spans allow the model to capture local variations more precisely, but may lead to overfitting.
- **Weighted Fitting**: Loess uses a weighted approach where points closer to the center of the window are given more importance. This helps improve the accuracy of the fit by focusing on more relevant data points while still considering surrounding points.

### Libraries Used

- **`broom`**: For tidying model outputs.
- **`tidyverse`**: For data manipulation and visualization.
- **`dslabs`**: Contains the `polls_2008` dataset
