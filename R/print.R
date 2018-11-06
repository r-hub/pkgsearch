

print_header <- function(result) {
  left <- "-" %+% ' "' %+% meta(result)$query %+% '" '
  pkg <- if (meta(result)$total == 1) "package" else "packages"
  right <- " " %+% as.character(meta(result)$total) %+% " " %+% pkg %+%
    " in " %+% as.character(round(meta(result)$took / 1000, 3)) %+%
    " seconds " %+% "-"
  left_right(left, right, fill = "-") %>%
    cat("\n")
}

#' @export
#' @importFrom utils capture.output

summary.pkg_search_result <- function(object, ...) {
  print_header(object)

  if (meta(object)$total > 0) {
    pkgs <- data.frame(
      stringsAsFactors = FALSE,
      check.names = FALSE,
      " #" = meta(object)$from + seq_len(nrow(object)) - 1,
      " " = round(object$score / meta(object)$max_score * 100),
      package = object$package,
      version = object$version,
      by = object$maintainer_name,
      "  @" = time_ago(object$date, format = "terse")
    )

    w <- max(nchar(capture.output(print(pkgs, row.names = FALSE))))
    tw <- getOption("width") - w - 2
    if (tw >= 5) {
      title <- gsub(object$title, pattern = "\\s+", replacement = " ")
      pkgs$title <- ifelse(
        nchar(title) <= tw, title,
        paste0(substr(title, 1, tw - 3), "..."))
    }

    print(pkgs, row.names = FALSE, right = FALSE)
  }

  invisible(object)
}

#' @export

print.pkg_search_result <- function(x, ...) {
  if (meta(x)$format == "short") {
    return(summary(x, ...))
  } else {
    print_header(x)
    for (i in seq_len(nrow(x))) cat_hit(x, i)
    invisible(x)
  }
}

#' @importFrom prettyunits time_ago

cat_hit <- function(x, no) {

  cat("\n")

  pkg <- x[no, ]

  ## Header
  ago <- time_ago(pkg$date)
  pkg_ver <- as.character(meta(x)$from + no - 1) %+% " " %+%
    pkg$package %+% " @ " %+% as.character(pkg$version)
  left_right(pkg_ver, pkg$maintainer_name %+% ", " %+% ago) %>%
    cat("\n")

  cat_line(nchar(pkg_ver), "\n")

  ## Title
  pkg$title %>%
    sub(pattern = "\\s+", replacement = " ", perl = TRUE) %>%
    paste("#", .) %>%
    strwrap(width = default_width(), indent = 2, exdent = 4) %>%
    cat(sep = "\n")

  ## Description
  pkg$description %>%
    sub(pattern = "\\s+", replacement = " ", perl = TRUE) %>%
    strwrap(width = default_width(), indent = 2, exdent = 2) %>%
    cat(sep = "\n")

  ## URL(s)
  if (!is.na(pkg$url)) {
    pkg$url %>%
      strsplit("[,\\s]+", perl = TRUE) %>%
      extract2(1) %>%
      paste(" ", .) %>%
      cat(sep = "\n")
  }
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
  min(getOption("width"), 121) - 1
}
