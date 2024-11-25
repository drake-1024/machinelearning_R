# Bin Smoothing and Kernels
_Note: The R codes in this section requires the codes from the previous sections to be executed first in order to run correctly._

### Motivation

We want to demonstrate the concept of **smoothing**, which is used to estimate an underlying function by grouping data points into strata where the value of the function is assumed to be constant. The idea is based on the assumption that the function f(x) changes slowly over time, and that within small windows, the value of f(x) remains nearly constant. By smoothing, we can estimate this underlying curve by averaging values within defined time windows. 

In this case, we use the 2008 polling data and assume that public opinion remains relatively stable within a week's time. This assumption allows us to treat the values of the polling data for the week (+/- 3.5-day window) as constant, which enables us to compute smoothed estimates for public opinion over time. The exercise shows how smoothing helps create smoother representations of the data, enhancing our ability to discern trends and patterns.

### Key Steps

1. **Define Span and Prepare Data**: Set the span for smoothing and create a temporary dataset by crossing each day with every other day to calculate the distance between them.

2. **Filter and Visualize Specific Centers**: Filter the data for specific center values (e.g., -125, -55), and create a scatter plot, adding smoothed lines using linear models.

3. **Apply Kernel Smoothing with Box Kernel**: Update the span, apply kernel smoothing with the "box" kernel, and store the smoothed values in a new column in the dataset. Plot the original data points and the smoothed line.

4. **Apply Kernel Smoothing with Normal Kernel**: Apply smoothing using the "normal" kernel, and add the smoothed values to the dataset. Plot the data with the smoothed line in red for the "normal" kernel.

### Key Takeaways

- **Smoothing** is the process of estimating the underlying curve of a function by averaging values within a defined window.
- The **window size** (also called **bandwidth** or **span**) defines how much surrounding data is considered when smoothing the function.
- By using **bin smoothing**, we compute the average of the values within the window for each point. This process produces a **wiggly curve** that can be smoothed further by assigning different weights to the points using weighted averages.
- The `ksmooth()` function in R allows us to apply **kernel smoothing** with different kernel types (e.g., box and normal). A **box kernel** assigns equal weights to all points in the window, while a **normal kernel** assigns higher weights for points closer to the center of the window, and the weights decay smoothly as you move farther away from the center. This helps reduce abrupt changes between neighboring estimates and provides a smoother trend.

### Libraries Used

- **`ggplot2`**: For data visualization and plotting, especially for visualizing the original and smoothed data.
- **`dplyr`**: For data manipulation, particularly when filtering and preparing data for analysis.
