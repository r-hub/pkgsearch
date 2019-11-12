
exif <- function(cond, exprs) {
  if (cond) {
    exprs <- substitute(exprs)
    if (is.call(exprs)) {
      if (exprs[[1]] == quote(`{`))
        exprs <- as.list(exprs[-1])
    }
    source(exprs = exprs, local = parent.frame(), print.eval = TRUE,
           echo = TRUE, max.deparse.length = Inf,
           width.cutoff = max(20, getOption("width")),
           deparseCtrl = c("keepInteger", "showAttributes", "keepNA"))
  }
}
