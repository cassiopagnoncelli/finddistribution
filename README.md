# Find Distribution

Infers distribution for a given data set.

-   **Input**: A numeric data set (univariate or multivariate)
-   **Output**: Its best fit distribution found

``` r
> x <- rf(10000, 5, 8)
> find_distribution(x)
      pf | error
-------- | ---------
      df | 0.1717962
  dgamma | 0.2105859
  dlnorm | 0.2226137
dweibull | 0.2997514
   dnorm | 0.5110258
    dexp | 0.9432531
   dbeta | 2.3016270
```
