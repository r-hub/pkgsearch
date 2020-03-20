
## ----------------------------------------------------------------------
## :pkg, :pkg/:version, :pkg/all

#' Metadata about a CRAN package
#'
#' @param name Name of the package.
#' @param version The package version to query. If `NULL`, the latest
#'   version if returned.
#' @return The package metadata, in a named list.
#' @examples
#' \dontshow{if (pingr::is_online()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
#' cran_package("pkgsearch")
#' \dontshow{\}) # examplesIf}
#' @export
#' @importFrom assertthat assert_that

cran_package <- function(name, version = NULL) {

  assert_that(is_package_name(name))
  assert_that(is.null(version) || is_package_version(version))

  ept <- name
  if (! is.null(version)) ept <- paste0(ept, "/", version)
  rst <- crandb_query(ept)
  crst <- remove_special(rst)
  add_class(crst, "cran_package")
}

#' Metadata about multiple CRAN packages
#'
#' @param names Package names. May also contain versions, separated by a
#'   `@@` character.
#' @return A data frame of package metadata, one package per row.
#'
#' @examples
#' \dontshow{if (pingr::is_online()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
#' # Get metadata about one package
#' cran_packages("rhub")
#' # Get metadata about two packages
#' cran_packages(c("rhub", "testthat"))
#' # Get metadata about two packages at given versions
#' cran_packages(c("rhub@1.1.1", "testthat@2.2.1", "testthat@2.2.0"))
#' # If a version does not exist nothing is returned
#' cran_packages("rhub@notaversion")
#' \dontshow{\}) # examplesIf}
#' @export

cran_packages <- function(names) {
  names <- sub("@", "-", names, fixed = TRUE)
  ept <- paste0(
    "/-/versions?keys=[",
    paste0("\"", names, "\"", collapse = ","),
    "]"
  )

  resp <- crandb_query(ept)

  rectangle_packages(resp)
}

## ----------------------------------------------------------------------
## /-/pkgreleases, /-/archivals, /-/events

#' List of all CRAN events (new, updated, archived packages)
#'
#' @param releases Whether to include package releases.
#' @param archivals Whether to include package archivals.
#' @param limit Number of events to list.
#' @param from Where to start the list, for pagination.
#' @return List of events.
#'
#' @export
#' @examples
#' \dontshow{if (pingr::is_online()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
#' cran_events()
#' cran_events(limit = 5, releases = FALSE)
#' cran_events(limit = 5, archivals = FALSE)
#' summary(cran_events(limit = 10))
#' \dontshow{\}) # examplesIf}
#' @importFrom assertthat assert_that is.count is.flag

cran_events <- function(releases = TRUE, archivals = TRUE, limit = 10,
                        from = 1) {

  assert_that(is.count(limit))
  assert_that(is.flag(releases))
  assert_that(is.flag(archivals))
  assert_that(releases || archivals)
  assert_that(is.count(from))

  mode <- if (releases && archivals) {
    "events"
  } else if (releases) {
    "pkgreleases"
  } else {
    "archivals"
  }

  ept <- paste0(
    "/-/", mode,
    "?limit=", limit,
    "&descending=true",
    "&skip=", from - 1L
  )

  structure(
    crandb_query(ept, simplifyDataFrame = FALSE),
    "mode" = mode,
    class = "cran_event_list"
  )
}

#' Trending R packages
#'
#' Trending packages are the ones that were downloaded at least 1000 times
#' during last week, and that substantially increased their download
#' counts, compared to the average weekly downloads in the previous 24
#' weeks. The percentage of increase is also shown in the output.
#'
#' @return Tibble of trending packages.
#'
#' @export
#' @examples
#' \dontshow{if (identical(Sys.getenv("IN_PKGDOWN"), "true")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
#' cran_trending()
#' \dontshow{\}) # examplesIf}

cran_trending <- function() {
  ept <- "https://cranlogs.r-pkg.org/trending"
  resp <- http_stop_for_status(http_get(ept))
  cnt <- rawToChar(resp$content)
  Encoding(cnt) <- "UTF-8"
  tb <- fromJSON(cnt, simplifyDataFrame = TRUE)
  colnames(tb) <- c("package", "score")
  tibble::as_tibble(tb)
}

#' Top downloaded packages
#'
#' Last week.
#'
#' @return Tibble of top downloaded packages.
#'
#' @details You can use the [`cranlogs` package](https://r-hub.github.io/cranlogs/)
#' to get more flexibility into what is returned.
#'
#' @export
#' @examples
#' \dontshow{if (identical(Sys.getenv("IN_PKGDOWN"), "true")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
#' cran_top_downloaded()
#' \dontshow{\}) # examplesIf}

cran_top_downloaded <- function() {
  ept <- "http://cranlogs.r-pkg.org/top/last-week/100"
  resp <- http_stop_for_status(http_get(ept))
  cnt <- rawToChar(resp$content)
  Encoding(cnt) <- "UTF-8"
  tb <- fromJSON(cnt, simplifyDataFrame = TRUE)$downloads
  names(tb) <- c("package", "count")
  tibble::as_tibble(tb)
}

crandb_query <- function(url, error = TRUE, ...) {

  rst <- url0 <- paste0(couchdb_uri(), url)
  rsp <- http_get(url0)
  cnt <- rawToChar(rsp$content)
  Encoding(cnt) <- "UTF-8"
  rst <- fromJSON(cnt, ...)

  if (error && ("error" %in% names(rst))) {
    throw(new_error("crandb query: ", rst$reason, call. = FALSE))
  }

  rst
}

#' @importFrom assertthat assert_that is.count is.flag

do_crandb_query <- function(from, limit,
                          format = c("short", "latest", "full"),
                          archived) {

  assert_that(is_package_name(from))
  assert_that(is.count(limit))
  format <- match.arg(format)
  assert_that(is.flag(archived))

  ept <- switch(
    format,
    "short" = "/-/desc",
    "latest" = "/-/latest",
    "full" = "/-/all")

  if (archived) ept <- "/-/allall"

  ept <- sprintf("%s?start_key=\"%s\"&limit=%d", ept, from, limit)
  resp <- crandb_query(ept)
  remove_special(resp, level = 2)
}

#' Query the history of a package
#'
#' @param package Package name.
#' @return A tibble, with one row per package version.
#' @export
#' @examples
#' \dontshow{if (pingr::is_online()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
#' cran_package_history("igraph")
#' \dontshow{\}) # examplesIf}

cran_package_history <- function(package) {

  resp <- do_crandb_query(
    from = package, limit = 1,
    format = "full",
    archived = TRUE
  )

  df_list <- lapply(resp, function(p) rectangle_packages(p$versions))
  df_list <- make_col_compatible(df_list)
  res <- do.call("rbind", df_list)

  if (nrow(res) == 0 || res$Package[1] != package) {
    throw(new_no_package_error("Package not found: ", package))
  }

  res
}

add_names <- function(df, all_names) {
  if(any(! all_names %in% names(df))) {

    df[all_names[! all_names %in% names(df)]] <- NA
  }

  df
}

make_col_compatible <- function(df_list) {
  all_names <- unique(unlist(lapply(df_list, names)))
  lapply(df_list, add_names, all_names)
}

dep_types <- function() {
  c("Depends", "Imports", "Suggests", "Enhances", "LinkingTo")
}

rectangle_packages <- function(list) {

  df_list <- lapply(list, rectangle_description)
  df_list <- make_col_compatible(df_list)
  df <- do.call("rbind", df_list)

  drop <- c("revdeps", "archived")
  df <- df[, setdiff(colnames(df), drop)]

  df
}

rectangle_description <- function(description_list) {

  description_list$releases <- NULL

  description_list$dependencies <- list(idesc_get_deps(description_list))

  description_list[dep_types()] <- NULL

  tibble::as_tibble(description_list)
}

idesc_get_deps <- function(description_list) {

  types <- intersect(names(description_list)[lengths(description_list) > 0],
                     dep_types())
  res <- lapply(
    types,
    function(type) parse_deps(type, description_list[type])
  )

  empty <- data.frame(
    stringsAsFactors = FALSE,
    type = character(),
    package = character(),
    version = character()
  )

  do.call(rbind, c(list(empty), res))
}

parse_deps <- function(type, deps) {
  res <- data.frame(
    stringsAsFactors = FALSE,
    type = type,
    package = names(deps[type][[1]]),
    version = as.character(deps[[1]])
  )

  res
}
