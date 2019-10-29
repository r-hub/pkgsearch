
#' Advanced CRAN package search
#'
#' See the ElasticSearch documentation for the syntax and features:
#' https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html
#'
#' @param ... Search terms. For named terms, the name specifies the field
#'   to search for. For unnamed ones, the term is taken as is. The
#'   individual terms are combined with the `AND` operator.
#' @inheritParams pkg_search
#'
#' @return Search hits.
#' @export
#' @examples
#' \dontrun{
#' # All orphaned packages
#' advanced_search(Maintainer = "ORPHANED")
#'
#' # Packages that match a certain field
#' advanced_search(Author = "Hester AND NOT Wickham")
#'
#' # Packages for permutation tests and permissive licenses
#' advanced_search("permutation test AND NOT License: GPL OR GNU")
#'
#' # Packages that have a certain field
#' advanced_search("_exists_" = "URL")
#' 
#' # Packages that don't have a certain field
#' advanced_search("NOT _exists_: URL")
#'
#' # Packages that do not have a certain field:
#' advanced_search("NOT _exists_: URL")
#'
#' # Regular expressionss
#' advanced_search(Author = "/Joh?nathan/")
#'
#' # Fuzzy search
#' advanced_search(Author = "Johnathan~1")
#' }

advanced_search <- function(..., format = c("short", "long"), from = 1,
                            size = 10) {

  format <- match.arg(format)

  terms <- unlist(list(...))
  if (is.null(names(terms))) names(terms) <- rep("", length(terms))

  q <- ifelse(
    names(terms) == "",
    terms,
    paste0("(", names(terms), ":", terms, ")")
  )

  qstr <- toJSON(list(
    query = list(
      query_string = list(
        query = unbox(paste0(q, collapse = " AND ")),
        default_field = unbox("*")
      )
    )
  ))

  server <- Sys.getenv("R_PKG_SEARCH_SERVER", "search.r-pkg.org")
  port <- as.integer(Sys.getenv("R_PKG_SEARCH_PORT", "80"))

  resp <- do_query(qstr, server, port, from, size)

  result <- format_result(
    resp,
    "advanced search",
    format = format,
    from = from,
    size = size,
    server,
    port
  )

  s_data$prev_q <- result

  result
}
