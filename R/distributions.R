# PDF/PMF database.

pfdb <<- data.frame(
  name = c(),
  pf = c(),
  discrete = c(),
  domain = c(),
  exotic = c()
)

pfdb_params <<- list()

insert_prob_function <- function(name,
                                 pf,
                                 discrete,
                                 domain,
                                 params,
                                 exotic = TRUE) {
  row <- data.frame(
    name = name,
    pf = pf,
    discrete = discrete,
    domain = domain,
    exotic = exotic
  )
  pfdb <<- rbind(pfdb, row)
  pfdb_params[[pf]] <<- params
}

# Continuous
insert_prob_function(
  name = 'normal',
  pf = 'dnorm',
  discrete = FALSE,
  domain = 'REAL',
  params = data.frame(
    name = c('mean', 'sd'),
    min = c(-Inf, 0),
    max = c(Inf, Inf),
    discrete = c(FALSE, FALSE),
    initial = c(0, 1)
  ),
  exotic = FALSE
)

insert_prob_function(
  name = 'log-normal',
  pf = 'dlnorm',
  discrete = FALSE,
  domain = 'NONNEGATIVE',
  params = data.frame(
    name = c('mean', 'sd'),
    min = c(1e-5, 1e-5),
    max = c(1e6, 1e6),
    discrete = c(FALSE, FALSE),
    initial = c(1, 1)
  ),
  exotic = FALSE
)

insert_prob_function(
  name = 'beta',
  pf = 'dbeta',
  discrete = FALSE,
  domain = 'NONNEGATIVE',
  params = data.frame(
    name = c('shape1', 'shape2'),
    min = c(1e-6, 1e-6),
    max = c(1e6, 1e6),
    discrete = c(FALSE, FALSE),
    initial = c(1, 1)
  ),
  exotic = FALSE
)

insert_prob_function(
  name = 'gamma',
  pf = 'dgamma',
  discrete = FALSE,
  domain = 'NONNEGATIVE',
  params = data.frame(
    name = c('shape', 'rate'),
    min = c(1e-6, 1e-6),
    max = c(1e6, 1e6),
    discrete = c(FALSE, FALSE),
    initial = c(0, 1)
  ),
  exotic = FALSE
)

insert_prob_function(
  name = 'exponential',
  pf = 'dexp',
  discrete = FALSE,
  domain = 'NONNEGATIVE',
  params = data.frame(
    name = c('rate'),
    min = c(0),
    max = c(Inf),
    discrete = c(FALSE),
    initial = c(1)
  ),
  exotic = FALSE
)

insert_prob_function(
  name = 'f',
  pf = 'df',
  discrete = FALSE,
  domain = 'NONNEGATIVE',
  params = data.frame(
    name = c('df1', 'df2'),
    min = c(1e-5, 1e-5),
    max = c(1e5, 1e5),
    discrete = c(FALSE, FALSE),
    initial = c(10, 10)
  ),
  exotic = FALSE
)

## NEEDS AMENDING a < b.
#insert_prob_function('uniform', 'dunif', FALSE, 'REAL',
#         data.frame(
#           name=c('a', 'b'),
#           min=c(-Inf, -Inf),
#           max=c(Inf, Inf),
#           discrete=c(FALSE, FALSE),
#           initial=c(0, 0)),
#         FALSE)

insert_prob_function(
  name = 'weibull',
  pf = 'dweibull',
  discrete = FALSE,
  domain = 'NONNEGATIVE',
  params = data.frame(
    name = c('shape', 'scale'),
    min = c(1e-6, 1e-6),
    max = c(1e6, 1e6),
    discrete = c(FALSE, FALSE),
    initial = c(1, 1)
  ),
  exotic = FALSE
)

insert_prob_function(
  name = 'chi squared',
  pf = 'dchisq',
  discrete = TRUE,
  domain = 'NONNEGATIVE',
  params = data.frame(
    name = c('df'),
    min = c(0),
    max = c(Inf),
    discrete = c(TRUE),
    initial = c(100)
  ),
 exotic = FALSE
)

insert_prob_function(
  name = 't',
  pf = 'dt',
  discrete = TRUE,
  domain = 'REAL',
  params = data.frame(
    name = c('df'),
    min = c(0),
    max = c(Inf),
    discrete = c(TRUE),
    initial = c(100)
  ),
  exotic = FALSE
)

# Discrete
insert_prob_function(
  name = 'binomial',
  pf = 'dbinom',
  discrete = TRUE,
  domain = 'NONNEGATIVE',
  params = data.frame(
    name = c('size', 'prob'),
    min = c(0, 0),
    max = c(Inf, 1),
    discrete = c(TRUE, FALSE),
    initial = c(50, 0.5)
  ),
  exotic = FALSE
)

insert_prob_function(
  name = 'negative binomial',
  pf = 'dnbinom',
  discrete = TRUE,
  domain = 'NONNEGATIVE',
  params = data.frame(
    name = c('size', 'prob'),
    min = c(0, 0),
    max = c(Inf, 1),
    discrete = c(TRUE, FALSE),
    initial = c(100, 0.5)
  ),
  exotic = FALSE
)

insert_prob_function(
  name = 'poisson',
  pf = 'dpois',
  discrete = TRUE,
  domain = 'NONNEGATIVE',
  params = data.frame(
    name = c('lambda'),
    min = c(0),
    max = c(Inf),
    discrete = c(FALSE),
    initial = c(100)
  ),
  exotic = FALSE
)

insert_prob_function(
  name = 'geometric',
  pf = 'dgeom',
  discrete = TRUE,
  domain = 'NONNEGATIVE',
  params = data.frame(
    name = c('prob'),
    min = c(0),
    max = c(1),
    discrete = c(FALSE),
    initial = c(0.5)
  ),
  exotic = FALSE
)

insert_prob_function(
  name = 'hypergeometric',
  pf = 'dhyper',
  discrete = TRUE,
  domain = 'NONNEGATIVE',
  params = data.frame(
    name = c('m', 'n', 'k'),
    min = c(0, 0, 0),
    max = c(Inf, Inf, Inf),
    discrete = c(TRUE, TRUE, TRUE),
    initial = c(10, 10, 10)
  ),
  exotic = FALSE
)
