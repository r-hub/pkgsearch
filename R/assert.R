
#' @importFrom assertthat assert_that is.string

is_package_name <- function(string) {
  assert_that(is.string(string))
  grepl("^[0-9a-zA-Z._]*$", string)
}

#' @importFrom assertthat  "on_failure<-"

on_failure(is_package_name) <- function(call, env) {
  paste0(deparse(call$x), " is not a valid package name")
}

#' @importFrom assertthat assert_that is.string noNA

is_string <- function(string) {
  assert_that(is.string(string))
  assert_that(noNA(string))
}

#' @importFrom assertthat  "on_failure<-"

on_failure(is_string) <- function(call, env) {
  paste0(deparse(call$x), " must be a single string with no missing values")
}
