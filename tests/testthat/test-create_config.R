
library(testthat)
library(jsonlite)
library(rcw)

source("../../R/focus_dim.R")
source("../../R/chart_dim.R")
source("../../R/axis_dim.R")
source("../../R/create_config.R")
source("../../R/post_config.R")
source("../../R/read_logo.R")

p <- list(
    query = "KEI/PRINTO01+PRMNTO01.AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA.GP.A/all?startTime=2015&endTime=2015",
    ## chart_type = "BarChart",
    chart_type = "ScatterChart",
    ## chart_type = "HorizontalSymbolChart",
    ## chart_type = "StackedBarChart",
    highlight = list("PRINTO01", c("BEL", "FIN")),
    baseline = list("PRMNTO01", "AUS"),
    ## highlight = list(LOCATION = "AUT", TIME_PERIOD = 2011),
    ## baseline = list(TIME_PERIOD = 2012),
    chart_dimension = list(id = "LOCATION",
                           x = "BEL", y = "CAN",
                           mode = "percent"),
    x_axis = list(min = -2, max = 6, step = 2, pivot = -2),
    ## y_axis = list(min = -2, max = 6, step = 2, pivot = -2),
    ## y_axis = list(min = -2, max = 6, step = 2),
    path = "../../inst/templates/default.json",
   ## owner = FALSE,
   ## source_label = "Key Short-Term Economic Indicators",
    logo = TRUE
    ## logo = FALSE
)

template <- jsonlite::read_json(p$path)
out_dir <- "../target"
if (!dir.exists(paths = out_dir)) dir.create(path = out_dir)
out_file <- file.path(out_dir, "chartconfig.json")

## checks on template
test_that("template file exists", {
    expect_equal(file.exists(p$path), TRUE)
})


test_that("template path exists", {
    path_nonexist <- "../../inst/templates/default2.json"
    error_msg <- paste0("file ", path_nonexist, " not found - are you sure the file exists?")
    ## expect_equal(
    ##     class(create_config(p$query, p$chart_type)),
    ##     "list"
    ## )
    ## expect_equal(
    ##     class(create_config(p$query, p$chart_type, path = p$path)),
    ##     "list"
    ## )
    expect_error(
        create_config(p$query, type = p$chart_type, path = path_nonexist),
        error_msg
    )
})


## checks on output
test_that("creates valid JSON", {
    ## chartconfig <- rcw::create_config(sdmx_data_query = query, type = chart_type)
    chartconfig <- create_config(p$query,
                                 type = p$chart_type,
                                 highlight = p$highlight,
                                 baseline = p$baseline,
                                 chart_dimension = p$chart_dimension,
                                 x_axis = p$x_axis,
                                 ## y_axis = p$y_axis,
                                 path = p$path,
                                 logo = p$logo
                                ## ,owner = p$owner
                                ## ,source_label = p$source_label
                                 )
    ## write file to disk
    post_config(
        config = chartconfig,
        post = FALSE,
        path = out_file,
    )
    expect_equal(
        class(jsonlite::read_json(out_file)),
        "list"
    )
})


test_that("result has correct dimensions", {
    chartconfig <- jsonlite::read_json(out_file)
    expect_equal(names(chartconfig),
                 c("data", "share", "type"))
    expect_equal(names(chartconfig$data),
                 c("data", "options", "config"))
    expect_equal(names(chartconfig$data$options),
                 c("base", "axis"
                   ##, "map", "serie"
                   ))
    ## "map":{"projection":null,"scale":null},
    ## "serie":{"choropleth":{}}
    expect_equal(names(chartconfig$data$config),
                 c("logo", "owner", "terms", "sourceHeaders"))
    expect_equal(chartconfig$share, "latest")
})


## test_that("external URLs exit", {
##     chartconfig <- jsonlite::read_json(out_file)
##     expect_match(
##         chartconfig$data$data$share$source,
##         "https://stats.oecd.org/SDMX-JSON/data/.*"
##     )
##     if (!is.null(chartconfig$data$config$terms$link)) {
##         expect_equal(RCurl::url.exists(chartconfig$data$config$terms$link), TRUE)
##     }
##     if (!is.null(chartconfig$data$config$logo)) {
##         expect_equal(RCurl::url.exists(chartconfig$data$config$logo), TRUE)
##     }
## })
