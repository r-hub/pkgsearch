#' Lists of CRAN packages
#'
#' List packages on CRAN, in different formats.
#'
#' @name cran-package-list
#' @aliases NULL
NULL

#' @importFrom assertthat assert_that is.count is.flag

cran_packages <- function(from, limit,
                          format = c("short", "latest", "full"),
                          archived) {

  assert_that(is_package_name(from))
  assert_that(is.count(limit))
  format <- match.arg(format)
  assert_that(is.flag(archived))

  if (archived && format != "full") {
    warning("Using 'full' format because 'archived' is TRUE")
  }

  url <- switch(format,
                "short" = "/-/desc",
                "latest" = "/-/latest",
                "full" = "/-/all")
  if (archived) url <- "/-/allall"

  url %>%
    paste0('?start_key="', from, '"') %>%
    paste0("&limit=", limit) %>%
    query() %>%
    remove_special(level = 2)
}

#' @section `cran_package_list()`:
#' For all `limit` packages , returns title and version number only.
#' @param from The name of the first package to list. By default it
#'    is the first one in alphabetical order.
#' @param limit The number of packages to list.
#'
#' @return A `tbl_df` with two columns:
#' * version
#' * title
#' @export
#' @rdname cran-package-list
#'
cran_package_list <- function(from = "", limit = 10){

  df_list <- cran_packages(from = from, limit = limit,
                format = "short",
                archived = FALSE) %>%
    lapply(tibble::as_tibble)

  do.call("rbind", df_list)
}


#' @section `cran_active_packages()`:
#' For all `limit` packages , returns the complete description of the latest version.
#' @inheritParams cran_package_list
#'
#' @return A `tbl_df`  with as many columns as possible description fields.
#' @export
#' @rdname cran-package-list
#'
cran_active_packages <- function(from = "", limit = 10){

  df_list <- cran_packages(from = from, limit = limit,
                           format = "latest",
                           archived = FALSE) %>%
    lapply(rectangle_description)

  df_list <- make_col_compatible(df_list)

  do.call("rbind", df_list)
}

#' @section `cran_package_histories()`:
#' For all `limit` packages , returns the complete description of all versions.
#' @inheritParams cran_package_list
#' @param archived Whether to include archived packages in the result.
#'
#' @return A `tbl_df` with as many columns as possible description fields,
#' as well as an `archived` Boolean column.
#' @export
#' @rdname cran-package-list
#'

cran_package_histories <- function(from = "", limit = 10,
                                      archived = FALSE){

  df_list <- cran_packages(from = from, limit = limit,
                           format = "full",
                           archived = archived) %>%
    lapply(rectangle_history)

  df_list <- make_col_compatible(df_list)

  do.call("rbind", df_list)
}

add_names <- function(df, all_names){
  if(any(! all_names %in% names(df))){

    df[all_names[! all_names %in% names(df)]] <- NA
  }

  df
}

make_col_compatible <- function(df_list){
  all_names <- unique(unlist(lapply(df_list, names)))
  df_list <- lapply(df_list,
                    add_names,
                    all_names)
  df_list
}

dep_types <- function(){
  c("Depends", "Imports", "Suggests", "Enhances",
    "LinkingTo")
}

rectangle_history <- function(list){


  df_list <- lapply(list$versions,
                    rectangle_description)

  df_list <- make_col_compatible(df_list)

  df <- do.call("rbind", df_list)

  df$archived <- list$archived[[1]]

  df

  if (!"revdeps" %in% names(df)) {
    df$revdeps <- 0
  }

  df

}

rectangle_description <- function(description_list){

  if (length(description_list$releases) == 0) {
    description_list$releases <- NULL
  } else {
    description_list$releases <- list(description_list$releases)
  }

  description_list$dependencies <- list(idesc_get_deps(description_list))

  description_list[dep_types()] <- NULL

  tibble::as_tibble(description_list)

}

# adapted from https://github.com/r-lib/desc/blob/4f60833fdb6d1aae4cbf09b7eb293c5fa0770e5c/R/deps.R#L68

idesc_get_deps <- function(description_list) {

  types <- intersect(names(description_list), dep_types())
  res <- lapply(types, function(type)
    parse_deps(type, description_list[type]))
  empty <- data.frame(
    stringsAsFactors = FALSE,
    type = character(),
    package = character(),
    version = character()
  )
  do.call(rbind, c(list(empty), res))
}


parse_deps <- function(type, deps) {
  res <- data.frame(
    stringsAsFactors = FALSE,
    type = type,
    package = names(deps[type][[1]]),
    version = as.character(deps[[1]])
  )

  res
}

# from https://github.com/r-lib/desc/blob/42b9578f374bf685610b1efb05315927ae236d5b/R/utils.R#L4

str_trim <- function(x) {
  sub("^\\s+", "", sub("\\s+$", "", x))
}
