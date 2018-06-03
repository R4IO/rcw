#' Function for creating chart configurations.
#'
#' \code{create_config} creates configuration lists for use with
#'
#' @param source SDMX URL
#' @param title character string main title of chart
#' @param subtitle character vector chart subtitle
#' @param type one of \code{BarChart}, \code{RowChart}, \code{ScatterChart},
#'   \code{HSymbolChart}, \code{VSymbolChart}, \code{TimelineChart},
#'   \code{StackedBarChart}
#' @param path path to a JSON template that can be read using
#'   \code{jsonlite::fromJSON}
#'
#' @examples
#' ## using system template
#' chartconfig <- create_config()
#' str(chartconfig)
#'
#' ## using custom template
#' jsonfile <- "../inst/templates/default.json"
#' chartconfig2 <- create_config(path = jsonfile)
#' str(chartconfig2)
#'
#' @source \code{jsonlite} was created by Jeroen Ooms et al., see
#'   \url{https://cran.r-project.org/web/packages/jsonlite/index.html}.
#'
#' @export
create_config <- function(source=stop("'source' must be specified"),

                          title=NULL,
                          subtitle=NULL,
                          type=stop("'type' must be specified"),
                          path=NULL) {

  if(is.null(path)) path <- system.file("templates/default.json",
                                        package = "rcw")
  template <- jsonlite::read_json(path = path)

  ## str(template)
  ## str(template$data$data$series)
  ## class(template$data$data$series)
  ## chartconfig$data$data$series <- list()

  chartconfig <- template

  ## mandatory
  chartconfig$data$data$share$source <- source
  chartconfig$type <- type

  if(!is.null(title)) {
    chartconfig$data$data$title <- title
  }
  if(!is.null(subtitle)) {
    chartconfig$data$data$subtitle <- subtitle
  }

  return(chartconfig)
}
