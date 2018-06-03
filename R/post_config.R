#' Function for posting chart configurations.
#'
#' \code{post_config} submits JSON configuration lists.
#'
#' @param config a configuration list according to the API definition
#' @param url the POST API endpoint
#' @param show boolean print the created JSON object
#' @param path write the JSON object to a file on disk
#' @param auto_unbox automatically ‘unbox’ all atomic vectors of length 1 (see
#'   \code{jsonlite::toJSON})
#' @param null how to encode NULL values within a list: must be one of 'null' or
#'   'list' (see \code{jsonlite::toJSON})
#'
#' @examples
#' chartconfig <- jsonlite::read_json(path = "../examples/chartconfig.json")
#' chartUrl <- post_config(x = chartconfig)
#' browseURL(url = chartUrl)
#'
#' outfile <- tempfile(pattern = "chartconfig_", fileext = ".json")
#' post_config(x = chartconfig, show = TRUE, path = outfile)
#' jsonlite::read_json(path = outfile)
#'
#' post_config(x = chartconfig, response=TRUE)
#`
#' @source \code{httr} was created by Hadley Wickham, see
#'   \url{https://cran.r-project.org/web/packages/httr/index.html};
#'   \code{jsonlite} was created by Jeroen Ooms et al., see
#'   \url{https://cran.r-project.org/web/packages/jsonlite/index.html}.
#'
#' @export
post_config <- function(config, url="http://stats.oecd.org", show=FALSE, path=NULL, response=FALSE, auto_unbox=TRUE, null='null') {

  json_string <- jsonlite::toJSON(config, auto_unbox = auto_unbox, null = null)
  if(show) cat("\n", json_string, "\n")
  if(length(path) > 0) {
    jsonlite::write_json(x = chartconfig, path = path, auto_unbox = auto_unbox, null = null)
    return(cat("\nCreated file", path, "\n"))
  } else {
    res <- httr::POST(url = file.path(url, "share"),
                           body = json_string,
                           httr::add_headers("Content-Type" = "text/plain;charset=UTF-8"),
                           encode = "json" , httr::verbose()
                           )
    if(response) print(res)

    chart_id <- httr::content(res)
    chart_url <- file.path(url, paste0("chart?id=", chart_id))
    return(chart_url)

  }
}
