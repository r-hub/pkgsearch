test_that("cran_package_list works", {
  expect_is(cran_package_list(), "tbl_df")
})

test_that("cran_active_packages works", {
  expect_is(cran_active_packages(), "tbl_df")
})


test_that("cran_package_histories works", {
  expect_is(cran_package_histories(), "tbl_df")
})
