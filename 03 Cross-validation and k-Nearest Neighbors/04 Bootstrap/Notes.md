# Bootstrap

Bootstrapping allows us to approximate a Monte Carlo simulation without access to the entire distribution. We act as if the observed sample is the population. Next, we sample datasets (with replacement) of the same sample size as the original dataset. Finally, we compute the summary statistic, in this case the median, on these bootstrap samples.

Suppose the income distribution of your population is as follows:

```
set.seed(1995)
n <- 10^6
income <- 10^(rnorm(n, log10(45000), log10(3)))
qplot(log10(income), bins = 30, color = I("black"))
```

The population median is:

```
m <- median(income)
m
#> [1] 44939
```

However, if we don't have access to the entire population but want to estimate the median, we can take a sample of 100 and estimate the population median using the sample median _M_, like this:

```
N <- 100
X <- sample(income, N)
median(X)
#> [1] 38461
```

Now let's consider constructing a confidence interval and determining the distribution of _M_.

Because we are simulating the data, we can use a Monte Carlo simulation to learn the distribution of _M_ using the following code:

```
library(gridExtra)
B <- 10^4
M <- replicate(B, {
  X <- sample(income, N)
  median(X)
})
p1 <- qplot(M, bins = 30, color = I("black"))
p2 <- qplot(sample = scale(M), xlab = "theoretical", ylab = "sample") + 
  geom_abline()
grid.arrange(p1, p2, ncol = 2)
```

Knowing the distribution allows us to construct a confidence interval. However, as we have discussed before, in practice, we do not have access to the distribution. In the past, we have used the Central Limit Theorem (CLT), but the CLT we studied applies to averages and here we are interested in the median. If we construct the 95% confidence interval based on the CLT using the code below, we see that it is quite different from the confidence interval we would generate if we knew the actual distribution of _M_.

```
median(X) + 1.96 * sd(X) / sqrt(N) * c(-1, 1)
#> [1] 21017 55904
```

```
quantile(M, c(0.025, 0.975))
#>  2.5% 97.5% 
#> 34438 59050
```

The bootstrap permits us to approximate a Monte Carlo simulation without access to the entire distribution. The general idea is relatively simple. We act as if the observed sample is the population. We then sample (with replacement) datasets, of the same sample size as the original dataset. Then we compute the summary statistic, in this case the median, on these bootstrap samples.

Theory tells us that, in many situations, the distribution of the statistics obtained with bootstrap samples approximate the distribution of our actual statistic. We can construct bootstrap samples and an approximate distribution using the following code:

```
B <- 10^4
M_star <- replicate(B, {
  X_star <- sample(X, N, replace = TRUE)
  median(X_star)
})
```

The confidence interval constructed using the bootstrap is much closer to the one constructed with the theoretical distribution, as you can see by using this code:

```
quantile(M_star, c(0.025, 0.975))
#>  2.5% 97.5% 
#> 30253 56909
```

Note that we can use ideas similar to those used in the bootstrap in cross-validation: instead of dividing the data into equal partitions, we can simply bootstrap many times.
