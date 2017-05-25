
config <- function(var, default = "") {
  Sys.getenv(var, default)
}

config_hostname <- function() {
  config("ES_HOSTNAME", default = "seer.r-pkg.org")
}

config_username <- function() { config("ES_USERNAME") }

config_password <- function() { config("ES_PASSWORD") }

config_port <- function() { config("ES_PORT", default = "5001") }

config_url <- function() {
  "http://" %+% config_username() %+% ":" %+% config_password() %+% "@" %+%
    config_hostname() %+% ":" %+% config_port() %+% "/"
}
