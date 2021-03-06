% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/funds.R
\name{managed_funds}
\alias{managed_funds}
\title{Scrap a specified number of funds from the public CSOB AM website.}
\usage{
managed_funds(pages_to_scrap = 1)
}
\arguments{
\item{pages_to_scrap}{- how many pages of available funds to scrap.
Either a string \code{"ALL"} or a number. By default, it will scrap just 1 page (~20 funds) from the \code{\link{base_site_URL}}}
}
\value{
a table that contains either all funds managed by CSOB AM or their selected number (default: 1 page -> ~20 funds)
}
\description{
No processing is done at this stage (other than adding a proper column names)
}
\seealso{
base_site_URL for the URL that is being scrapped.
}
