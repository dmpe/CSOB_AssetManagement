#' Scrap a specified number of funds from the public CSOB AM website.
#'
#' No processing is done at this stage (other than adding a proper column names)
#'
#' @param pages_to_scrap - how many pages of available funds to scrap.
#' Either a string \code{"ALL"} or a number. By default, it will scrap just 1 page (~20 funds) from the \code{\link{base_site_URL}}
#'
#' @seealso base_site_URL for the URL that is being scrapped.
#'
#' @import httr rvest tibble purrr dplyr
#'
#' @return a table that contains either all funds managed by CSOB AM or their selected number (default: 1 page -> ~20 funds)
#' @export
managed_funds <- function(pages_to_scrap = 1) {

  if(pages_to_scrap == "ALL") {
    pages_count <- get_last_page()
  } else {
    # default
    pages_count <- pages_to_scrap
  }

  url_df <- get_targeted_URL_list(pageCount = pages_count)

  rowsBinded_table <- url_df %>%
    map(get_extr_request) %>%
    map_df(create_Table)

  colnames(rowsBinded_table) <- c("Title", "Currency", "Price", "Date", "PERFORMANCE_1M", "PERFORMANCE_3M", "PERFORMANCE_6M",
                    "PERFORMANCE_1R", "PERFORMANCE_3R", "PERFORMANCE_5R", "PERFORMANCE_10R")

  return(rowsBinded_table)
}
