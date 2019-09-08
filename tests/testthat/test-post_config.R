
library(testthat)
library(jsonlite)

source("../../R/post_config.R")

out_file <- file.path("../target/chartconfig.json")


test_that("config can be posted", {
    chartconfig <- jsonlite::read_json(out_file)
    ## chart_url <-
    res_ls <-
        post_config(config = chartconfig,
                url = "http://dotstatcor-dev2.main.oecd.org/PMShareIntranetService",
                response = TRUE
                ## ,httr::verbose()
                )
    ## browseURL(url = "4deU")
    expect_equal(res_ls$status, "Success")
    ## str(res_ls)
    ## browseURL(url = res_ls$viewer_url)
})
