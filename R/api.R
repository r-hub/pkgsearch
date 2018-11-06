
. <- "dot"

## ----------------------------------------------------------------------

s_data <- new.env()

#' Search CRAN packages
#'
#' @description
#' `pkg_search()` starts a new search query, or shows the details of the
#' previous query, if called without arguments.
#'
#' `ps()` is an alias to `pkg_search()`.
#'
#' `more()` retrieves that next page of results for the previous query.
#' 
#' @details
#' Note that the search needs a working Internet connection.
#'
#' @param query Search query string. If this argument is missing or
#'   `NULL`, then the results of the last query are printed, in
#'   _short_ and _long_ formats, in turns for successive
#'   `pkg_search()` calls. If this argument is missing, then all
#'   other arguments are ignored.
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

#' @rdname pkg_search
#' @export

ps <- pkg_search

make_pkg_search <- function(query, format, from, size, server, port) {

  result <- make_query(query = query) %>%
    do_query(server = server, port = port, from = from, size = size) %>%
    format_result(query = query, format = format, from = from,
                  size = size, server = server, port = port)

  s_data$prev_q <- result

  result
}

#' @rdname pkg_search
#' @export

more <- function(format = NULL, size = NULL) {
  if (is.null(s_data$prev_q)) { stop("No query, start with 'pkg_search'") }
  make_pkg_search(
    query = meta(s_data$prev_q)$query,
    format = format %||% meta(s_data$prev_q)$format,
    from = meta(s_data$prev_q)$from + meta(s_data$prev_q)$size,
    size = size %||% meta(s_data$prev_q)$size,
    server = meta(s_data$prev_q)$server,
    port = meta(s_data$prev_q)$port
  )
}

#' @importFrom jsonlite toJSON

make_query <- function(query) {

  check_string(query)

  fields <- c("Package^20", "Title^10", "Description^2",
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
                     fields = c("Title^10", "Description^2", "_all"),
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

do_query <- function(query, server, port, from, size) {

  check_count(from)
  check_count(size)

  url <- "http://" %+% server %+% ":" %+% as.character(port) %+%
    "/package/_search?from=" %+% as.character(from - 1) %+%
    "&size=" %+% as.character(size)
  result <- POST(
    url, body = query,
    add_headers("Content-Type" = "application/json"))
  stop_for_status(result)

  content(result, as = "text")
}

#' @importFrom parsedate parse_iso_8601

format_result <- function(result, query, format, from, size, server,
                          port) {
  result <- fromJSON(result, simplifyVector = FALSE)

  meta <- list(
    query = query,
    format = format,
    from = from,
    size = size,
    server = server,
    port = port,
    total = result$hits$total,
    max_score = result$hits$max_score,
    took = result$took,
    timed_out = result$timed_out
  )

  sources <- map(result$hits$hits, "[[", "_source")
  maintainer <- map_chr(sources, "[[", "Maintainer")

  df <- data.frame(
    stringsAsFactors = FALSE,
    score = map_dbl(result$hits$hits, "[[", "_score"),
    package = map_chr(result$hits$hits, "[[", "_id"),
    version = package_version(map_chr(sources, "[[", "Version")),
    title = map_chr(sources, "[[", "Title"),
    description = map_chr(sources, "[[", "Description"),
    date = parse_iso_8601(map_chr(sources, "[[", "date")),
    maintainer_name = gsub("\\s+<.*$", "", maintainer),
    maintainer_email = gsub("^.*<([^>]+)>.*$", "\\1", maintainer, perl = TRUE),
    revdeps = map_int(sources, "[[", "revdeps"),
    downloads_last_month = map_int(sources, "[[", "downloads"),
    license = map_chr(sources, "[[", "License"),
    url = map_chr(sources, function(x) x$URL %||% NA_character_),
    bugreports = map_chr(sources, function(x) x$BugReports %||% NA_character_),
    package_data = I(sources)
  )

  attr(df, "metadata") <- meta

  requireNamespace("tibble", quietly = TRUE)
  class(df) <- unique(c("pkg_search_result", "tbl_df", "tbl", class(df)))

  df
}

pkg_search_again <- function() {
  if (is.null(s_data$prev_q)) { stop("No query given, and no previous query") }
  format <- meta(s_data$prev_q)$format
  meta(s_data$prev_q)$format <- if (format == "short") "long" else "short"
  s_data$prev_q
}
