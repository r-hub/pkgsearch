#' Advanced search of CRAN packages
#'
#' @description
#' `pkg_search_adv()` starts a new advanced search query.
#' 
#' @details
#' Note that the search needs a working Internet connection.
#'
#' @param package Query on the package name
#' @param title Query on the package title
#' @param author Query on the package authors
#' @param maintainer Query on the package maintainer
#' @param description Query on the package description
#' @param keywords Query on the package keywords
#' @param format Default formatting of the results. _short_ only
#'   outputs the name and title of the packages, _long_ also
#'   prints the author, last version, full description and URLs.
#'   Note that this only affects the default printing, and you can
#'   still inspect the full results, even if you specify _short_
#'   here.
#' @param from Where to start listing the results, for pagination.
#' @param size The number of results to list.
#' @inherit pkg_search return
#' @export
pkg_search_adv <- function(package = NULL, title = NULL,
                           author = NULL, maintainer = NULL,
                           description = NULL, keywords = NULL,
                           format = c("short", "long"),
                       from = 1, size = 10) {
  
  
  queries <- c("Package" = package, "Title" = title,
               "Author" = author, "Maintainer" = maintainer,
               "Description" = description, "Keywords" = keywords)
  queries <- queries[!is.null(queries)]
  
  if (length(queries) == 0){
    stop("Provide at least a query on one field.")
  }
  
  format <- match.arg(format)
  server <- Sys.getenv("R_PKG_SEARCH_SERVER", "search.r-pkg.org")
  port <- as.integer(Sys.getenv("R_PKG_SEARCH_PORT", "80"))
  
  make_pkg_search_adv(queries, format, from, size, server, port)
}

make_pkg_search_adv <- function(query, format, from, size, server, port) {
  
  result <- make_query_adv(query = query) %>%
    do_query(server = server, port = port, from = from, size = size) %>%
    format_result(query = query, format = format, from = from,
                  size = size, server = server, port = port)
  
  s_data$prev_q <- result
  
  result
}


make_query_adv <- function(queries) {
  
  check_strings(queries)
  
  query_object <- list()
  query_object$query <- list()
  query_object$query$query$bool$should <- NULL
  query_object$query$query$bool$must <- NULL
  
  for (query in queries){
    field <- names(query)
    query_object$query$query$bool$must <- c(query_object$query$query$bool$must,
                                            list(multi_match = list(
                                              query = query,
                                              fields = field
                                            ))
    )
    
    query_object$query$query$bool$should <- c(query_object$query$query$bool$should,
                                              ## This is matching the complete phrase, so it takes priority
                                              list(multi_match = list(
                                                query = query,
                                                fields = field,
                                                type = "phrase",
                                                analyzer = "english_and_synonyms",
                                                boost = 10
                                              )),
                                              ## This is if all words match (but not as a phrase)
                                              list(multi_match = list(
                                                query = query,
                                                fields = field,
                                                operator = "and",
                                                analyzer = "english_and_synonyms",
                                                boost = 5
                                              )))
                                              
  }
  
  toJSON(query_object, auto_unbox = TRUE, pretty = TRUE)
}