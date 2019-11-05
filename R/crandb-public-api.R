
## ----------------------------------------------------------------------
## :pkg, :pkg/:version, :pkg/all

#' Metadata about a CRAN package
#'
#' @param name Name of the package.
#' @param version The package version to query. If `NULL`, the latest
#'   version if returned.
#' @return The package metadata, in a named list.
#' @examples
#' \dontrun{
#' cran_package("pkgsearch")
#' }
#' @export
#' @importFrom assertthat assert_that

cran_package <- function(name, version = NULL) {

  assert_that(is_package_name(name))
  assert_that(is.null(version) || is_package_version(version))

  url <- name
  if (! is.null(version)) url <- paste0(url, "/", version)
  query(url) %>%
    remove_special() %>%
    add_class("cran_package")
}

#' Metadata about multiple CRAN packages
#'
#' @param names Package names. May also contain versions, separated by a
#'   `@@` character.
#' @return A data frame of package metadata, one package per row.
#'
#' @examples \dontrun{
#' # Get metadata about one package
#' cran_packages("rhub")
#' # Get metadata about two packages
#' cran_packages(c("rhub", "testthat"))
#' # Get metadata about two packages at given versions
#' cran_packages(c("rhub@1.1.1", "testthat@2.2.1", "testthat@2.2.0"))
#' # If a version does not exist nothing is returned
#' cran_packages("rhub@notaversion")
#' }
#' @export

cran_packages <- function(names) {
  names <- sub("@", "-", names, fixed = TRUE)
  url <- paste0(
    "/-/versions?keys=[",
    paste0("\"", names, "\"", collapse = ","),
    "]"
  )

  resp <- query(url)

  rectangle_packages(resp)
}

## ----------------------------------------------------------------------
## /-/pkgreleases, /-/archivals, /-/events

#' List of all CRAN events (new, updated, archived packages)
#'
#' @param limit Number of events to list.
#' @param releases Whether to include package releases.
#' @param archivals Whether to include package archivals.
#' @return List of events.
#'
#' @export
#' @examples
#' \dontrun{
#' cran_events()
#' cran_events(limit = 5, releases = FALSE)
#' cran_events(limit = 5, archivals = FALSE)
#' }
#' @importFrom assertthat assert_that is.count is.flag

cran_events <- function(limit = 10, releases = TRUE, archivals = TRUE) {

  assert_that(is.count(limit))
  assert_that(is.flag(releases))
  assert_that(is.flag(archivals))
  assert_that(releases || archivals)

  mode <- if (releases && archivals) {
    "events"
  } else if (releases) {
    "pkgreleases"
  } else {
    "archivals"
  }
  "/-/" %>%
    paste0(mode) %>%
    paste0("?limit=", limit) %>%
    paste0("&descending=true") %>%
    query(simplifyDataFrame = FALSE) %>%
    add_attr("mode", mode) %>%
    add_class("cran_event_list")
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

cran_trending <- function() {
  url <- "https://cranlogs.r-pkg.org/trending"
  resp <- httr::stop_for_status(httr::GET(url))
  cnt <- content(resp, as = "text", encoding = "UTF-8")
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

cran_top_downloaded <- function() {
  url <- "http://cranlogs.r-pkg.org/top/last-week/100"
  resp <- httr::stop_for_status(httr::GET(url))
  cnt <- content(resp, as = "text", encoding = "UTF-8")
  tb <- fromJSON(cnt, simplifyDataFrame = TRUE)$downloads
  names(tb) <- c("package", "count")
  tibble::as_tibble(tb)
}

#' @importFrom assertthat assert_that is.count is.flag

do_cran_query <- function(from, limit,
                          format = c("short", "latest", "full"),
                          archived) {

  assert_that(is_package_name(from))
  assert_that(is.count(limit))
  format <- match.arg(format)
  assert_that(is.flag(archived))

  url <- switch(
    format,
    "short" = "/-/desc",
    "latest" = "/-/latest",
    "full" = "/-/all")

  if (archived) url <- "/-/allall"

  url <- sprintf("%s?start_key=\"%s\"&limit=%d", url, from, limit)
  resp <- query(url)
  remove_special(resp, level = 2)
}

#' Query the history of a package
#'
#' @param package Package name.
#' @return A tibble, with one row per package version.
#' @export

cran_package_history <- function(package) {

  resp <- do_cran_query(
    from = package, limit = 1,
    format = "full",
    archived = TRUE
  )

  df_list <- lapply(resp, function(p) rectangle_packages(p$versions))
  df_list <- make_col_compatible(df_list)
  do.call("rbind", df_list)
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
