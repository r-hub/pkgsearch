
## ----------------------------------------------------------------------

s_data <- new.env()

#' Search CRAN packages
#'
#' @details
#' Note that the search needs a working Internet connection.
#'
#' @param query Search query string. If this argument is missing
#'   then the results of the last query are printed, in \sQuote{short}
#'   and \sQuote{long} formats, in turns for successive \code{pkg_search()}
#'   calls. If this argument is missing, then all other arguments
#'   are ignored.
#' @param format Default formatting of the results. \sQuote{short} only
#'   outputs the name and title of the packages, \sQuote{long} also
#'   prints the author, last version, full description and URLs.
#'   Note that this only affects the default printing, and you can
#'   still inspect the full results, even if you specify \sQuote{short}
#'   here.
#' @param from Where to start listing the results, for pagination.
#' @param size The number of results to list.
#' @return A list of packages, in a special object.
#'
#' @export
#' @importFrom magrittr %>% extract2
#' @examples
#' \donttest{
#' ## Some example searches
#' pkg_search("networks")
#' pkg_search("survival")
#' pkg_search("graphics")
#' pkg_search("google")
#' }

pkg_search <- function(query, format = c("short", "long"), from = 1, size = 10) {

  if (missing(query)) { return(pkg_search_again()) }
  format <- match.arg(format)
  server <- Sys.getenv("R_PKG_SEARCH_SERVER", "search.r-pkg.org")
  port <- as.integer(Sys.getenv("R_PKG_SEARCH_PORT", "80"))

  index <- "package"

  result <- make_query(query = query) %>%
    do_query(server = server, port = port, index = index,
             from = from, size = size) %>%
    format_result(query = query, format = format, from = from,
                  size = size, server = server, port = port)

  s_data$prev_q <- result

  result
}

#' Next page after a search
#'
#' @inheritParams pkg_search
#' @export

more <- function(format = c("short", "long"), size) {
  if (is.null(s_data$prev_q)) { stop("No query, start with 'pkg_search'") }
  if (missing(format)) {
    format <-s_data$prev_q$format
  } else {
    format <- match.arg(format)
  }
  if (missing(size)) {
    size <- s_data$prev_q$size
  } else {
    check_count(size)
  }
  pkg_search(query = s_data$prev_q$query, format = format,
      from = s_data$prev_q$from + s_data$prev_q$size, size = size)
}

#' @importFrom jsonlite toJSON

make_query <- function(query) {

  check_string(query)

  fields <- c("Package^10", "Title^5", "Description^4",
              "Author^5", "Maintainer^6", "_all")

  query_object <- list(
    query = list(
      function_score = list(
        functions = list(
          list(
            field_value_factor = list(
              field = "revdeps",
              modifier = "sqrt",
              factor = 1)
          )
        ),

        query = list(
          bool = list(
            ## This is simply word by work match, scores add up for fields
            must = list(
              list(multi_match = list(
                     query = query,
                     type = "most_fields"
                   ))
            ),
            should = list(
              ## This is matching the complete phrase, so it takes priority
              list(multi_match = list(
                     query = query,
                     fields = c("Title^5", "Description^4", "_all"),
                     type = "phrase",
                     analyzer = "english_and_synonyms",
                     boost = 10
                   )),
              ## This is if all words match (but not as a phrase)
              list(multi_match = list(
                     query = query,
                     fields = fields,
                     operator = "and",
                     analyzer = "english_and_synonyms",
                     boost = 5
                   ))
            )
          )
        )
      )
    )
  )

  toJSON(query_object, auto_unbox = TRUE, pretty = TRUE)
}

#' @importFrom httr POST add_headers stop_for_status content
#' @importFrom jsonlite fromJSON

do_query <- function(query, server, port, index, from, size) {

  check_count(from)
  check_count(size)

  url <- "http://" %+% server %+% ":" %+% as.character(port) %+%
    "/" %+% index %+% "/_search?from=" %+%
    as.character(from - 1) %+% "&size=" %+% as.character(size)
  result <- POST(
    url, body = query,
    add_headers("Content-Type" = "application/json"))
  stop_for_status(result)

  content(result, as = "text")
}

format_result <- function(result, ...) {
  result %>%
    fromJSON(simplifyVector = FALSE) %>%
    replace(names(list(...)), list(...)) %>%
    add_class("pkg_search_result")
}

pkg_search_again <- function() {
  if (is.null(s_data$prev_q)) { stop("No query given, and no previous query") }
  format <- s_data$prev_q[["format"]]
  s_data$prev_q[["format"]] <- if (format == "short") "long" else "short"
  s_data$prev_q
}
