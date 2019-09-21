#' Search google scholar
#'
#' @param query Search query
#' @param as_ylo Start year
#' @param source Journal
#' @param u Base URL
#'
#' @examples
#' scholarsearch(query = "bikeshare data analysis", source = "transportation research part A")
#' scholarsearch(query = "bikeshare data analysis", source = "transportation research part A", as_ylo = 2018)
#' @export
scholarsearch = function(query = NULL, as_ylo = NULL, source = NULL, u = "https://scholar.google.co.uk/scholar") {
  query = gsub(pattern = " ", replacement = "+", x = query)
  query = paste0(query, '+source:"', source, '"')
  q = list(q = query, as_ylo = as_ylo)
  search_url = httr::modify_url(url = u, query = q)
  browseURL(search_url)
  search_url
}
# https://scholar.google.co.uk/scholar?q=bikeshare
# https://scholar.google.co.uk/scholar?as_ylo=2015&q=bikeshare+data+analysis+source:"Transportation+Research+Part+A"
