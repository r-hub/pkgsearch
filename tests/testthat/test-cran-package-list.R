
test_that("cran_packages works", {
  skip_if_offline()
  tab <- cran_packages(c("igraph", "pkgconfig@1.0.0"))
  expect_s3_class(tab, "tbl")
  expect_equal(tab$Package, c("igraph", "pkgconfig"))
})

test_that("cran_package_histories works", {
  skip_if_offline()
  tab <- cran_package_history("igraph")
  expect_s3_class(tab, "tbl")
  expect_true(nrow(tab) >= 45)
  expect_true(all(tab$Package == "igraph"))
  expect_false(is.unsorted(package_version(tab$Version)))
})
