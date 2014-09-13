
#' @importFrom httr DELETE PUT stop_for_status

create_index <- function(version = "devel") {
  url <- config_url() %+% "cran" %+% "-" %+% version
  url %>%
    DELETE()

  url %>%
    PUT(body = mapping) %>%
    stop_for_status()
}

create_db <- function() {
  create_index("devel")
}

#' @importFrom jsonlite toJSON
#' @importFrom httr PUT stop_for_status

connect_to_couch <- function(index = "cran-devel",
                             couch_host = "107.170.56.25",
                             couch_port = 5984,
                             couch_db = "cran",
                             from = NULL) {
  river_raw <- list(
    type = "couchdb",
    couchdb = list(
      host = couch_host,
      port = couch_port,
      db = couch_db,
      script = 'couch_river_filter'
    ),
    index = list(
      index = index,
      type = "package"
    )
  )

  river <- toJSON(river_raw, auto_unbox = TRUE)

  if (!is.null(from)) {

    seq_raw <- list(
      couchdb = list(
        last_seq = from
      )
    )
    seq <- toJSON(seq_raw, auto_unbox = TRUE)
    (config_url() %+% "_river/" %+% index %+% "/_seq") %>%
      PUT(body = seq) %>%
      stop_for_status()
  }

  (config_url() %+% "_river/" %+% index %+% "/_meta") %>%
    PUT(body = river) %>%
    stop_for_status()
}

## -----------------------------------------------------------------------

## The idea is that we run this update occasionally, e.g. once a
## week, or maybe more frequently, if it does not take long.
## It really updates all packages (with at least one reverse
## dependency), so it might be a big deal. On the other hand the
## ES DB is very small, so it probably is not.
##
## The bulk update API requires something like this, so that's what
## we need to assemble. Some packages that are already in CouchDB,
## might not be in ES, but these will just give errors that we ignore
##
## { "update": { "_id": "aa", "_type": "package", "_index": "cran-devel" } }
## { "doc" : { "revdeps": 151 } }
## { "update": { "_id": "ab", "_type": "package", "_index": "cran-devel" } }
## { "doc" : { "revdeps": 1 } }
## { "update": { "_id": "ax", "_type": "package", "_index": "cran-devel" } }
## { "doc" : { "revdeps": 25 } }
## ...

#' @importFrom httr GET POST stop_for_status content
#' @importFrom jsonlite fromJSON

add_revdeps <- function(deps_url = "http://db.r-pkg.org/-/deps/",
                        version = "devel") {

  deps_response <- GET(deps_url %+% version)

  stop_for_status(deps_response)

  deps <- content(deps_response, as = "text") %>%
    fromJSON()

  deps_str <- sapply(names(deps), function(pkg) {
    '{ "update": { "_id": "' %+% pkg %+% '" } }\n' %+%
        '{ "doc": { "revdeps": ' %+% as.character(deps[[pkg]]) %+% ' } }\n'
  })

  upd_str <- paste(deps_str, collapse = "")

  url <- config_url() %+% "cran-" %+% version %+% "/package/_bulk"
  url %>%
    POST(body = upd_str) %>%
    stop_for_status()
}
