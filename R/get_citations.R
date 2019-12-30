#' Scrape title, author and number of citations from google scholar url
#'
#' @param u url
#' @export
#' @examples
#' query = "open source software"
#' u = scholarurl(query)
#' res = scholar_get_citations(u)
#' res
scholar_get_citations = function(u) {
  html = xml2::read_html(u)
  titles = rvest::html_nodes(html, ".gs_rt")
  titles_text = rvest::html_text(titles)
  titles_text = gsub(pattern = "\\[B\\]", replacement = "", titles_text)
  titles_text = gsub(pattern = "\\[BOOK\\]", replacement = "", titles_text)
  titles_text = gsub(pattern = "\\[CITATION\\]", replacement = "", titles_text)
  titles_text = gsub(pattern = "\\[C\\]", replacement = "", titles_text)
  titles_text = gsub(pattern = "\\[PDF\\]", replacement = "", titles_text)
  titles_text = stringr::str_trim(titles_text)
  author_source = rvest::html_nodes(html, ".gs_a") # author, source
  as_text = rvest::html_text(author_source)
  authors = stringr::str_extract(string = as_text, pattern = "[^-]+")
  year = stringr::str_extract(string = as_text, pattern = "[0-9][0-9][0-9][0-9]")
  first_author = stringr::str_extract(authors, "[^,]+")
  first_author_sirname = stringr::str_replace_all(first_author, "[A-Z]+ ", "")
  n = rvest::html_nodes(html, ".gs_ri .gs_fl") # author, source
  n_text = rvest::html_text(n, ".gs_ri .gs_fl") # author, source
  n_citations = stringr::str_extract(string = n_text, pattern = "(?<=[Cited by ])\\d+")
  n_results = rvest::html_nodes(html, ".gs_ab_mdw")
  n_results_txt = rvest::html_text(n_results)[2]
  n_results = stringr::str_extract(n_results_txt, "[0-9|,]+")
  n_results = gsub(pattern = ",", replacement = "", n_results)
  tibble::tibble(
    first_author_sirname,
    year = as.integer(year),
    titles_text,
    n_citations = as.integer(n_citations),
    n_results = as.integer(n_results),
    url = u
  )
}
