dep_fields <- c("Depends", "Imports", "Suggests", "Enhances", "LinkingTo")
## CRAN configuration, just to keep it at a single place

pkg_path_comps <- list("src", "contrib")
pkg_path <- do.call(file.path, pkg_path_comps)
archive_path_comps <- list("src", "contrib", "Archive")
archive_path <- do.call(file.path, archive_path_comps)
archive_rds_path_comps <- list("src", "contrib", "Meta", "archive.rds")
archive_rds_path <- do.call(file.path, archive_rds_path_comps)
current_rds_path_comps <- list("src", "contrib", "Meta", "current.rds")
current_rds_path <- do.call(file.path, current_rds_path_comps)
packages_rds_path_comps <- list("web", "packages", "packages.rds")
packages_rds_path <- do.call(file.path, packages_rds_path_comps)

cran_dep_fields  <- c("Depends", "Imports", "Suggests", "Enhances",
                      "LinkingTo")

cache_dir_var <- "CRANDB_CACHE_DIR"

## CRAN@github configuration

cran_mirror_default <- NA_character_
couchdb_uri <- function(){
  list(uri = "http://crandb.r-pkg.org/")
}

service <- NA


.onLoad <- function(libname, pkgname) {
  if (file.exists(".env")) dotenv::load_dot_env()
  lib <- library
  lib("methods")
  service <<- "crandb-" %+% make_id()
  crandb_production()
}

crandb_dev <- function() {
  nonroot <- list(list(uri = "http://crandb-dev.r-pkg.org/",
                       priority = 10))
  user <- couchdb_user()
  passwd <- couchdb_password()
  uri <- "https://" %+% user %+% ":" %+% passwd %+% "@" %+%
    "crandb.r-pkg.org:6984/cran-dev"
  root <- list(list(uri = uri, priority = 10))
  couchdb_server(nonroot, root = FALSE)
  couchdb_server(root, root = TRUE)
}

crandb_production <- function() {
  uri <- "https://" %+% couchdb_user() %+% ":" %+% couchdb_password() %+%
    "@" %+% "crandb.r-pkg.org:6984/cran"
  root <- list(list(uri = uri, priority = 10))
  couchdb_server(couchdb_uri(), root = FALSE)
  couchdb_server(root, root = TRUE)
}

## R release dates

r_releases <- read.table(header = TRUE, stringsAsFactors = FALSE,
                         textConnection(
"version      date
3.1.1   2014-07-10
3.1.0   2014-04-10
3.0.3   2014-03-06
3.0.2   2013-09-25
3.0.1   2013-05-16
3.0.0   2013-04-03
2.15.3  2013-03-01
2.15.2  2012-10-26
2.15.1  2012-06-22
2.15.0  2012-03-30
2.14.2  2012-02-29
2.14.1  2011-12-22
2.14.0  2011-10-31
2.13.2  2011-09-30
2.13.1  2011-07-08
2.13.0  2011-04-13
2.12.2  2011-02-25
2.12.1  2010-12-16
2.12.0  2010-10-15
2.11.1  2010-05-31
2.11.0  2010-04-22
2.10.1  2009-12-14
2.10.0  2009-10-26
2.9.2   2009-08-24
2.9.1   2009-06-26
2.9.0   2009-04-17
2.8.1   2008-12-22
2.8.0   2008-10-20
2.7.2   2008-08-25
2.7.1   2008-06-23
2.7.0   2008-04-22
2.6.2   2008-02-08
2.6.1   2007-11-26
2.6.0   2007-10-03
2.5.1   2007-06-28
2.5.0   2007-04-24
2.4.1   2006-12-18
2.4.0   2006-10-03
2.3.1   2006-06-01
2.3.0   2006-04-24
2.2.1   2005-12-20
2.2.0   2005-10-06
2.1.1   2005-06-20
2.1.0   2005-04-18
2.0.1   2004-11-15
2.0.0   2004-10-04
"
))
