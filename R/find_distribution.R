#
# Find the distribution of a given set.
#
# Idea:
# 1. Extend the dataset with bootstrap if it is too small
# 2. Classify the data (eg. real or non-negative or positive, integer or continuous
# 3. Find the best parameters for each distribution
# 4. List the distributions with the best fitting ranked by the most likely distributions
#

# TODO
# 1. include parameters restrictions in RMSE, eg. a < b in runif.
# 2. solve the warnings().
#

# Find the most fit distributions for the given data.
find_distribution <- function(x,
                              include.exotics = FALSE,
                              remove.na = TRUE,
                              search.combinations = TRUE,
                              verbose = FALSE) {
  # Key data information.
  ds <- distribution_profile(x)

  # List PMF/PDF candidates.
  candidates <- pfdb[pfdb$discrete == ds$is_discrete,]
  if (!include.exotics) {
    candidates <- candidates[candidates$exotic == FALSE,]
  }
  if (NROW(candidates) == 0) {
    message("No candidate distribution to test dataset against")
  }

  # Estimate probability density/mass function.
  # TODO: Fixme ds$is_discrete
  if (ds$is_discrete) {
    f <- hist(x, breaks=(min(x)-0.5):(max(x)+0.5), plot=F)
    f.x <- f$mids
    f.y <- f$density
  } else {
    f <- density(x, from=min(x), to=max(x))
    f.x <- f$x
    f.y <- f$y
  }

  # Perform optimization across candidates
  ranking <- data.frame(pf = character(0), error = numeric(0))
  best_params <- list()
  for (i in seq_len(NROW(candidates))) {
    candidate <- candidates[i,]

    if (verbose) {
      cat(paste("Testing", candidate$name, "distribution... "))
    }

    params_meta <- pfdb_params[[candidate$pf]]

    conv.params <- function(params) {
      b <- as.logical(params_meta$discrete)
      for (i in seq_len(length(params))) {
        if (b[i]) {
          params[i] <- round(params[i])
        }
      }
      return(params)
    }

    rmse <- function(params) {
      sqrt(sum((do.call(
        as.character(candidate$pf),
        append(list(f.x), as.list(conv.params(params)))) - f.y)^2))
    }

    if (sum(params_meta$discrete) > 0) {
      o <- GenSA::GenSA(
        params_meta$initial,
        rmse,
        lower = params_meta$min,
        upper = params_meta$max,
        control = list(maxit = 10000)
      )
    } else {
      o <- optim(
        params_meta$initial,
        rmse,
        lower = params_meta$min,
        upper = params_meta$max,
        method = 'L-BFGS-B',
        control = list()
      )
    }

    ranking <- rbind(ranking, data.frame(pf=candidate$pf, error=o$value))
    best_params[[as.character(candidate$pf)]] <- conv.params(o$par)

    if (o$counts[1] <= 2) {
      print(o)
    }

    if (verbose) {
      cat("OK\n")
    }
  }

  ranking <- ranking[order(ranking$error),]

  list(params=best_params, ranking=ranking)
}
