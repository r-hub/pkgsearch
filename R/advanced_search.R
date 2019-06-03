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
#' @return A tibble with columns:
#'   * `score`: Score of the hit. See Section _Scoring_ for some details.
#'   * `package`: Package name.
#'   * `version`: Latest package version.
#'   * `title`: Package title.
#'   * `description`: Short package description.
#'   * `date`: Time stamp of the last release.
#'   * `maintainer_name`: Name of the package maintainer.
#'   * `maintainer_email`: Email address of the package maintainer.
#'   * `revdeps`: Number of (strong and weak) reverse dependencies of the
#'     package.
#'   * `downloads_last_month`: Raw number of package downloads last month,
#'     from the RStudio CRAN mirror.
#'   * `license`: Package license.
#'   * `url`: Package URL(s).
#'   * `bugreports`: URL of issue tracker, or email address for bug reports.
#'
#' @export
#' @importFrom magrittr %>% extract2
#' @examples
#' \donttest{
#' # Example
#' ps("survival")
#'
#' # Pagination
#' ps("networks")
#' more()
#'
#' # Details
#' ps("visualization")
#' ps()
#'
#' # See the underlying tibble
#' ps("ropensci")
#' ps()[]
#' }

pkg_search <- function(query = NULL, format = c("short", "long"),
                       from = 1, size = 10) {
  
  if (is.null(query)) return(pkg_search_again())
  format <- match.arg(format)
  server <- Sys.getenv("R_PKG_SEARCH_SERVER", "search.r-pkg.org")
  port <- as.integer(Sys.getenv("R_PKG_SEARCH_PORT", "80"))
  
  make_pkg_search(query, format, from, size, server, port)
}


make_advanced_query <- function(queries) {
  
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