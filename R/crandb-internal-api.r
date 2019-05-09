
## This is the internal API, *not* the public one

#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON

api <- function(page) {
  couchdb_server()[[1]]$uri %>%
    paste0("/", page) %>%
    GET() %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON(simplifyVector = FALSE)
}

versions <- function(pkg) {
  pkg %>%
    paste0("/all") %>%
    api() %>%
    extract2("versions") %>%
    names()
}

#' @importFrom httr url_ok

exists <- function(pkg) {
  couchdb_server()[[1]]$uri %>%
    paste0("/", pkg) %>%
    url_ok()
}

get_package <- function(pkg) {
  pkg %>%
    paste0("/all") %>%
    api()
}
