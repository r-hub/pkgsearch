
context("Public API")

test_that("package() works", {

  r1 <- package("igraph0")

  expect_equal(sort(names(r1)), c("Author", "crandb_file_date", "date",
    "Date", "Date/Publication", "Depends", "Description", "License",
    "Maintainer", "NeedsCompilation", "Package", "Packaged", "releases",
    "Repository", "Suggests", "SystemRequirements", "Title", "URL",
    "Version"))

  expect_equal(r1$Version, "0.5.7")

  r2 <- package("igraph", "0.5.5")

  expect_equal(sort(names(r2)), c("Author", "crandb_file_date", "date",
    "Date", "Date/Publication", "Depends", "Description", "License",
    "Maintainer", "Package", "Packaged", "releases", "Repository",
                                  "Suggests", "SystemRequirements", "Title", "URL", "Version"))

  r3 <- package("igraph", "all")

  expect_equal(sort(names(r3)), c("archived", "latest", "name", "revdeps",
    "timeline", "title", "versions"))

})

test_that("list_packages() works", {

  r1 <- list_packages()
  expect_equal(length(r1), 10)
  r1 %>% sapply(names) %>% t() %>% unique() %>% as.vector() %>%
    expect_equal(c("version", "title"))

  r2 <- list_packages(limit = 5)
  expect_equal(length(r2), 5)
  r2 %>% sapply(names) %>% t() %>% unique() %>% as.vector() %>%
    expect_equal(c("version", "title"))

  r3 <- list_packages(from = "igraph", limit = 3)
  expect_equal(length(r3), 3)
  r3 %>% sapply(names) %>% t() %>% unique() %>% as.vector() %>%
    expect_equal(c("version", "title"))
  expect_equal(names(r3)[1], "igraph")

  r4 <- list_packages(format = "latest", from = "igraph0", limit = 2)
  expect_equal(length(r4), 2)
  expect_false(names(r4)[1] == "igraph0")
  r4[[1]] %>%
    names() %>%
    contains(c("Package", "Title", "Author", "date", "releases")) %>%
    all() %>%
    expect_true()

  r5 <- list_packages(format = "full", from = "igraph0", limit = 2)
  expect_equal(length(r5), 2)
  expect_true(names(r5)[1] != "igraph0")
  expect_equal(sort(names(r5[[1]])), c("archived", "latest", "name",
    "revdeps", "timeline", "title", "versions"))

  r6 <- list_packages(format = "full", from = "igraph0", archived = TRUE,
                      limit = 2)
  expect_equal(length(r6), 2)
  expect_equal(names(r6)[1], "igraph0")
  expect_equal(sort(names(r6[[1]])), c("archived", "latest", "name",
    "timeline", "title", "versions"))

})

test_that("cran_events() works", {

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

test_that("releases() works", {

  r1 <- releases()
  expect_true(is.data.frame(r1))
  expect_equal(colnames(r1), c("version", "date"))

})
