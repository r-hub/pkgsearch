
context("search")

test_that("search", {
  skip_if_offline()

  x <- ps("csardi")
  expect_s3_class(x, "tbl")
  expect_s3_class(x, "pkg_search_result")

  expect_true(
    all(c("score", "package", "version", "title", "description", "date",
          "maintainer_name", "maintainer_email", "revdeps",
          "downloads_last_month", "license", "url", "bugreports") %in%
        colnames(x))
  )

  expect_equal(x$package[1], "crayon")
})

test_that("again w/o previous search", {
  s_data$prev_q <- NULL
  expect_error(ps())
})

test_that("more w/o previous search", {
  s_data$prev_q <- NULL
  expect_error(more())
})

test_that("again", {
  skip_if_offline()

  x <- ps("csardi")
  expect_equal(meta(s_data$prev_q$result)$format, "short")
  expect_error(x2 <- ps(), NA)
  expect_equal(meta(s_data$prev_q$result)$format, "long")
  expect_error(x3 <- ps(), NA)
  expect_equal(meta(s_data$prev_q$result)$format, "short")

  expect_s3_class(x2, "tbl")
  expect_s3_class(x2, "pkg_search_result")
  expect_equal(x$package, x2$package)

  expect_s3_class(x3, "tbl")
  expect_s3_class(x3, "pkg_search_result")
  expect_equal(x$package, x3$package)
})

test_that("more", {
  skip_if_offline()

  x <- ps("csardi")
  x2 <- more()

  expect_s3_class(x2, "tbl")
  expect_s3_class(x2, "pkg_search_result")
  expect_true(max(x2$score) <= min(x$score))

  expect_true(
    all(c("score", "package", "version", "title", "description", "date",
          "maintainer_name", "maintainer_email", "revdeps",
          "downloads_last_month", "license", "url", "bugreports") %in%
        colnames(x2))
  )
})
