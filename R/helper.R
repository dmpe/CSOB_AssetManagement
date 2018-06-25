#' Return a website string for further use.
#'
#' If contains parameters, then they are appended.
#'
#' @param URL - The url that is used, e.g. where a desired table is located.
#' By default it is set to \url{https://www.csobam.cz/portal/asset-management/produkty-a-sluzby/aktualni-hodnoty-a-vykonnost}
#'
#' @return a URL string
returnURL <- function(URL = "https://www.csobam.cz/portal/asset-management/produkty-a-sluzby/aktualni-hodnoty-a-vykonnost", ...) {
  CSOBAM_table_url <- URL
  return(CSOBAM_table_url)
}

#' Prepare custom CSOB AM GET request
#'
#' And make it ready for HTML extraction purposes
#' @examples
#' get_extr_request()
#'
#' @import httr rvest stringr
#'
get_extr_request <- function(url_req = returnURL()) {
  ua <- user_agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0")
  acpt <- accept("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")

  get_req <- GET(url = url_req, ua, acpt, add_headers(`Upgrade-Insecure-Requests` = 1))
  extr_cont <- content(get_req, as = "text", type = "text/html", encoding = "utf-8")
  return(extr_cont)
}

#' @title
#' How many pages do we have to query to get all funds managed by CSOB Asset Management.
#'
#' @description
#' Either hardcoded number (~ 24) or dynamic (here).
#'
#' @seealso returnURL for the URL that is being scrapped.
#'
#' @import httr rvest stringr
#'
#' @return an interger count
get_last_page <- function() {
  # read first page
  extract_content <- get_extr_request()
  pageCount <- read_html(extract_content) %>%
    # selector for next <li> tag after <li class=".pdp-pagination-dots">
    html_node(css = ".pdp-pagination-dots + li") %>%
    xml_child(1) %>%
    html_text() %>%
    as.integer()

  CSOBAM_table <- create_Table(extract_content)

  return(list(firstTable = CSOBAM_table, pageCount = pageCount))
}

#' Build URL list of queries
#'
#' @param pageCount - number of pages to scrap
#'
#' @import httr rvest stringr
#'
get_target_url_list <- function(pageCount) {
  long_url <- "https://www.csobam.cz/portal/asset-management/produkty-a-sluzby/aktualni-hodnoty-a-vykonnost?p_p_id=etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-main&p_p_col_count=2&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_appState=&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_action=paginationTable&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_page="
  last_part <- "&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_execution=e1s1"
  return(str_c(long_url, 2:pageCount, last_part))
}

#' Build table from extracted HTML content
#'
#' @import httr rvest tibble
#'
create_Table <- function(extract_content) {

  CSOBAM_table <-
    read_html(extract_content) %>%
    html_node(css = ".pdp-table > table:nth-child(1)") %>%
    html_table(header = NA, trim = TRUE) %>%
    as.tibble()

  return(CSOBAM_table)
}

#' #' Process table
#' #'
#' #
#' #'
#' CSOB_AM_Funds <- function() {
#'   readHTML_returnTable()
#'   .pdp-pagination-dots
#' }

#' #' Select only a specific fund (idea)
#' #'
#' #' import httr rvest
#' #'
#' CSOB_AM_Funds <- function(name = "") {
#'   readHTML_returnTable()
#'   .pdp-pagination-dots
#' }





















