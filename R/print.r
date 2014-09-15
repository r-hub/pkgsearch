

header <- function(result) {
  left <- 'SAW "' %+% result$query %+% '" '
  pkg <- if (result$hits$total == 1) "package" else "packages"
  right <- " " %+% as.character(result$hits$total) %+% " " %+% pkg %+%
    " in " %+% as.character(round(result$took / 1000, 3)) %+%
    " seconds " %+% "---"
  left_right(left, right, fill = "-") %>%
    cat("\n")
}

#' @method summary seer_result
#' @export

summary.seer_result <- function(object, ...) {
  header(object)

  if (object$hits$total > 0) {

    sources <- lapply(object$hits$hits, "[[", "_source")

    pkgs <- data.frame(
      stringsAsFactors = FALSE,
      N = as.character(seq_along(sources) + object$from - 1),
      Package = pluck(sources, "Package"),
      RTitle = pluck(sources, "Title") %>%
        gsub(pattern = "\\s+", replacement = " ")
    )

    tw <- getOption("width") - 7 - max(nchar(pkgs$N)) -
      max(nchar("Package") + 2, max(nchar(pkgs$Package)))
    pkgs$Title <- substring(pkgs$RTitle, 1, tw)
    pkgs$Title <- ifelse(pkgs$Title == pkgs$RTitle, pkgs$Title,
                         paste0(pkgs$Title, "..."))
    pkgs$RTitle <- NULL
    names(pkgs) <- c("#", "# Title", "# Package")

    print.data.frame(pkgs, row.names = FALSE, right = FALSE)

  }

  invisible(object)
}

#' @method print seer_result
#' @export

print.seer_result <- function(x, ...) {
  if (x$format == "short") { return(summary(x, ...)) }
  header(x)
  for (i in seq_along(x$hits$hits)) {
    cat_hit(i + x$from - 1, x$hits$hits[[i]])
  }
  invisible(x)
}

#' @importFrom parsedate parse_iso_8601

cat_hit <- function(no, pkg) {

  cat("\n")

  ## Header
  mtn <- pkg[["_source"]]$Maintainer %>%
    sub(pattern = "\\s+<.*$", replacement = "", perl = TRUE)

  ago <- pkg[["_source"]]$date %>%
    parse_iso_8601() %>%
    time_ago()

  pkg_ver <- as.character(no) %+% " " %+% pkg[["_source"]]$Package %+%
    " @ " %+% pkg[["_source"]]$Version

  left_right(pkg_ver, mtn %+% ", " %+% ago) %>%
    cat("\n")

  cat_line(nchar(pkg_ver), "\n")

  ## Title
  pkg[["_source"]]$Title %>%
    sub(pattern = "\\s+", replacement = " ", perl = TRUE) %>%
    paste("#", .) %>%
    strwrap(width = default_width(), indent = 2, exdent = 4) %>%
    cat(sep = "\n")

  ## Description
  pkg[["_source"]]$Description %>%
    sub(pattern = "\\s+", replacement = " ", perl = TRUE) %>%
    strwrap(width = default_width(), indent = 2, exdent = 2) %>%
    cat(sep = "\n")

  ## URL(s)
  if (!is.null(pkg[["_source"]]$URL)) {
    pkg[["_source"]]$URL %>%
      strsplit("[,\\s]+", perl = TRUE) %>%
      extract2(1) %>%
      paste(" ", .) %>%
      cat(sep = "\n")
  }
}

cat_fill <- function(text) {
  check_string(text)
  width <- getOption("width") - nchar(text) - 1
  cat(text, paste(rep("-", width, collapse = "")), sep = "", "\n")
}

cat_line <- function(length, ...) {
  rep("-", length) %>%
    paste(collapse = "") %>%
    cat()
  cat(...)
}

#' @importFrom lubridate now as.duration
#' @importFrom falsy "%&&%"

time_ago <- function(date) {

  if (length(date) > 1) return(sapply(date, time_ago))

  seconds <- now() %>%
    subtract(date) %>%
    as.duration() %>%
    unclass()

  minutes <- seconds / 60
  hours <- minutes / 60
  days <- hours / 24
  years <- days / 365.25

  (seconds < 10)  %&&% return("moments ago")
  (seconds < 45)  %&&% return("less than a minute ago")
  (seconds < 90)  %&&% return("about a minute ago")
  (minutes < 45)  %&&% return("%d minutes ago" %s% trunc(minutes))
  (minutes < 90)  %&&% return("about an hour ago")
  (hours   < 24)  %&&% return("%d hours ago" %s% trunc(hours))
  (hours   < 42)  %&&% return("a day ago")
  (days    < 30)  %&&% return("%d days ago" %s% trunc(days))
  (days    < 45)  %&&% return("about a month ago")
  (days    < 365) %&&% return("%d months ago" %s% trunc(days / 30))
  (years   < 1.5) %&&% return("about a year ago")
  "%d years ago" %s% trunc(years)
}

right_align <- function(str, width = default_width(), fill = " ") {

  nc <- nchar(str)
  no_sp <- max(width - nc, 0)
  rep(fill, no_sp) %>%
    paste0(collapse = "") %>%
    paste0(str)
}

left_right <- function(left, right, width = default_width(), fill = " ") {

  nc <- nchar(right)
  left_width <- width - nc
  if (left_width <= 20) {
    ## They do not fit in one line
    right_align(right, width = width, fill = fill) %>%
      paste0("\n") %>%
      paste0(strwrap(left, width = width))
  } else {
    ## They do fit in one line
    left <- paste(left, collapse = " ") %>%
      strwrap(width = left_width - 1, simplify = FALSE) %>%
      extract2(1)
    right <- right_align(right, width = width - nchar(left[1]) - 1,
                         fill = fill)
    left[1] <- left[1] %>%
      paste(right)
    paste(left, collapse = "\n")
  }
}

default_width <- function() {
  min(getOption("width"), 151) -2
}
