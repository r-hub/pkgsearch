test_that("needs_packages works", {
  
  mockery::stub(what = "requireNamespace",
                where = needs_packages,
                how = FALSE)
  
  expect_error(
    needs_packages(c("memoise", "shiny", "shinyjs")),
    "are needed", class = "rlib_error")
  
  mockery::stub(what = "requireNamespace",
                where = needs_packages,
                how = function(x, ...) {
                  if (x == "shiny") FALSE
                  else TRUE
                })
  
  expect_error(
    needs_packages(c("memoise", "shiny", "shinyjs")),
    "is needed", class = "rlib_error")
  
})
