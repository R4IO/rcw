#' Function for creating SDMX queries.
#'
#' \code{create_query} creates SDMX query URLs
#'
#' @param data_api_endpoint SDMX API URL, e.g. \url{http://stats.oecd.org:80/SDMX-JSON/data}
#' @param query SDMX query, e.g.
#'   \code{"KEI/PRINTO01+PRMNTO01.AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA.GP.A/all?startTime=2015&endTime=2015"}
#'
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
