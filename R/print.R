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


## ----------------------------------------------------------------------

#' @method summary cran_package
#' @export
#'

summary.cran_package <- function(object, ...) {
  if ("versions" %in% names(object)) {
    summary_cran_package_all(object, ...)
  } else {
    summary_cran_package_single(object, ...)
  }
  invisible(object)
}

#' @importFrom parsedate parse_date
#' @importFrom prettyunits time_ago

summary_cran_package_single <- function(object, ...) {
  cat('CRAN package ' %+% object$Package %+% " " %+% object$Version %+%
        ', ' %+% time_ago(parse_date(object$date)) %+% "\n")
}

#' @importFrom parsedate parse_date

summary_cran_package_all <- function(object, ...) {
  latest_date <- object$versions[[object$latest]]$date
  cat('CRAN package ' %+% object$name %+% ", latest: " %+% object$latest %+%
        ", " %+% time_ago(parse_date(latest_date)))
  if (object$archived) {
    cat(", archived " %+% time_ago(parse_date(object$timeline[["archived"]])))
  }
  cat("\n")
}

## ----------------------------------------------------------------------

#' @method print cran_package
#' @export

print.cran_package <- function(x, ...) {
  if ("versions" %in% names(x)) {
    print_cran_package_all(x, ...)
  } else {
    print_cran_package_single(x, ...)
  }
  invisible(x)
}

print_cran_package_single <- function(x, ...) {
  summary_cran_package_single(x)
  print_cran_package_body(x)
}

print_cran_package_body <- function(x, indent = 0) {
  x <- collapse_dep_fields(x)
  x[["releases"]] <- paste(x[["releases"]], collapse = ", ")
  
  print_field("Title", x$Title, indent = indent)
  print_field("Maintainer", x$Maintainer, indent = indent)
  
  names(x) %>%
    setdiff(c("Title", "Maintainer", "Package", "Authors@R", "Version",
              "date", "crandb_file_date")) %>%
    sort() %>%
    sapply(function(xx) print_field(xx, x[[xx]], indent = indent))
}

print_cran_package_all <- function(x, ...) {
  summary_cran_package_all(x)
  print_cran_package_all_1(x$latest, x$versions[[x$latest]])
  
  names(x$timeline) %>%
    setdiff(c("archived", x$latest)) %>%
    rev() %>%
    ##    sapply(function(xx) print_cran_package_all_1(xx, x$versions[[xx]]))
    paste(collapse = ", ") %>%
    paste("Other versions:", .) %>%
    strwrap(exdent = 2) %>%
    cat(sep = "\n")
}

print_cran_package_all_1 <- function(name, version) {
  cat("['" %+% name %+% "']:\n")
  print_cran_package_body(version, indent = 2)
}

collapse_dep_fields <- function(pkg) {
  for (f in intersect(names(pkg), cran_dep_fields)) {
    pkg[[f]] <- names(pkg[[f]]) %>%
      paste0(" (", pkg[[f]], ")") %>%
      paste(collapse = ", ")
  }
  pkg
}

print_field <- function(key, value, indent = 0) {
  (key %+% ": " %+% value) %>%
    gsub(pattern = "\n", replacement = " ") %>%
    strwrap(indent = indent, exdent = indent + 4) %>%
    cat(sep = "\n")
}

## ----------------------------------------------------------------------
#' @method summary cran_event_list
#' @export

summary.cran_event_list <- function(object, ...) {
  cat("CRAN events (" %+% attr(object, "mode") %+% ")\n")
  paste0(
    sapply(object, "[[", "name"),
    "@",
    sapply(object, function(xx) xx$package$Version),
    ifelse(sapply(object, "[[", "event") == "released", "", "-")
  ) %>% print()
  invisible(object)
}

## ----------------------------------------------------------------------
#' @method print cran_event_list
#' @export
#' @importFrom prettyunits time_ago

print.cran_event_list <- function(x, ...) {
  cat_fill("CRAN events (" %+% attr(x, "mode") %+% ")")
  pkgs <- data.frame(
    stringsAsFactors = FALSE, check.names = FALSE,
    "." = ifelse(sapply(x, "[[", "event") == "released", "+", "-"),
    When = sapply(x, "[[", "date") %>% parse_date() %>% time_ago(format = "short"),
    Package = sapply(x, "[[", "name"),
    Version = sapply(x, function(xx) xx$package$Version),
    RTitle = sapply(x, function(xx) xx$package$Title) %>%
      gsub(pattern = "\\s+", replacement = " ")
  )
  
  tw <- getOption("width") - 7 - 3 -
    max(nchar("When"), max(nchar(pkgs$When))) -
    max(nchar("Package"), max(nchar(pkgs$Package))) -
    max(nchar("Version"), max(nchar(pkgs$Version)))
  pkgs$Title <- substring(pkgs$RTitle, 1, tw)
  pkgs$Title <- ifelse(pkgs$Title == pkgs$RTitle, pkgs$Title,
                       paste0(pkgs$Title, "..."))
  pkgs$RTitle <- NULL
  
  print.data.frame(pkgs, row.names = FALSE, right = FALSE)
  
  invisible(x)
}

## ----------------------------------------------------------------------

#' @method summary r_releases
#' @export

summary.r_releases <- function(object, ...) {
  cat("R releases " %+% object[1,]$version %+% " ... " %+%
        object[nrow(object),]$version %+% "\n")
  invisible(object)
}

## ----------------------------------------------------------------------

#' @method print r_releases
#' @export

print.r_releases <- function(x, ...) {
  cat_fill("R releases")
  rels <- data.frame(
    stringsAsFactors = FALSE,
    Version = x$version,
    Date = x$date %>% parse_date() %>% simple_date()
  )
  print.data.frame(rels, right = FALSE, row.names = FALSE)
  invisible(x)
}

## ----------------------------------------------------------------------
## Utilities

#' @importFrom assertthat assert_that is.string

cat_fill <- function(text) {
  assert_that(is.string(text))
  width <- getOption("width") - nchar(text) - 1
  cat(text, paste(rep("-", width, collapse = "")), sep = "", "\n")
}

simple_date <- function(date) {
  date %>%
    gsub(pattern = "T", replacement = " ", fixed = TRUE) %>%
    gsub(pattern = "+00:00", replacement = "", fixed = TRUE)
}

