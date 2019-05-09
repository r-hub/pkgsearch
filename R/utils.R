
`%||%` <- function(l, r) if (is.null(l)) r else l

check_count <- function(x) {
  if (!is.numeric(x) || length(x) != 1 || as.integer(x) != x ||
      is.na(x) || x < 0) {
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

map <- function(.x, .f, ...) {
  lapply(.x, .f, ...)
}

map_mold <- function(.x, .f, .mold, ...) {
  out <- vapply(.x, .f, .mold, ..., USE.NAMES = FALSE)
  names(out) <- names(.x)
  out
}

map_int <- function(.x, .f, ...) {
  map_mold(.x, .f, integer(1), ...)
}

map_dbl <- function(.x, .f, ...) {
  map_mold(.x, .f, double(1), ...)
}

map_chr <- function(.x, .f, ...) {
  map_mold(.x, .f, character(1), ...)
}

meta <- function(x) {
  attr(x, "metadata")
}

`meta<-` <- function(x, value) {
  attr(x, "metadata") <- value
  x
}


create_file_if_missing <- function(path, parent = TRUE) {
  
  if (parent) {
    dir <- dirname(path)
    if (!file.exists(dir)) { dir.create(dir, recursive = TRUE) }
  }
  
  if (!file.exists(path)) { cat("", file = path) }
  
  invisible(path)
}

extract_only <- function(list, names) {
  names <- intersect(names(list), names)
  list[names]
}

with_wd <- function(dir, expr) {
  wd <- getwd()
  on.exit(setwd(wd))
  setwd(dir)
  eval(expr, envir = parent.frame())
}

trim <- function (x) gsub("^\\s+|\\s+$", "", x)

trim_leading <- function (x)  sub("^\\s+", "", x)

trim_trailing <- function (x) sub("\\s+$", "", x)

check_external <- function(cmdline) {
  system(cmdline, ignore.stdout = TRUE, ignore.stderr = TRUE) %>%
    equals(0)
}

check_couchapp <- function() {
  if (!check_external("couchapp")) {
    stop("Need an installed couchapp")
  }
}

check_curl <- function() {
  if (!check_external("curl --version")) {
    stop("Need a working 'curl'")
  }
}

NA_NULL <- function(x) {
  if (length(x) == 1 && is.na(x)) NULL else x
}

NULL_NA <- function(x) {
  if (is.null(x)) NA else x
}

unboxx <- function(x) {
  if (inherits(x, "scalar") ||
      is.null(x) ||
      is.list(x) ||
      length(x) != 1) x else unbox(x)
}

rsync <- function(from, to, args = "-rtlzv --delete") {
  cmd <- paste("rsync", args, from, to)
  system(cmd, ignore.stdout = TRUE, ignore.stderr = TRUE)
}

query <- function(url, error = TRUE, ...) {
  
  result <- couchdb_uri()$uri %>%
    paste0(url) %>%
    httr::GET(...) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON(...)
  
  if (error && ("error" %in% names(result))) {
    stop("crandb query: ", result$reason, call. = FALSE)
  }
  
  result
}

add_class <- function(x, class_name) {
  if (! inherits(x, class_name)) {
    class(x) <- c(class_name, attr(x, "class"))
  }
  x
}

add_attr <- function(object, key, value) {
  attr(object, key) <- value
  object
}

contains <- function(x, y) y %in% x

isin <- function(x, y) x %in% y

remove_special <- function(list, level = 1) {
  
  assert_that(is.count(level), level >= 1)
  
  if (level == 1) {
    names(list) %>%
      grepl(pattern = "^_") %>%
      replace(x = list, values = NULL)
  } else {
    lapply(list, remove_special, level = level - 1)
  }
  
}

pluck <- function(list, idx) list[[idx]]

`%s%` <- function(lhs, rhs) {
  assert_that(is.string(lhs))
  list(lhs) %>%
    c(as.list(rhs)) %>%
    do.call(what = sprintf)
}

make_id <- function(length = 8) {
  sample(c(letters, LETTERS, 0:9), length, replace = TRUE) %>%
    paste(collapse = "")
}

download_method <- function() {
  if (is.na(capabilities()["libcurl"])) "internal" else "libcurl"
}

