#' Search google scholar
#'
#' @param query Search query
#' @param as_ylo Lowest year
#' @param as_yhi Highest year
#' @param source Journal
#' @param open_browser Open the browser?
#' @param u Base URL
#'
#' @examples
#' scholarsearch(query = "bikeshare data analysis")
#' scholarsearch(query = "bikeshare data analysis", source = "transportation research part A")
#' scholarsearch(query = "bikeshare data analysis", source = "transportation research part A", as_ylo = 2018)
#' scholarsearch(query = "bikeshare data analysis", source = "transportation research part A", as_yhi = 2012)
#' scholarsearch(query = '"open+source"+"transport+planning"', as_yhi = 2012) # note google's citation format
#' scholarsearch(query = '"open+source"+"transport+planning"', as_yhi = 2012) # note google's citation format
#' @export
scholarsearch = function(query = NULL,
                         as_ylo = NULL,
                         as_yhi = NULL,
                         source = NULL,
                         open_browser = TRUE,
                         u = "https://scholar.google.co.uk/scholar") {
  query = gsub(pattern = " ",
               replacement = "+",
               x = query)
  if (!is.null(source)) {
    query = paste0(query, '+source:"', source, '"')
  }
  q = list(q = query,
           as_ylo = as_ylo,
           as_yhi = as_yhi)
  search_url = httr::modify_url(url = u, query = q)
  if(open_browser) browseURL(search_url)
  search_url
}
#' Get url of google scholar search
#' @inheritParams scholarsearch
#' @aliases scholarsearch
#' @export
#' @examples
#' scholarurl("test")
scholarurl = function(query) {
  scholarsearch(query, open_browser = FALSE)
}
#' Search google scholar
#'
#' @param query Search query
#' @param as_ylo Lowest year
#' @param as_yhi Highest year
#' @param source Journal
#' @param open_browser Open the browser?
#' @param u Base URL
#'
#' @examples
#' scholar_get(query = '"open+source"+"transport+planning"')
#' @export
scholar_get = function(query = NULL,
                         as_ylo = NULL,
                         as_yhi = NULL,
                         source = NULL,
                         open_browser = FALSE,
                         u = "https://scholar.google.co.uk/scholar") {
  u = scholarsearch(query,
                    as_ylo,
                    as_yhi,
                    source,
                    open_browser,
                    u = "https://scholar.google.co.uk/scholar")
  scholar_get_citations(u)
}
