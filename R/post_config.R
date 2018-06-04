#' Function for posting chart configurations.
#'
#' \code{post_config} submits JSON configuration lists.
#'
#' @param config a configuration list according to the API definition
#' @param url the POST API endpoint offering \code{/share} and \code{/chart}
#'   services, e.g. http://vs-webdev-1:89 or http://stats.oecd.org
#' @param show boolean print the created JSON object
#' @param path write the JSON object to a file on disk
#' @param auto_unbox automatically ‘unbox’ all atomic vectors of length 1 (see
#'   \code{jsonlite::toJSON})
#' @param null how to encode NULL values within a list: must be one of 'null' or
#'   'list' (see \code{jsonlite::toJSON})
#' @param ... additional parameters supplied to \code{httr:POST}, e.g.
#'   \code{httr::verbose()}
#'
#' @examples
#' query <- "KEI/PRINTO01+PRMNTO01.AUS+AUT+BEL+CAN+CHL+CZE+DNK+EST+FIN+FRA.GP.A/all?startTime=2015&endTime=2015"
#' chartconfig <- create_config(sdmx_data_query = query, type = "BarChart", logo = FALSE)
#' post_config(config = chartconfig, url = "http://stats.oecd.org", response = TRUE)
#'
#' ## write to disk for debugging
#' outfile <- tempfile(pattern = "chartconfig_", fileext = ".json")
#' post_config(config = chartconfig, path = outfile)
#' filecon <- file(outfile)
#' readLines(con = filecon)
#' close(filecon)
#'
#' 
#' @source \code{httr} was created by Hadley Wickham, see
#'   \url{https://cran.r-project.org/web/packages/httr/index.html};
#'   \code{jsonlite} was created by Jeroen Ooms et al., see
#'   \url{https://cran.r-project.org/web/packages/jsonlite/index.html}.
#'
#' @export
post_config <- function(config=stop("'config' must be specified"), ...,
                        url="http://stats.oecd.org", show=FALSE,
                        path=NULL, response=FALSE, auto_unbox=TRUE, null='null') {

  json_string <- jsonlite::toJSON(config, auto_unbox = auto_unbox, null = null)
  if(show) cat("\n", json_string, "\n")
  if(length(path) > 0) {
    jsonlite::write_json(x = config, path = path, auto_unbox = auto_unbox, null = null)
    config_pretty <- jsonlite::toJSON(config, auto_unbox = auto_unbox, null = null, pretty = TRUE)
    filecon <- file(path)
    writeLines(text = config_pretty, con = filecon)
    close(filecon)
    return(cat("\nCreated file", path, "\n"))
  } else {
    res <- httr::POST(url = file.path(url, "share"),
                      body = json_string,
                      httr::add_headers("Content-Type" = "text/plain;charset=UTF-8"),
                      encode = "json",
                      ...) # httr::verbose()
    if(response) print(res)

    chart_id <- httr::content(res)
    chart_url <- file.path(url, paste0("chart?id=", chart_id))
    return(chart_url)

  }
}
