
## We build the database from a complete CRAN mirror.

build_db <- function(from = NA) {
  pkgs <- list_cran_packages()

  if (!is.na(from)) {
    if (from %in% pkgs$current) {
      idx <- match(from, pkgs$current)
      pkgs$current <- pkgs$current[idx:length(pkgs$current)]
    } else {
      pkgs$current <- character()
      idx <- match(from, pkgs$archive)
      pkgs$archive <- pkgs$archive[idx:length(pkgs$archive)]
    }
  }

  for (pkg in pkgs$current) { add_package(pkg) }
  for (pkg in pkgs$archive) { add_package(pkg, archived = TRUE) }
}

#' List all packages in a CRAN mirror.
#'
#' This includes archived packages, but currently does
#' not include packages whose name was reused by another package.
#'
#' @noRd

list_cran_packages <- function() {
  current <- current_rds() %>%
    rownames() %>%
    sub(pattern = "_.*$", replacement = "")

  archive <- archive_rds() %>%
    names()

  list(
    current = current %>% unique() %>% sort(),
    archive = archive %>% setdiff(current) %>% unique() %>% sort()
  )
}

archive_rds <- function() {
  cran_mirror() %>%
    file.path(archive_rds_path) %>%
    readRDS()
}

packages_rds <- function() {
  rds <- cran_mirror() %>%
    file.path(packages_rds_path) %>%
    readRDS()
  rownames(rds) <- rds[, "Package"]
  rds
}

current_rds <- function() {
  current <- cran_mirror() %>%
    file.path(current_rds_path) %>%
    readRDS()

  packages <- packages_rds()

  current <- current[rownames(current) %in% rownames(packages),, drop = FALSE ]
  packages <- packages[rownames(current), , drop = FALSE]

  rownames(current) <- paste0(rownames(current), "_",
                              packages[, "Version"], ".tar.gz")
  current
}

add_package <- function(pkg, archived = FALSE) {

  descs <- get_descriptions(pkg) %>%
    remove_bundles()

  archived_at <- if (isTRUE(archived)) archival_date(pkg)

  if (nrow(descs) > 0) {
    descs %>%
      pkg_to_json(archived = archived, archived_at = archived_at) %>%
      couch_add(id = pkg)
  }
}

archival_date <- function(pkg) {
  cran_mirror() %>%
    file.path("web", "packages", pkg) %>%
    file.info() %>%
    extract2("mtime")
}

## TODO: do something with bundles

remove_bundles <- function(dcf) {
  if ("Bundle" %in% colnames(dcf)) {
    dcf <- dcf[is.na(dcf[, "Bundle"]), , drop = FALSE]
  }
  dcf
}

get_descriptions <- function(pkg) {
  list_tarballs(pkg) %>%
    sapply(get_desc_from_file, pkg = pkg) %>%
    paste(collapse = "\n\n") %>%
    trim_leading() %>%
    dcf_from_string()
}

get_desc_from_file <- function(file, pkg) {
  file %>%
    from_tarball(files = file.path(pkg, "DESCRIPTION")) %>%
    trim_trailing() %>%
    add_more_info(pkg = pkg, file = file) %>%
    fix_empty_lines() %>%
    fix_continuation_lines()
}

## If there are no spaces in a continuation line, then we indent it

fix_continuation_lines <- function(text) {
  gsub("\\n([^\\n:]+)\\n", "\n  \\1\n", text, useBytes = TRUE,
       perl = TRUE)
}

## TODO: add download url, extract package version from
## file name if no description file, also TITLE, README, etc.

add_more_info <- function(pkg, file, desc) {
  file_date <- file %>%
    file.info() %>%
    extract2("mtime")
  desc <- paste0(desc, "\ncrandb_file_date: ", file_date)

  md5 <- tools::md5sum(normalizePath(file))
  desc <- paste0(desc, "\nMD5sum: ", md5, "\n")

  if (! grepl("^Package:", desc, useBytes = TRUE)) {
    desc <- paste0(desc, "\nPackage: ", pkg, "\n")
  }
  desc
}

fix_empty_lines <- function(text) {
  text %>%
    gsub(pattern = "\\n[ \\t\\r]*\\n", replacement = "\n  .\n",
         perl = TRUE, useBytes = TRUE) %>%
    gsub(pattern = "\\n[ \\t\\r]*\\n", replacement = "\n",
         perl = TRUE, useBytes = TRUE)
}

from_tarball <- function(tar_file, files) {
  tmp <- tempfile()
  on.exit(try(unlink(tmp, recursive = TRUE)))
  dir.create(tmp)

  if (utils::untar(tar_file, files = files, exdir = tmp) != 0L) {
    stop(sprintf("Cannot uncompress tar file `%s`", tar_file))
  }

  file.path(tmp, files) %>%
    sapply(read_file) %>%
    magrittr::set_names(files)
}

read_file <- function(path) {
  if (!file.exists(path)) return("")
  readChar(path, file.info(path)$size, useBytes = TRUE) %>%
    try_to_decode() %>%
    gsub(pattern = '\r\n', replacement = '\n')
}

iconv_or_null <- function(...) {
  iconv(...) %>% NA_NULL()
}

try_to_decode <- function(text) {
  (iconv_or_null(text, from = "UTF-8", "UTF-8") %||%
   iconv_or_null(text, from = "latin1", "UTF-8") %||%
   iconv_or_null(text, from = "latin2", "UTF-8")
  )
}

dcf_from_string <- function(dcf, ...) {
  con <- file()
  on.exit(try(close(con)))
  cat(dcf, file = con)
  read.dcf(con, ...)
}

list_tarballs <- function(pkg) {
  current <- current_rds() %>%
    rownames() %>%
    grep(pattern = paste0("^", pkg, "_"), value = TRUE) %>%
    file.path(pkg_path, .)

  order_by_date <- function(df) {
    if (is.null(df)) {
      df
    } else {
      df[order(df$mtime), ]
    }
  }

  archive <- archive_rds() %>%
    extract2(pkg) %>%
    order_by_date() %>%
    rownames() %>%
    file.path(archive_path, .)

  c(archive, current) %>%
    file.path(cran_mirror(), .)
}
