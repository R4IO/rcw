## rcw_ts dataset ----------

rcw_ts <-
  data.frame(
    x = c(2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015),
    y = c(15, -20, 10, 40, 30, 25, 65, 27),
    highlightIndex = c(-1, -1, 0, -1, -1, -1, 1, -1)
  )

readr::write_csv(rcw_ts, "data-raw/rcw_ts.csv")
devtools::use_data(rcw_ts, overwrite = TRUE)

## rcw_rand dataset ----------

n <- 30

rcw_rand <-
  data.frame(
    x = paste0("label", seq(1, n)),
    y = sample(seq(-20, 100), size = n, replace = TRUE),
    highlightIndex = rep(-1L, n),
    baselineIndex = rep(-1L, n),
    stringsAsFactors = FALSE
  )

rcw_rand$x[1] <- "lalala hello things end "
rcw_rand$baselineIndex[4] <- 0L
rcw_rand$y[8] <- 15
rcw_rand$highlightIndex[8] <- 0L
rcw_rand$y[11] <- -5
rcw_rand$highlightIndex[11] <- 1L
rcw_rand$y[12] <- -20.1

readr::write_csv(rcw_rand, "data-raw/rcw_rand.csv")
devtools::use_data(rcw_rand, overwrite = TRUE)

## dplyr::tbl_df(rcw_rand)


## rcw_sym2 dataset ----------

rcw_sym2 <-
  data.frame(
    x = c("Hungary", "Sweden", "Estonia", "Finland", "Belgium", "Turkey", "France", "Poland", "Slovenia", "European Union", "Euro area (18 countries)", "Ireland", "Italy", "Slovak Republic", "Portugal", "South Africa", "Spain (2 digits)"),
    y = c(5.5, 5.6, 5.7, 5.8, 5.9, 6, 6.5, 6.6, 6.8, 7.4, 8.2, 8.7, 8.9,
          9.9, 10.9, 12.3, 16.86),
    highlightIndex = c(-1L, -1L, -1L, -1L, -1L, -1L, -1L, -1L, -1L, -1L, -1L, 0L, -1L, -1L, -1L, 1L, -1L),
    baselineIndex = c(-1L, -1L, -1L, -1L, -1L, -1L, -1L, -1L, -1L, 0L, -1L, -1L, -1L, -1L, -1L, -1L, -1L)
  )

readr::write_csv(rcw_sym2, "data-raw/rcw_sym2.csv")
devtools::use_data(rcw_sym2, overwrite = TRUE)


## rcw_stacked dataset ----------

stacked_list <-
  rjson::fromJSON('[{
  "datapoints": [
    { "x": 0, "y": [21, 24, 63, 11, 11] },
    { "x": 1, "y": [34, null, 15, 23, 9] },
    { "x": 2, "y": [55, 65, 32, 35, 7] },
    { "x": 3, "y": [62, 82, 27, 21, 13] },
    { "x": 4, "y": [10, 73, 54, 24, 4], "highlightIndex": 0 },
    { "x": 5, "y": [0, 16, 92, 32, 9] },
    { "x": 6, "y": [32, 53, 18, 34, 12] },
    { "x": 7, "y": [-68, 53, 41, 21, -7] },
    { "x": 8, "y": [42, 46, 83, 13, 15] },
    { "x": 9, "y": [28, 38, 22, 17, 7], "baselineIndex": 0 },
    { "x": 10, "y": [36, 52, 62, 23, 14] },
    { "x": 11, "y": [-29, -64, -33, -39, -10], "highlightIndex": 1 }
  ],
  "layerSeries": [
    { "id": 1, "label": "layer 1" },
    { "id": 2, "label": "layer 2" },
    { "id": 3, "label": "layer 3" },
    { "id": 4, "label": "layer 4" },
    { "id": 5, "label": "layer 5" }
  ]
}]')

dp <- stacked_list[[1]][["datapoints"]]
x <- sapply(dp, function(item) item$x)

y1 <- sapply(dp, function(item) ifelse(is.null(item$y[[1]]), NA, item$y[[1]]))
y2 <- sapply(dp, function(item) ifelse(is.null(item$y[[2]]), NA, item$y[[2]]))
y3 <- sapply(dp, function(item) ifelse(is.null(item$y[[3]]), NA, item$y[[3]]))
y4 <- sapply(dp, function(item) ifelse(is.null(item$y[[4]]), NA, item$y[[4]]))
y5 <- sapply(dp, function(item) ifelse(is.null(item$y[[5]]), NA, item$y[[5]]))

stacked_df <- data.frame(
  x = x,
  layer1 = y1,
  layer2 = y2,
  layer3 = y3,
  layer4 = y4,
  layer5 = y5
)

library(tidyr)
library(magrittr)

rcw_stacked <-
  stacked_df %>%
  gather(key = layer, value = y, -x)

readr::write_csv(rcw_stacked, "data-raw/rcw_stacked.csv")
devtools::use_data(rcw_stacked, overwrite = TRUE)
