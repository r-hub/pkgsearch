
skip_if_offline <- function() {
  if (!is_online()) skip("Offline")
}

if (getOption("repos")["CRAN"] == "@CRAN@") {
  options(repos = structure(c(CRAN = "http://cran.rstudio.com")))
}
