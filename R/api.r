
## ----------------------------------------------------------------------

prev_q <- NULL

.onLoad <- function(libname, pkgname) {
  unlockBinding("prev_q", asNamespace(pkgname))
  invisible()
}

.onAttach <- function(libname, pkgname) {
  unlockBinding("prev_q", asNamespace(pkgname))
  invisible()
}

#' Search CRAN packages
#'
#' @details
#' Note that the search needs a working Internet connection.
#'
#' @param query Search query string. If this argument is missing
#'   then the results of the last query are printed, in \sQuote{short}
#'   and \sQuote{long} formats, in turns for successive \code{see()}
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
#' @param server The server to use.
#' @param port Port to use.
#' @return A list of packages, in a special object.
#'
#' @export
#' @family seer
#' @examples
#' \donttest{
#' ## Some example searches
#' see("networks")
#' see("survival")
#' see("graphics")
#' see("google")
#' }

see <- function(query, format = c("short", "long"), from = 1, size = 10,
                server = "seer.r-pkg.org", port = 9200) {

  if (missing(query)) { return(see_again()) }
  format <- match.arg(format)

  index <- "cran-devel"
  type <- "package"

  result <- make_query(query = query) %>%
    do_query(server = server, port = port, index = index, type = type,
             from = from, size = size) %>%
    format_result(query = query, format = format, from = from,
                  size = size, server = server, port = port)

  prev_q <<- result

  result
}

#' Next page after a seer search
#'
#' @inheritParams see
#' @family seer
#' @export

more <- function(format = c("short", "long"), size) {
  if (is.null(prev_q)) { stop("No query, start with 'see'") }
  if (missing(format)) {
    format <-prev_q$format
  } else {
    format <- match.arg(format)
  }
  if (missing(size)) {
    size <- prev_q$size
  } else {
    check_count(size)
  }
  see(query = prev_q$query, format = format,
      from = prev_q$from + prev_q$size, size = size,
      server = prev_q$server, port = prev_q$port)
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
    as.character(from - 1) %+% "&size=" %+% as.character(size)
  result <- POST(url, body = query)
  stop_for_status(result)

  content(result, as = "text")
}

format_result <- function(result, ...) {
  result %>%
    fromJSON(simplifyVector = FALSE) %>%
    replace(names(list(...)), list(...)) %>%
    add_class("seer_result")
}

see_again <- function() {
  if (is.null(prev_q)) { stop("No query given, and no previous query") }
  format <- prev_q[["format"]]
  prev_q[["format"]] <<- if (format == "short") "long" else "short"
  prev_q
}
