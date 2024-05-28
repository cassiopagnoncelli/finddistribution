test_that("find distribution: F", {
  x <- rf(10000, 5, 8)
  ret <- find_distribution(x)
  expect_true("df" %in% ret$ranking$pf[1:3])
})

test_that("find distribution: normal", {
  x <- rnorm(1000, 100, 15)
  ret <- find_distribution(x)
  ret
  expect_true("dnorm" %in% ret$ranking$pf[1:3])
})
