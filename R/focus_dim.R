#' 2 dimensions
#'
#' @param x a list of character vectors respecting the order of dimensions of
#'     the SDMX data flow
#'
#' @examples
#'
#' focus_dim2(x = list("PRINTO01", c("BEL", "FIN")))
#'
#' list(list(value = "PRINTO01 - BEL"),
#'      list(value = "PRINTO01 - FIN"))

focus_dim2 <- function(x) {
    vec <- paste(x[[1]], x[[2]], sep = " - ")
    vec_ls <- lapply(vec, as.list)
    for (i in seq(along = vec_ls)) names(vec_ls[[i]]) <- "value"
    return(vec_ls)
}


#' n dimensions
#'
#' @param x a list of character vectors respecting the order of dimensions of
#'     the SDMX data flow
#'
#' @examples
#'
#' focus_dim(x = list("PRINTO01"))
#' focus_dim(x = list("PRINTO01", c("BEL", "FIN")))
#' focus_dim(x = list("PRINTO01", c("BEL", "FIN"), c("2010")))
#' focus_dim(x = list("PRINTO01", c("BEL", "FIN"), c("2010"), c("AUT", "AUS", "USA", "CAN"), c("PCT", "ABS")))
#'
#' ## StackedBarChart: only uses first list element
#'
#' focus_dim(x = list(c("PRINTO01", "PRMNTO01"), c("BEL", "FIN")), chart_type = "StackedBarChart")
#' focus_dim(x = list(c("PRINTO01", "PRMNTO01"), c("BEL", "FIN")), chart_type = "ScatterChart")

focus_dim <- function(x, chart_type) {
    if (chart_type %in% c(
                            "BarChart",
                            "RowChart",
                            "HorizontalSymbolChart",
                            "VerticalSymbolChart",
                            "TimelineChart"
                        )) {
        vec_ls <- focus_dim_other(x)
    } else if (chart_type == "StackedBarChart") {
        vec_ls <- focus_dim_other(x[1])
    } else if (chart_type == "ScatterChart") {
        vec_ls <- focus_dim_scatter(x)
    } else stop("invalid 'chart_type' ", chart_type)
    return(vec_ls)
}

## x <- list(LOCATION = "AUT", TIME_PERIOD = 2011)
focus_dim_scatter <- function(x) {
    dim_ids <- names(x)
    if (length(dim_ids) < length(x)) stop("all elements of highlight and baseline must be named")
    dim_id_vals <- unname(unlist(x))

    vec_ls <- list()
    for (i in seq(along = dim_ids)) {
        vec_ls[[i]] <- list(value = list(
                              dimensionId = dim_ids[i],
                              dimensionValueId = as.character(dim_id_vals[i])
                          ))
    }
    vec_ls
    ## vec_ls <-
    ##     list(
    ##         value = list(
    ##             dimensionId = "LOCATION",
    ##             dimensionValueId = "AUT"
    ##         ),
    ##         value = list(
    ##             dimensionId = "TIME_PERIOD",
    ##             dimensionValueId = "2011"
    ##         )
    ##     )
    return(vec_ls)
}


focus_dim_other <- function(x, sep = " - ") {
    ## x <- list("PRINTO01", c("BEL", "FIN"))
    ## x <- list("PRMNTO01", "AUS")
    y <- sapply(x, length)
    z <- y[y > 1]
    if (length(z) > 1) {
        if (!all(z %% min(z) == 0)) stop("length of hightlight and baseline vectors must be multiples of each other")
    }
    vec <-
        switch(as.character(length(x)),
               `1` = x[[1]],
               `2` = paste(x[[1]], x[[2]], sep = sep),
               `3` = paste(x[[1]], x[[2]], x[[3]], sep = sep),
               `4` = paste(x[[1]], x[[2]], x[[3]], x[[4]], sep = sep),
               `5` = paste(x[[1]], x[[2]], x[[3]], x[[4]], x[[5]], sep = sep)
               )
    vec_ls <- lapply(vec, as.list)
    for (i in seq(along = vec_ls)) names(vec_ls[[i]]) <- "value"
    return(vec_ls)
}

