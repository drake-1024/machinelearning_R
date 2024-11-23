# ROC and Precision-Recall Curves

## Motivation
When evaluating methods, such as guessing versus using a height cutoff for classification, comparing accuracy or F1 scores alone can be limiting. For guessing, we typically assume equal probabilities, though higher probabilities for certain outcomes (e.g., guessing "Male" more frequently in a biased sample) can increase accuracy at the cost of sensitivity. To address these trade-offs, we use graphical comparisons.

**Receiver Operating Characteristic (ROC) curves** plot **Sensitivity** against **Precision (1 - Specificity)**, allowing us to compare methods across varying cutoffs. This curve demonstrates the dominance of one method over another across all thresholds. Additionally, for scenarios where prevalence impacts evaluation, **Precision-Recall (PR) curves** provide a better representation by plotting **Precision** against **Recall (Sensitivity)**.


## Key Steps

1. **Data Simulation for Guessing**: Simulate random predictions using varying probabilities of guessing "Male" versus "Female." Then, compute sensitivity, specificity, and precision for each probability.

2. **Data Simulation for Height Cutoff**: Create predictions based on whether height exceeded predefined cutoff values. Then, compute sensitivity, specificity, and precision for each cutoff.

3. **ROC Curves**: Plot Sensitivity against Precision (1 - specificity) for both methods.

4. **Precision-Recall Curves**: Plot Precision against Recall to highlight differences in precision due to prevalence.

5. **Comparison by Reclassifying Positives**: Re-evaluate PR curves by redefining "positives" (e.g., treating Males as positive). Notice how precision changes with prevalence.


## Key Takeaways

- **ROC Curve Insights**:
  - The guessing approach follows the identity line, as expected for random predictions.
  - The height cutoff method consistently outperforms guessing, achieving higher sensitivity for all values of specificity.
  - ROC curves have one weakness - neither measures depend on prevalence.

- **Precision-Recall Curve Insights**:
  - Guessing exhibits low precision due to the low prevalence of "Male" in the sample.
  - Reclassifying Males as positive increases prevalence and improves precision in PR curves, emphasizing the prevalence-dependence of precision.

## Libraries Used
- **`ggplot2`**: For creating custom ROC and PR plots.
- **`ggrepel`**: To add non-overlapping labels for better visualization.
- **`purrr`**: To map functions over sequences and generate data.
- **`caret`**: For sensitivity, specificity, and precision computations.
