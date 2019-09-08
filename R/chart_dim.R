
## x <- list(id = "LOCATION",
##           x = "BEL",
##           y = "CAN",
##           mode = "value")
## chart_dim(x, "ScatterChart")
## chart_dim(x, "BarChart") # returns NULL
chart_dim <- function(x, chart_type) {
    res <-
        switch(chart_type,
               ScatterChart = list(id = x$id, xId = x$x, yId = x$y),
               HorizontalSymbolChart = list(id = x$id),
               VerticalSymbolChart = list(id = x$id),
               StackedBarChart = list(id = x$id, mode = x$mode)
               )
    return(res)
}
