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
#' For all packages, returns title and version number only.
#' @param from The name of the first package to list. By default it
#'    is the first one in alphabetical order.
#' @param limit The number of packages to list.
#' @param archived Whether to include archived packages in the result.
#'    
#' @return A `tbl_df` with two columns:
#' * version
#' * title
#' @export
#' @rdname cran-package-list
#' 
cran_package_list <- function(from = "", limit = 10,
                              archived = FALSE){

  df_list <- cran_packages(from = from, limit = limit,
                format = "short",
                archived = archived) %>%
    lapply(tibble::as_tibble) 
  
  do.call("rbind", df_list)
}


#' @section `cran_active_packages()`:
#' For all packages, returns the complete description of the latest version.
#' @inheritParams cran_package_list
#'    
#' @return A `tbl_df` with two columns:
#' * version
#' * title
#' @export
#' @rdname cran-package-list
#' 
cran_active_packages <- function(from = "", limit = 10,
                              archived = FALSE){
  browser()
  df_list <- cran_packages(from = from, limit = limit,
                           format = "latest",
                           archived = archived) 
  
  df <- tibble::as.tibble(
    rbind(lapply(df_list, tibble::as.tibble)))
  to_unnest <- names(df)[unlist(lapply(df, length)) < 2]
  for (col in to_unnest) {
    val <- df[col][[1]][[1]]
    if (nrow(val) > 0){
      df[col] <- val[[1]]  
    } else {
      df[col] <- NULL
    }
    
  }
  
  df
  
  do.call("rbind", df_list)
}

#' @section `cran_package_histories()`:
#' For all packages, returns the complete description of all versions.
#' @inheritParams cran_package_list
#'    
#' @return A `tbl_df` with two columns:
#' * version
#' * title
#' @export
#' @rdname cran-package-list
#' 

cran_package_histories <- function(from = "", limit = 10,
                                      archived = FALSE){

  df_list <- cran_packages(from = from, limit = limit,
                           format = "full",
                           archived = archived) %>%
    lapply(tibblify_history) 
  
  all_names <- unique(unlist(lapply(df_list, names)))
  df_list <- lapply(df_list, 
                    add_names,
                    all_names)
  
  do.call("rbind", df_list)
}

add_names <- function(df, all_names){
  if(any(! all_names %in% names(df))){
    
    df[all_names[! all_names %in% names(df)]] <- NA
  }
  
  df
}

tibblify_history <- function(list){
  
 
  df_list <- lapply(list$versions, 
                    tibblify_description)

  all_names <- unique(unlist(lapply(df_list, names)))
  df_list <- lapply(df_list, 
                    add_names,
                    all_names)
  
  df <- do.call("rbind", df_list)
  
  df$archived <- list$archived[[1]]
  
  df
  
  if (!"revdeps" %in% names(df)) {
    df$revdeps <- 0
  }
  
  df
  
}

# adapted from https://github.com/r-lib/desc/blob/4f60833fdb6d1aae4cbf09b7eb293c5fa0770e5c/R/deps.R#L68

dep_types <- function(){
  c("Depends", "Imports", "Suggests", "Enhances",
    "LinkingTo")
} 

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


tibblify_description <- function(description_list){

  if (length(description_list$releases) == 0) {
    description_list$releases <- NULL
  } else {
    description_list$releases <- list(description_list$releases)
  }
  
  description_list$dependencies <- list(idesc_get_deps(description_list))
  
  description_list[dep_types()] <- NULL
 
  tibble::as_tibble(description_list)
  
}