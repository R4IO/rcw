#' Function for creating SDMX queries.
#'
#' \code{create_query} creates SDMX query URLs
#'
#' @param url SDMX API URL, e.g. \url{http://stats.oecd.org:80/SDMX-JSON/data}
#' @param flow SDMX data flow, e.g. \code{KEI}
#' @param query SDMX query, e.g.
#'   \code{"PRINTO01+PRMNTO01.AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA.GP.A"}
#' @param method character string, e.g. \code{all}
#' @param options character vector, e.g. \code{c("startTime=2015",
#'   "endTime=2015", "dimensionAtObservation=AllDimensions")}
#'
#' @examples
#' flow <- "KEI"
#' query <- "PRINTO01+PRMNTO01.AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA.GP.A"
#' opts <- c("startTime=2015", "endTime=2015", "dimensionAtObservation=AllDimensions")
#' create_query_url(flow = flow, query = query, opts = opts)
#'
#' @source \code{jsonlite} was created by Jeroen Ooms et al., see
#'   \url{https://cran.r-project.org/web/packages/jsonlite/index.html}.
#'
#' @export
create_query_url <- function(url="http://stats.oecd.org:80/SDMX-JSON/data",
                             flow=stop("'flow' must be provided"),
                             query=stop("'query' must be provided"),
                             method="all",
                             opts=c("startTime=2015", "endTime=2015", "dimensionAtObservation=AllDimensions")) {

  options_chr <- paste(opts, collapse = "&")
  query <- file.path(url, flow, query, paste0(method, "?", options_chr))
  return(query)
}
