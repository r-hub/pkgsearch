
check_count <- function(x) {
  if (!is.numeric(x) || length(x) != 1 || as.integer(x) != x || x < 0) {
    stop(x, " is not a count", call. = FALSE)
  }
}

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

add_class <- function(x, class_name) {
  if (! inherits(x, class_name)) {
    class(x) <- c(class_name, attr(x, "class"))
  }
  x
}

pluck <- function(list, field) {
  sapply(list, "[[", field)
}
