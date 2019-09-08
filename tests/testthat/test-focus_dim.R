
library(testthat)
## library(rcw)

source("../../R/focus.R")


test_that("2 dimensions work", {
    expected <-
        list(
            list(value = "PRINTO01 - BEL"),
            list(value = "PRINTO01 - FIN")
        )
    res <- focus_dim(x = list("PRINTO01", c("BEL", "FIN")))
    expect_equal(res, expected)
})


test_that("5 dimensions work", {
    expected <-
        list(
            list(value = "PRINTO01 - BEL - 2010 - AUT - PCT"),
            list(value = "PRINTO01 - FIN - 2010 - AUS - ABS"),
            list(value = "PRINTO01 - BEL - 2010 - USA - PCT"),
            list(value = "PRINTO01 - FIN - 2010 - CAN - ABS")
        )
    res <- focus_dim(x = list("PRINTO01",
                              c("BEL", "FIN"),
                              c("2010"),
                              c("AUT", "AUS", "USA", "CAN"),
                              c("PCT", "ABS")))
    expect_equal(res, expected)
})
