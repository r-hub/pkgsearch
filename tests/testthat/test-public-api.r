context("Public API")

test_that("cran_package() works", {
  vcr::use_cassette("cran_package_igraph0", {
    r1 <- cran_package("igraph0")
  })
 
  expect_equal(sort(names(r1)), sort(c("Author", "crandb_file_date", "date",
    "Date", "Date/Publication", "Depends", "Description", "License",
    "Maintainer", "NeedsCompilation", "Package", "Packaged", "releases",
    "Repository", "Suggests", "SystemRequirements", "Title", "URL",
    "Version")))

  expect_equal(r1$Version, "0.5.7")

  vcr::use_cassette("cran_package_igraph_0.5.5", {
    r2 <- cran_package("igraph", "0.5.5")
  })

  expect_equal(sort(names(r2)), sort(c("Author", "crandb_file_date", "date",
    "Date", "Date/Publication", "Depends", "Description", "License",
    "Maintainer", "Package", "Packaged", "releases", "Repository",
    "Suggests", "SystemRequirements", "Title", "URL", "Version")))
  
  vcr::use_cassette("cran_package_igraph_all", {
    r3 <- cran_package("igraph", "all")
  })

  expect_equal(sort(names(r3)), c("archived", "latest", "name", "revdeps",
    "timeline", "title", "versions"))

})

test_that("cran_events() works", {
  
  vcr::use_cassette("cran_events", {
    r1 <- cran_events()
  })

  expect_true(is.null(names(r1)))
  expect_equal(length(r1), 10)
  expect_equal(names(r1[[1]]), c("date", "name", "event", "package"))
  r1 %>%
    sapply(pluck, "event") %>%
    isin(c("released", "archived")) %>%
    all() %>%
    expect_true()

  vcr::use_cassette("cran_events_limit", {
    r2 <- cran_events(limit = 2)
  })
  
  expect_equal(length(r2), 2)
  expect_equal(names(r2[[1]]), c("date", "name", "event", "package"))

  vcr::use_cassette("cran_events_limit_releasestrue", {
    r3 <- cran_events(limit = 2, releases = FALSE)
  })
  
  expect_equal(length(r3), 2)
  expect_equal(names(r3[[1]]), c("date", "name", "event", "package"))

  vcr::use_cassette("cran_events_limit_archivalsfalse", {
    r4 <- cran_events(limit = 2, archivals = FALSE)
  })
 
  expect_equal(length(r4), 2)
  expect_equal(names(r4[[1]]), c("date", "name", "event", "package"))

})

test_that("cran_package_history() edge cases", {

  set.seed(42)
  random_package <- paste(
    sample(letters, 20, replace = TRUE),
    collapse = ""
  )
  vcr::use_cassette("cran_package_history_random", {
    expect_error(cran_package_history(random_package))
  })
  
  vcr::use_cassette("cran_package_history_zzzzzzzz", {
    expect_error(cran_package_history("zzzzzzzz"))
  })
  
})

test_that("cran_trending() works", {
  vcr::use_cassette("cran_trending", {
    trending <- cran_trending()
  })
  
  expect_is(trending, "tbl_df")
  expect_equal(names(trending), c("package", "score"))
})



test_that("cran_top_downloaded() works", {
  vcr::use_cassette("cran_top_downloaded", {
    trending <- cran_top_downloaded()
  })
  
  expect_is(trending, "tbl_df")
  expect_equal(names(trending), c("package", "count"))
})
