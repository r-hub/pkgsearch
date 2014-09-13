
check_string <- function(x) {
  if (!is.character(x) || length(x) != 1 || is.na(x)) {
    stop(x, " is not a string", call. = FALSE)
  }
}

`%+%` <- function(lhs, rhs) {
  check_string(lhs)
  check_string(rhs)
  paste0(lhs, rhs)
}
