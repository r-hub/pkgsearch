

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
#' @importFrom pretty time_ago

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
