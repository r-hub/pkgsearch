
context("Public API")

test_that("cran_package() works", {

  skip_if_offline()

  r1 <- cran_package("igraph0")

  expect_equal(sort(names(r1)), sort(c("Author", "crandb_file_date", "date",
    "Date", "Date/Publication", "Depends", "Description", "License",
    "Maintainer", "NeedsCompilation", "Package", "Packaged", "releases",
    "Repository", "Suggests", "SystemRequirements", "Title", "URL",
    "Version")))

  expect_equal(r1$Version, "0.5.7")

  r2 <- cran_package("igraph", "0.5.5")

  expect_equal(sort(names(r2)), sort(c("Author", "crandb_file_date", "date",
    "Date", "Date/Publication", "Depends", "Description", "License",
    "Maintainer", "Package", "Packaged", "releases", "Repository",
    "Suggests", "SystemRequirements", "Title", "URL", "Version")))

  r3 <- cran_package("igraph", "all")

  expect_equal(sort(names(r3)), c("archived", "latest", "name", "revdeps",
    "timeline", "title", "versions"))

})

test_that("cran_events() works", {

  skip_if_offline()

  r1 <- cran_events()
  expect_true(is.null(names(r1)))
  expect_equal(length(r1), 10)
  expect_equal(names(r1[[1]]), c("date", "name", "event", "package"))
  r1 %>%
    sapply(pluck, "event") %>%
    isin(c("released", "archived")) %>%
    all() %>%
    expect_true()

  r2 <- cran_events(limit = 2)
  expect_equal(length(r2), 2)
  expect_equal(names(r2[[1]]), c("date", "name", "event", "package"))

  r3 <- cran_events(limit = 2, releases = FALSE)
  expect_equal(length(r3), 2)
  expect_equal(names(r3[[1]]), c("date", "name", "event", "package"))

  r4 <- cran_events(limit = 2, archivals = FALSE)
  expect_equal(length(r4), 2)
  expect_equal(names(r4[[1]]), c("date", "name", "event", "package"))

})
