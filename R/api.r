
## ----------------------------------------------------------------------

#' Search CRAN packages
#'
#' @details
#' Note that the search needs a working Internet connection.
#'
#' @param query Search query string.
#' @param from Where to start listing the results, for pagination.
#' @param size The number of results to list.
#' @param server The server to use.
#' @param port Port to use.
#' @return A list of packages, in a special object.
#'
#' @export
#' @examples
#' \donttest{
#' ## Some example searches
#' see("networks")
#' see("survival")
#' see("graphics")
#' see("google")
#' }

see <- function(query, from = 0, size = 10,
                server = "seer.r-pkg.org", port = 9200) {

  index <- "cran-devel"
  type <- "package"

  make_query(query = query) %>%
    do_query(server = server, port = port, index = index, type = type,
             from = from, size = size) %>%
    format_result(query = query)
}

#' @importFrom jsonlite toJSON

make_query <- function(query) {

  check_string(query)

  query_object <- list(
    query = list(
      function_score = list(
        query = list(
          multi_match = list(
            fields = c("Package^10", "Title^5", "Description^2",
              "Author^3", "Maintainer^4", "_all"),
            query = query
          )
        ),
        functions = list(
          list(
            script_score = list(
              script = "cran_search_score"
            )
          )
        )
      )
    )
  )

  toJSON(query_object, auto_unbox = TRUE, pretty = TRUE)
}

#' @importFrom httr POST stop_for_status
#' @importFrom jsonlite fromJSON

do_query <- function(query, server, port, index, type, from, size) {

  check_count(from)
  check_count(size)

  url <- "http://" %+% server %+% ":" %+% as.character(port) %+%
    "/" %+% index %+% "/" %+% type %+% "/_search?from=" %+%
    as.character(from) %+% "&size=" %+% as.character(size)
  result <- POST(url, body = query)
  stop_for_status(result)

  content(result, as = "text")
}

format_result <- function(result, query) {
  result %>%
    fromJSON(simplifyVector = FALSE) %>%
    replace("query", query) %>%
    add_class("seer_result")
}
