
#' Function for creating chart configurations.
#'
#' \code{create_config} creates configuration lists using
#'
#' @param sdmx_data_query complete SDMX URL, e.g.
#'   ""KEI/PRINTO01+PRMNTO01.AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA.GP.A/all?startTime=2015&endTime=2015"
#' @param data_api_endpoint SDMX API URL, e.g. \url{http://stats.oecd.org/SDMX-JSON/data}
#' @param title character string main title of chart
#' @param subtitle character vector chart subtitle
#' @param source_url character string to add URL below chart
#' @param source_label character string to show instead of URL below chart
#' @param highlight a list of character vectors respecting the order of dimensions of the SDMX data flow
#' @param baseline a list of character vectors respecting the order of dimensions of the SDMX data flow
#' @param chart_dimension list of id, x, y and mode
#' @param logo logical include logo
#' @param owner logical include copyright information
#' @param width integer chart width in pixel
#' @param height integer chart height in pixel
#' @param path path to a JSON template that can be read using \code{jsonlite::fromJSON}
#' @param language character string, one of \code{en} or \code{fr}
#' @param type one of \code{BarChart}, \code{RowChart}, \code{ScatterChart}, \code{HSymbolChart}, \code{VSymbolChart}, \code{TimelineChart}, \code{StackedBarChart}
#'
#' @importFrom jsonlite read_json
#'
#' @examples
#' query <- "KEI/PRINTO01+PRMNTO01.AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA.GP.A/all?startTime=2015&endTime=2015"
#' chartconfig <- create_config(sdmx_data_query = query, type = "BarChart")
#' str(chartconfig)
#'
#' ## using custom template
#' jsonfile <- system.file("templates/default.json", package = "rcw")
#' chartconfig2 <- create_config(sdmx_data_query = query, type = "BarChart", path = jsonfile)
#' str(chartconfig2)
#'
#' @source \code{jsonlite} was created by Jeroen Ooms et al., see
#'   \url{https://cran.r-project.org/web/packages/jsonlite/index.html}.
#'
#' @export
create_config <- function(sdmx_data_query=stop("'sdmx_data_query' must be specified"),
                          data_api_endpoint="https://stats.oecd.org/SDMX-JSON/data",
                          path=NULL,
                          ## metadata parameters
                          ## highlight_value=NULL,
                          title=NULL,
                          subtitle=NULL,
                          source_url=NULL,
                          source_label=NULL,
                          highlight=NULL,
                          baseline=NULL,
                          chart_dimension=NULL,
                          display="label",
                          width=NULL,
                          height=NULL,
                          x_axis=NULL,
                          y_axis=NULL,
                          logo=TRUE,
                          owner=TRUE,
                          language="en",
                          type=stop("'type' must be specified")
                          ) {

    ## if (is.null(path)) {
    ##     path <- system.file("templates/default.json", package = "rcw")
    ## } else {
    ##     if (file.exists(path)) {
    ##         chartconfig <- jsonlite::read_json(path = path)
    ##     } else stop("file ", path, " not found - are you sure the file exists?")
    ## }

    if (!is.null(path)) {
        if (!file.exists(path)) {
            stop("file ", path, " not found - are you sure the file exists?")
        }
    } else {
        path <- system.file("templates/default.json", package = "rcw")
    }
    chartconfig <- jsonlite::read_json(path = path)

    ## mandatory
    chartconfig$data$data$share$source <-
        create_query_url(sdmx_data_query, data_api_endpoint)

  chartconfig$type <- type

  if (!is.null(title)) {
    chartconfig$data$data$title <- title
  }
  if (!is.null(subtitle)) {
    chartconfig$data$data$subtitle <- subtitle
  }

  ## footnotes
  if (!is.null(source_url) | !is.null(source_label)) {
    chartconfig$data$data$footnotes <- list(source = ifelse(is.null(source_url), NA, source_url),
                                            sourceLabel = ifelse(is.null(source_label), NA, source_label))
  }


    ## share
    if (type %in% rcw:::param_chart_type$focused & !is.null(highlight)) {
      chartconfig$data$data$share$focused$highlight <-
          focus_dim(highlight, chart_type = type)
    }

    if (type %in% rcw:::param_chart_type$focused & !is.null(baseline)) {
        chartconfig$data$data$share$focused$baseline <-
            focus_dim(baseline, chart_type = type)
    }

    if (type %in% rcw:::param_chart_type$chart_dimension &
        !is.null(chart_dimension)) {
        chartconfig$data$data$share$chartDimension <-
            chart_dim(chart_dimension, chart_type = type)
    }


    ## options
    if (!is.null(width)) {
        chartconfig$data$options$base$width <- width
    }
    if (!is.null(height)) {
        chartconfig$data$options$base$height <- height
    }

    if (type %in% rcw:::param_chart_type$x_axis &
        !is.null(x_axis)) {
        chartconfig$data$options$axis$x <- axis_dim(x_axis, chart_type = type, axis = "x")
    }

    if (type %in% rcw:::param_chart_type$y_axis &
        !is.null(y_axis)) {
        chartconfig$data$options$axis$y <- axis_dim(y_axis, chart_type = type, axis = "y")
    }


  ## config
  if (display %in% c("label", "code", "both")) {
      chartconfig$data$data$share$display <- display
  } else {
      warning("'display' must be one of 'label', 'code' or 'both'")
  }

  if (logo) {
    ## oecd_globe_base64 <-
    ##   read_logo(
    ##     path = system.file("assets/oecd_globe_base64", package = "rcw"))
    ## chartconfig$data$config$logo <- oecd_globe_base64
      chartconfig$data$config$logo <-
          "https://upload.wikimedia.org/wikipedia/sco/0/0d/OECD_logo_new.svg"
          ## "https://stats.oecd.org/Content/themes/OECD/images/logo/externalLogo-en.gif"
  }
  if (!owner) {
    chartconfig$data$config$owner <- NA # ""
    chartconfig$data$config$terms <- list(label = NA, link = NA)
  }

  if (language %in% c("en", "fr")) {
      chartconfig$data$config$sourceHeaders$`Accept-Language` <- language
  }

  return(chartconfig)
}


#' Function for creating SDMX queries.
#'
#' \code{create_query_url} to build the SDMX query URLs
#'
#' @rdname create_config
#' @examples
#' query <- "KEI/PRINTO01+PRMNTO01.AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA.GP.A/all?startTime=2015&endTime=2015"
#' create_query_url(sdmx_data_query = query,
#'                  data_api_endpoint = "http://stats.oecd.org:80/SDMX-JSON/data")
#'
#' @export
create_query_url <- function(sdmx_data_query=stop("'sdmx_data_query' must be provided"),
                             data_api_endpoint=stop("'data_api_endpoint' must be provided")) {
  url <- file.path(data_api_endpoint, paste0(sdmx_data_query, "&dimensionAtObservation=AllDimensions"))
  return(url)
}
