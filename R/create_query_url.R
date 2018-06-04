#' Function for creating SDMX queries.
#'
#' \code{create_query} creates SDMX query URLs
#'
#' @param data_api_endpoint SDMX API URL, e.g. \url{http://stats.oecd.org:80/SDMX-JSON/data}
#' @param query SDMX query, e.g.
#'   \code{"PRINTO01+PRMNTO01.AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA.GP.A"}
#'
#' @examples
#' query <- "KEI/PRINTO01+PRMNTO01.AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA.GP.A/all?startTime=2015&endTime=2015"
#' create_query_url(query = query)
#'
#' @export
create_query_url <- function(data_api_endpoint"http://stats.oecd.org:80/SDMX-JSON/data",
                             query=stop("'query' must be provided")) {
  query <- file.path(url, paste0(query, "&", "dimensionAtObservation=AllDimensions"))
  return(query)
}
