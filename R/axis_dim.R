
#' create axis
#'
#' @examples
#' x <- list(min = -2, max = 6, step = 2, pivot = -2)
#' axis_dim(x, chart_type = "RowChart", axis = "x")
#' axis_dim(x, chart_type = "StackedBarChart", axis = "y")

axis_dim <- function(x, chart_type, axis) {
    try(x2 <- list(linear =
                       list(min = x$min, max = x$max, step = x$step,
                            pivot = list(value = x$pivot)))
        )
    res <-
        switch(axis,
               x = axis_dim_x(x2, chart_type),
               y = axis_dim_y(x2, chart_type)
               )
    return(res)
}

axis_dim_x <- function(x, chart_type) {
    if (chart_type == "TimelineChart") {
        res <- list(step = x$step)
    } else {
        res <- x
    }
    return(res)
}

axis_dim_y <- function(x, chart_type) {
    ## no pivot
    if (chart_type == "StackedBarChart") {
        res <- list(
            min = x$min,
            max = x$max,
            step = x$step
        )
    } else {
        res <- x
    }
    return(res)
}

