
test_that("cran_packages works", {
  vcr::use_cassette("cran_packages",{
    tab <- cran_packages(c("igraph", "pkgconfig@1.0.0"))
  })
  expect_is(tab, "tbl_df")
  expect_equal(tab$Package, c("igraph", "pkgconfig"))
})

test_that("cran_package_histories works", {

  vcr::use_cassette("cran_package_history_igraph", {
    tab <- cran_package_history("igraph")
  })
  
  expect_is(tab, "tbl_df")
  expect_true(nrow(tab) >= 45)
  expect_true(all(tab$Package == "igraph"))
  expect_false(is.unsorted(tab$Version))
})
