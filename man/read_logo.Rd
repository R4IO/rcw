% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_logo.R
\name{read_logo}
\alias{read_logo}
\title{Function to load base64 logo.}
\usage{
read_logo(path = system.file("assets/oecd_globe_base64", package =
  "rcw"))
}
\arguments{
\item{path}{the file path}
}
\description{
\code{read_logo} reads the logo from a file on disk.
}
\examples{
logo <- read_logo(system.file("assets/oecd_globe_base64", package = "rcw"))
str(logo)

}
