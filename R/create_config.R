#' Function for creating chart configurations.
#'
#' \code{create_config} creates configuration lists for use with
#'
#' @param sdmx_data_query complete SDMX URL created using
#'   \code{create_query_url}
#' @param title character string main title of chart
#' @param subtitle character vector chart subtitle
#' @param unit character string to specify unit of measure (should be automatic)
#' @param source_url character string to add URL below chart
#' @param source_label character string to show instead of URL below chart
#' @param logo logical include logo
#' @param owner logical include copyright information
#' @param type one of \code{BarChart}, \code{RowChart}, \code{ScatterChart},
#'   \code{HSymbolChart}, \code{VSymbolChart}, \code{TimelineChart},
#'   \code{StackedBarChart}
#' @param width integer chart width in pixel
#' @param height integer chart height in pixel
#' @param path path to a JSON template that can be read using
#'   \code{jsonlite::fromJSON}
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
                          data_api_endpoint="http://stats.oecd.org:80/SDMX-JSON/data",
                          title=NULL,
                          subtitle=NULL,
                          unit=NULL,
                          source_url=NULL,
                          source_label=NULL,
                          logo=TRUE,
                          owner=TRUE,
                          type=stop("'type' must be specified"),
                          width=NULL,
                          height=NULL,
                          path=NULL) {

  if(is.null(path)) path <- system.file("templates/default.json",
                                        package = "rcw")
  chartconfig <- jsonlite::read_json(path = path)

  ## mandatory
  chartconfig$data$data$share$source <-
    create_query_url(sdmx_data_query=sdmx_data_query,
                     data_api_endpoint=data_api_endpoint)

  chartconfig$type <- type

  if(!is.null(title)) {
    chartconfig$data$data$title <- title
  }
  if(!is.null(subtitle)) {
    chartconfig$data$data$subtitle <- subtitle
  }
  if(!is.null(unit)) {
    chartconfig$data$data$uprs <- unit
  }
  if(!is.null(source_url) | !is.null(source_label)) {
    chartconfig$data$data$footnotes <- list(source = ifelse(is.null(source_url), "", source_url),
                                            sourceLabel = ifelse(is.null(source_label), "", source_label))
  }

  if(logo) {
    oecd_globe_base64 <-
      read_logo(
        path = system.file("assets/oecd_globe_base64", package = "rcw"))
    chartconfig$data$config$logo <- oecd_globe_base64
  }
  if(!owner) {
    chartconfig$data$config$owner <- ""
    chartconfig$data$config$terms <- list(label = NULL, link = NULL)
  }

  if(!is.null(width)) {
    chartconfig$data$options$base$width <- width
  }
  if(!is.null(height)) {
    chartconfig$data$options$base$height <- height
  }

  return(chartconfig)
}
