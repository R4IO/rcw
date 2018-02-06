#' Function for creating rcw D3 graphs.
#'
#' \code{rcwChart} creates simple D3 JavaScript graphs.
#'
#' @param data a data frame object with three columns. The first column
#'   corresponds to the x-axis, the second to the y-axis and the third indicates
#'   the highlighting pattern: negative integers indicate non-highlighted
#'   values, odd and even numbers are distinguished with permanent color
#'   highlighting, odd numbers include zero.
#' @param type a valid chart type e.g. \code{"bar"}, \code{"scatter"},
#'   \code{"row"} etc.
#' @param height height for the graph's frame area in pixels (if
#'   \code{NULL} then height is automatically determined based on context)
#' @param width numeric width for the graph's frame area in pixels (if
#'   \code{NULL} then width is automatically determined based on context)
#'
#' @examples
#' rcwData <- data.frame(
#'   x = c(1000, 1001, 1010, 1011, 1100, 1101, 1110, 1111),
#'   y = c(15, -20, 10, 40, 30, 25, 65, 27),
#'   highlightIndex = c(-1, -1, 0, -1, -1, -1, 1, -1))
#' rcwChart(rcwData, type = "bar")
#'
#' @source D3.js was created by Michael Bostock, see \url{http://d3js.org/}.
#'
#' @export
rcwChart <- function(data,
                     type=stop("'type' must be provided"),
                     height = "400", # 300
                     width = "800",
                     ...) { # 600

  dataJson <- rcwData(data=data, type=type, x=x, y=y, fill=fill)

  ## create options
  chartOptions = list(
    base = list(width = width, height = height)
  )

  chartOptionsJson <-
    htmlwidgets:::toJSON2(chartOptions)

  ## pass the data and settings using 'x'
  x <- list(
    type = type,
    data = dataJson,
    options = chartOptionsJson
  )

  ## create widget
  ## htmlwidgets::createWidget(
  ##     name = "rcwChart",
  ##     x = list(data = dataJson, options = chartOptions),
  ##     width = width,
  ##     height = height,
  ##     htmlwidgets::sizingPolicy(padding = 0, browser.fill = TRUE),
  ##     package = "rcwPkg"
  ## )
  htmlwidgets::createWidget(name = "rcwChart",
                            x = x,
                            width = width, height = height,
                            package = "rcw")

}


#' @rdname rcwChart
#' @export
rcwChartOutput <- function(outputId, width = "100%", height = "500px") {
  shinyWidgetOutput(outputId, "rcwChart", width, height,
                    package = "rcw")
}


#' @rdname rcwChart
#' @export
renderrcwChart <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, rcwChartOutput, env, quoted = TRUE)
}


#' @rdname rcwChart
#' @export
rcwData <- function(data, type, x, y, fill="layer") {

  ## validate input
  ## if (!is.list(data))
  ##   stop("data must be a list class object.")
  ## dataJson <- htmlwidgets:::toJSON2(data)
  if (!is.data.frame(data))
    stop("data must be a data frame class object.")

  if (type == "stacked") {
    data_w <- tidyr::spread_(data, key = fill, value = y)

    cols <- unique(data[[fill]])
    cols_idx <- match(cols, names(data_w))

    dp <- list()
    ## i <- 1
    for (i in c(1:nrow(data_w))) {
      dp[[i]] <- list(x = data_w$x[[i]],
                      y = unname(unlist(data_w[i, cols_idx])))
    }

    layer <- list()
    for (i in seq(along = cols)) {
      layer[[i]] <- list(id = i,
                         label = cols[i])
    }

    dat <- list(datapoints = dp,
                layerSeries = layer)
  } else {
    dat <- list(datapoints = data)
  }
  dataJson <- jsonlite::toJSON(list(dat))
  return(dataJson)
}
## library(rcw)
## fill <- "layer"
## x <- "x"
## y <- "y"
## data <- rcw_stacked
##   head(data)
