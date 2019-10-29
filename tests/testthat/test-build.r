
context("Extracting data from CRAN")

test_that("Listing CRAN packages", {
  need_pkgs(c("assertthat", "testthat"))
  expect_equal(list_cran_packages(),
               list(current = c("assertthat", "testthat"),
                    archive = character()))

  need_pkgs(c("assertthat", "igraph0"))
  expect_equal(list_cran_packages(),
               list(current = "assertthat", archive = "igraph0"))
})

test_that("DCF from string", {
  DESC = 'Package: crandb
Title: CRAN metadata in a CouchDB database
Version: 0.1
Authors@R: "Gabor Csardi <csardi.gabor@gmail.com> [aut, cre]"
Description: Build, update and query a CouchDB database
    that contains CRAN metadata, about all versions of all packages.
Imports:
    magrittr,
    rappdirs
'

  dcf <- dcf_from_string(DESC)
  expect_equal(dcf[, "Package"], c(Package = "crandb"))
  expect_equal(dcf[, "Version"], c(Version = "0.1"))
})

test_that("Extract a file from a tarball", {
  tmp <- tempfile()
  on.exit(try(unlink(tmp, recursive = TRUE)), add = TRUE)
  dir.create(tmp)

  cat("Hello world!\n", file = file.path(tmp, "hello.txt"))
  tarfile <- basename(tmp) %>%
    paste0(".tar.gz")
  on.exit(try(unlink(tarfile)), add = TRUE)
  with_wd(tempdir(), tar(tarfile, basename(tmp), compression = "gzip"))

  hello <- basename(tmp) %>%
    file.path("hello.txt")
  cnt <- file.path(tempdir(), tarfile) %>%
    from_tarball(hello)
  expect_equal(unname(cnt), "Hello world!\n")

})

test_that("List tarballs for a package", {
  need_pkgs(c("assertthat", "testthat", "igraph0"))
  expect_equal(
    list_tarballs("assertthat")[1],
    file.path(cran_mirror(), "src/contrib/Archive/assertthat/assertthat_0.1.tar.gz"))

  igraph0_res <- c("src/contrib/Archive/igraph0/igraph0_0.5.5.tar.gz",
                   "src/contrib/Archive/igraph0/igraph0_0.5.5-1.tar.gz",
                   "src/contrib/Archive/igraph0/igraph0_0.5.5-2.tar.gz",
                   "src/contrib/Archive/igraph0/igraph0_0.5.5-3.tar.gz",
                   "src/contrib/Archive/igraph0/igraph0_0.5.6.tar.gz",
                   "src/contrib/Archive/igraph0/igraph0_0.5.6-1.tar.gz",
                   "src/contrib/Archive/igraph0/igraph0_0.5.6-2.tar.gz",
                   "src/contrib/Archive/igraph0/igraph0_0.5.7.tar.gz")

  expect_equal(list_tarballs("igraph0"),
               file.path(cran_mirror(), igraph0_res))
})

test_that("", {
  need_pkgs(c("assertthat", "testthat", "igraph0"))
  desc <- get_descriptions("assertthat")
  expect_true(all(c("Package", "Version", "Title") %in% colnames(desc)))

  desc2 <- get_descriptions("igraph0")
  expect_true(nrow(desc2) >= 8)
  expect_true(all(c("Package", "Version", "Title") %in% colnames(desc2)))
})

test_that("Convert DESCRIPTIONs to JSON", {
  desc <- structure(c("assertthat", "Easy pre and post assertions.", "0.1",
    "'Hadley Wickham <h.wickham@gmail.com> [aut,cre]'",
    "assertthat is an extension to stopifnot() that makes it\neasy to declare the pre and post conditions that you code should\nsatisfy, while also producing friendly error messages so that your\nusers know what they've done wrong.",
    "GPL-3", "testthat", "'assert-that.r' 'on-failure.r' 'assertions-file.r'\n'assertions-scalar.R' 'assertions.r' 'base.r'\n'base-comparison.r' 'base-is.r' 'base-logical.r' 'base-misc.r'\n'utils.r' 'validate-that.R'",
    "list(wrap = FALSE)", "2013-12-05 18:46:37 UTC; hadley",
    "'Hadley Wickham' [aut, cre]", "'Hadley Wickham' <h.wickham@gmail.com>",
    "no", "CRAN", "2013-12-06 00:51:10"), .Dim = c(1L, 15L),
    .Dimnames = list(NULL, c("Package", "Title", "Version", "Authors@R",
    "Description", "License", "Suggests", "Collate", "Roxygen", "Packaged",
    "Author", "Maintainer", "NeedsCompilation", "Repository",
    "Date/Publication")))
  json <- pkg_to_json(desc, archived = FALSE, pretty = TRUE)
  fj <- jsonlite::fromJSON(json, simplifyVector = FALSE)
  expect_equal(sort(names(fj)), c("_id", "archived", "latest", "name",
                                  "timeline", "title", "versions"))
  expect_equal(fj[["_id"]], "assertthat")
  expect_equal(fj[["name"]], "assertthat")

  vers <- fj[["versions"]]
  expect_equal(length(vers), 1)
  expect_equal(sort(names(vers[[1]])),
    sort(c("Author", "Authors@R", "Collate", "date", "Date/Publication",
      "Description", "License", "Maintainer", "NeedsCompilation", "Package",
      "Packaged", "releases", "Repository", "Roxygen", "Suggests", "Title",
      "Version")))
  expect_equal(vers[[1]]$Suggests, structure(list(testthat = "*"),
                                             .Names = "testthat"))
  ## TODO: latest
})

test_that("Convert real DESCRIPTIONs to JSON", {
  need_pkgs(c("assertthat", "testthat", "igraph0"))
  json <- get_descriptions("igraph0") %>%
    pkg_to_json(archived = TRUE, archived_at = parse_date("2013-09-21"),
                pretty = TRUE)
  fj <- jsonlite::fromJSON(json, simplifyVector = FALSE)
  expect_equal(sort(names(fj)), c("_id", "archived", "latest", "name",
                                  "timeline", "title", "versions"))

  vers <- fj[["versions"]]
  expect_equal(length(vers), 8)
  expect_false(is.unsorted(sapply(vers, "[[", "date")))
  expect_equal(names(vers), c("0.5.5", "0.5.5-1", "0.5.5-2", "0.5.5-3",
                              "0.5.6", "0.5.6-1", "0.5.6-2", "0.5.7"))

  expect_equal(names(fj$timeline), c(names(vers), "archived"))
  drop_last <- function(x) x[-length(x)]
  expect_equal(drop_last(unlist(fj$timeline)), sapply(vers, "[[", "date"))
  expect_equal(tail(unlist(fj$timeline), 1),
               c("archived" = format_iso_8601(parse_date("2013-09-21"))))


  expect_equal(fj$latest, "0.5.7")
  expect_equal(fj$title,
    "Network analysis and visualization, old, deprecated package.")
  expect_true(fj$archived)
})
