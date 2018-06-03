#' Function for creating chart configurations.
#'
#' \code{create_config} creates configuration lists for use with
#'
#' @param source complete SDMX URL created using \code{create_query_url}
#' @param title character string main title of chart
#' @param subtitle character vector chart subtitle
#' @param unit character string to specify unit of measure (should be automatic)
#' @param footurl character string to add URL below chart
#' @param footlabel character string to show instead of URL below chart
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
#' flow <- "KEI"
#' query <- "PRINTO01+PRMNTO01.AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA.GP.A"
#' opts <- c("startTime=2015", "endTime=2015", "dimensionAtObservation=AllDimensions")
#' query_url <- create_query_url(flow = flow, query = query, opts = opts)
#' chartconfig <- create_config(source = query_url, type = "BarChart")
#' str(chartconfig)
#'
#' ## using custom template
#' jsonfile <- system.file("templates/default.json", package = "rcw")
#' chartconfig2 <- create_config(source = query_url, type = "BarChart", path = jsonfile)
#' str(chartconfig2)
#'
#' @source \code{jsonlite} was created by Jeroen Ooms et al., see
#'   \url{https://cran.r-project.org/web/packages/jsonlite/index.html}.
#'
#' @export
create_config <- function(source=stop("'source' must be specified"),

                          title=NULL,
                          subtitle=NULL,
                          unit=NULL,
                          footurl=NULL,
                          footlabel=NULL,
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
  chartconfig$data$data$share$source <- source
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
  if(!is.null(footurl) | !is.null(footlabel)) {
    chartconfig$data$data$footnotes <- list(source = ifelse(is.null(footurl), "", footurl),
                                            sourceLabel = ifelse(is.null(footlabel), "", footlabel))
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
