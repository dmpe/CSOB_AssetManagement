base_site = "https://www.csobam.cz/portal/asset-management/produkty-a-sluzby/aktualni-hodnoty-a-vykonnost"

#' Return a website string for further use.
#'
#' If contains parameters, then they are appended.
#'
#' @param URL - The url that is used, e.g. where a desired table is located.
#' By default it is set to \url{https://www.csobam.cz/portal/asset-management/produkty-a-sluzby/aktualni-hodnoty-a-vykonnost}
#'
#' @return a URL string
#' @export
base_site_URL <- function(URL = base_site) {
  return(URL)
}

#' Executes a custom CSOB AM GET request
#'
#' And stores the HTML content
#'
#' @examples
#' get_extr_request()
#'
#' @param ... other arguments for the \pkg{httr}'s \code{\link[httr]{GET}} function
#'
#' @import httr
get_extr_request <- function(page = NULL, ...) {
  ua <- user_agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0")
  acpt <- accept("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")

  if(is.null(page) == TRUE) {
    page <- base_site_URL()
  }

  get_req <- GET(url = page, ua, acpt, add_headers(`Upgrade-Insecure-Requests` = 1), ...)
  extr_cont <- content(get_req, as = "text", type = "text/html", encoding = "utf-8")
  rm(get_req) # delete because of size
  return(extr_cont)
}

#' Build data frame/tibble from the extracted HTML content
#'
#' @import httr rvest tibble
create_Table <- function(...) {

  funds_table <-
    read_html(...) %>%
    html_node(css = ".pdp-table > table:nth-child(1)") %>%
    html_table(header = NA, trim = TRUE) %>%
    as.tibble()

  return(funds_table[,-1])
}

#' @title
#' Returns number of pages that can be queried to get all offered funds
#'
#' @description
#' By default, around 20 funds per page are displayed on \url{https://www.csobam.cz/portal/asset-management/produkty-a-sluzby/aktualni-hodnoty-a-vykonnost}
#'
#' @seealso base_site_URL for the URL that is being scrapped.
#'
#' @import httr rvest magrittr
#'
#' @return an interger count
#' @export
get_last_page <- function(...) {
  extracted_html_content <- get_extr_request(...)
  max_pageCount <- read_html(extracted_html_content) %>%
    # selector for next <li> tag after <li class="pdp-pagination-dots">
    html_node(css = ".pdp-pagination-dots + li") %>%
    xml_child(1) %>%
    html_text() %>%
    as.integer()

  return(max_pageCount)
}

#' Build URL list of queries, in a table
#'
#' @param pageCount - number of pages to scrap
#'
#' @import httr rvest stringr
get_targeted_URL_list <- function(pageCount = NULL) {
  long_url <- "https://www.csobam.cz/portal/asset-management/produkty-a-sluzby/aktualni-hodnoty-a-vykonnost?p_p_id=etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-main&p_p_col_count=2&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_appState=&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_action=paginationTable&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_page="
  last_part <- "&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_execution=e1s1"

  # from -x up to inclusive 1 or if null
  if(pageCount <= 1 || is.null(pageCount) == TRUE) {
    df <- data.frame(URLs = base_site_URL(), stringsAsFactors = FALSE)
  } else {
    # then all
    df <- rbind(data.frame(URLs = base_site_URL(), stringsAsFactors = FALSE),
                data.frame(URLs = str_c(long_url, 2:pageCount, last_part), stringsAsFactors = FALSE))
  }

  return(as.vector(df$URLs))
}




















