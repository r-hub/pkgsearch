
exif <- function(cond, exprs) {
  if (cond) {
    if (getRversion() >= "3.4") {
      exprs <- substitute(exprs)
      if (is.call(exprs)) {
        if (exprs[[1]] == quote(`{`))
          exprs <- as.list(exprs[-1])
      }
      withAutoprint(exprs, evaluated = TRUE)
    } else {
      force(exprs)
    }
  }
}
