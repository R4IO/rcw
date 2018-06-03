#' Function to load base64 logo.
#'
#' \code{read_logo} reads the logo from a file on disk.
#'
#' @param path the file path
#'
#' @examples
#' logo <- read_logo(system.file("assets/oecd_globe_base64", package = "rcw"))
#' str(logo)
#'
#' @export
read_logo <- function(path=system.file("assets/oecd_globe_base64", package = "rcw")) {
  filecon <- file(path)
  logo <- readLines(con = filecon)
  close(filecon)
  return(logo)
}


