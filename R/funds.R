#' Scrap all funds from a public CSOB AM website.
#'
#' No processing is done at this stage (other than adding a proper header names)
#'
#' @param pages_to_scrap - how many pages of available funds to scrap (by default ALL)
#' @param funds_to_scrap - how many funds (exact number) to scrap (by default NULL)
#'
#' @seealso returnURL for the URL that is being scrapped.
#'
#' @import httr rvest tibble purrr dplyr
#'
#' @return a table that contains either all funds managed by CSOB AM (default setting) or their selected number
#' @export
managed_funds <- function(pages_to_scrap = "ALL", funds_to_scrap = NULL) {

  if(pages_to_scrap == "ALL") {
    # default
    listTableAndPageCount <- get_last_page()
  } else {
    pages_count <- pages_to_scrap
  }

  url_list <- get_target_url_list(pageCount = listTableAndPageCount[[2]])

  rowsBinded_table <- url_list %>%
    map(get_extr_request) %>%
    map(create_Table) %>%
    bind_rows()

  df <- bind_rows(listTableAndPageCount[[1]], rowsBinded_table)

  colnames(df) <- c("Empty", "Title", "Currency", "Price", "Date", "PERFORMANCE_1M", "PERFORMANCE_3M", "PERFORMANCE_6M",
                    "PERFORMANCE_1R", "PERFORMANCE_3R", "PERFORMANCE_5R", "PERFORMANCE_10R")
  return(df)
}
