# Load the ggrepel library for text label repelling
library(ggrepel)

# Set the random seed for reproducibility
set.seed(2024)

# Generate data for the ROC curve using random guessing probabilities
probs <- seq(0, 1, length.out = 11)  # Create a sequence of probabilities from 0 to 1
guessing <- map_df(probs, function(p) {
  y_hat <- sample(c("Male", "Female"), n, replace = TRUE, prob = c(p, 1 - p)) %>%
    factor(levels = c("Female", "Male"))  # Generate random predictions
  list(
    method = "Guessing",                # Label the method as "Guessing"
    label = p,                          # Include the probability as the label
    FPR = 1 - specificity(y_hat, test_set$sex),  # Compute False Positive Rate (1 - Specificity)
    TPR = sensitivity(y_hat, test_set$sex),     # Compute True Positive Rate (Sensitivity)
    precision = precision(y_hat, test_set$sex)  # Compute precision
  )
})

# Generate data for the ROC curve using height-based cutoff predictions
cutoffs <- c(50, seq(60, 75), 80)  # Define height cutoffs for predictions
height_cutoff <- map_df(cutoffs, function(x) {
  y_hat <- ifelse(test_set$height > x, "Male", "Female") %>%
    factor(levels = c("Female", "Male"))  # Predict based on height cutoff
  list(
    method = "Height cutoff",            # Label the method as "Height cutoff"
    label = x,                           # Include the cutoff as the label
    FPR = 1 - specificity(y_hat, test_set$sex),  # Compute False Positive Rate
    TPR = sensitivity(y_hat, test_set$sex),     # Compute True Positive Rate
    precision = precision(y_hat, test_set$sex)  # Compute precision
  )
})

# Plot both the "Guessing" and "Height cutoff" ROC curves together
bind_rows(guessing, height_cutoff) %>%  # Combine the two datasets
  ggplot(aes(FPR, TPR, color = method, label = label)) +  # Plot FPR vs. TPR
  geom_line() +                                           # Add lines to the plot
  geom_point() +                                          # Add points for each label
  geom_text_repel(nudge_x = 0.01, nudge_y = -0.01, size = 3, show.legend = FALSE) +  # Repel text labels
  xlab("FPR (1 - Specificity)") +                        # Label x-axis
  ylab("TPR (Sensitivity)")                              # Label y-axis

# Plot precision against recall (TPR)
bind_rows(guessing, height_cutoff) %>%  # Combine the two datasets
  ggplot(aes(TPR, precision, color = method, label = label)) +  # Plot TPR vs. Precision
  geom_line() +                                                 # Add lines to the plot
  geom_point() +                                                # Add points for each label
  geom_text_repel(nudge_x = 0.01, nudge_y = -0.01, size = 3, show.legend = FALSE) +  # Repel text labels
  xlab("TPR (Recall)") +                                        # Label x-axis
  ylab("Precision") +                                           # Label y-axis
  ylim(0, 1)                                                   # Set y-axis limits to [0, 1]

# Repeat the process for predictions switching from "Female" to "Male" predictions

set.seed(2024)  # Reset the random seed

# Generate data for guessing probabilities with levels switched to "Male" first
guessing <- map_df(probs, function(p) {
  y_hat <- sample(c("Male", "Female"), n, replace = TRUE, prob = c(p, 1 - p)) %>%
    factor(levels = c("Male", "Female"))  # Predict with levels reordered
  list(
    method = "Guessing",                            # Label the method as "Guessing"
    label = p,                                      # Include the probability as the label
    TPR = sensitivity(y_hat, relevel(test_set$sex, "Male")),  # Compute TPR for "Male"
    precision = precision(y_hat, relevel(test_set$sex, "Male"))  # Compute precision for "Male"
  )
})

# Generate data for height-based cutoff predictions with levels switched to "Male" first
height_cutoff <- map_df(cutoffs, function(x) {
  y_hat <- ifelse(test_set$height > x, "Male", "Female") %>%
    factor(levels = c("Male", "Female"))  # Predict based on height cutoff with levels reordered
  list(
    method = "Height cutoff",                      # Label the method as "Height cutoff"
    label = x,                                     # Include the cutoff as the label
    TPR = sensitivity(y_hat, relevel(test_set$sex, "Male")),  # Compute TPR for "Male"
    precision = precision(y_hat, relevel(test_set$sex, "Male"))  # Compute precision for "Male"
  )
})

# Plot precision against recall (TPR) for the new predictions
bind_rows(guessing, height_cutoff) %>%  # Combine the two datasets
  ggplot(aes(TPR, precision, color = method, label = label)) +  # Plot TPR vs. Precision
  geom_line() +                                                 # Add lines to the plot
  geom_point() +                                                # Add points for each label
  geom_text_repel(nudge_x = 0.01, nudge_y = -0.01, size = 3, show.legend = FALSE) +  # Repel text labels
  xlab("TPR (Recall)") +                                        # Label x-axis
  ylab("Precision") +                                           # Label y-axis
  ylim(0, 1)                                                   # Set y-axis limits to [0, 1]
