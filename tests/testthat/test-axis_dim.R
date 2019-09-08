
library(testthat)
library(rcw)

source("../../R/axis_dim.R")

x <- list(min = -2,
          max = 6,
          step = 2,
          pivot = -2)

test_that("x_axis works for TimelineChart", {
    expected <- list(step = 2)
    res <- axis_dim(x, chart_type = "RowChart", axis = "x")
    expect_equal(res, expected)
})

test_that("y_axis works for StackedBarChart", {
    expected <- list(min = -2,
                     max = 6,
                     step = 2)
    res <- axis_dim(x, chart_type = "StackedBarChart", axis = "y")
    expect_equal(res, expected)
})
