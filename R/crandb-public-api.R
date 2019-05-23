
## ----------------------------------------------------------------------
## :pkg, :pkg/:version, :pkg/all

#' Metadata about a CRAN package
#'
#' @param name Name of the package.
#' @param version The package version to query. If `NULL`, the latest
#'   version if returned. If it is \sQuote{`all`}, then all versions
#'   are returned. Otherwise it should be a version number.
#' @return The package metadata (information from DESCRIPTION, latest 
#' CRAN release).
#' @examples
#' \dontrun{
#' cran_package("pkgsearch")
#' }
#'
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

## ----------------------------------------------------------------------
## /-/releases

#' List R releases in the CRANDB database
#'
#' @return List of R releases.
#' @examples
#' \dontrun{
#' cran_releases()
#' }
#'
#' @export

cran_releases <- function() {

  "/-/releases" %>%
    query() %>%
    add_class("r_releases")
}
