
## ----------------------------------------------------------------------
## :pkg, :pkg/:version, :pkg/all

#' Metadata about a CRAN package
#'
#' @param name Name of the package.
#' @param version The package version to query. If `NULL`, the latest
#'   version if returned. If it is \sQuote{`all`}, then all versions
#'   are returned. Otherwise it should be a version number.
#' @return The package metadata.
#'
#' @export
#' @importFrom assertthat assert_that

package <- function(name, version = NULL) {

  assert_that(is_package_name(name))
  assert_that(is.null(version) || is_package_version(version))

  url <- name
  if (! is.null(version)) url <- paste0(url, "/", version)
  query(url) %>%
    remove_special() %>%
    add_class("cran_package")
}

## ----------------------------------------------------------------------
## /-/all, /-/latest, /-/desc, /-/allall

#' List active packages
#'
#' @param from The name of the first package to list. By default it
#'    is the first one in alphabetical order.
#' @param limit The number of packages to list.
#' @param format What to return. \sQuote{`short`} means the
#'    title and version number only. \sQuote{`latest`} means
#'    the complete description of the latest version. \sQuote{`full`}
#'    means all versions.
#' @param archived Whether to include archived packages in the result.
#'    If this is `TRUE`, then `format` must be
#'    \sQuote{`full`}.
#' @return List of packages.
#'
#' @export
#' @importFrom assertthat assert_that is.count is.flag

list_packages <- function(from = "", limit = 10,
                          format = c("short", "latest", "full"),
                          archived = FALSE) {

  assert_that(is_package_name(from))
  assert_that(is.count(limit))
  format <- match.arg(format)
  assert_that(is.flag(archived))

  if (archived && format != "full") {
    warning("Using 'full' format because 'archive' is TRUE")
  }

  url <- switch(format,
                "short" = "/-/desc",
                "latest" = "/-/latest",
                "full" = "/-/all")
  if (archived) url <- "/-/allall"

  url %>%
    paste0('?start_key="', from, '"') %>%
    paste0("&limit=", limit) %>%
    query() %>%
    remove_special(level = 2) %>%
    add_class("cran_package_list")
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
#' @importFrom assertthat assert_that is.count is.flag

events <- function(limit = 10, releases = TRUE, archivals = TRUE) {

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

## ----------------------------------------------------------------------
## /-/releases

#' List R releases in the CRANDB database
#'
#' @return List of R releases.
#'
#' @export

releases <- function() {

  "/-/releases" %>%
    query() %>%
    add_class("r_releases")
}
