
context("print")

test_that("short", {
  skip_on_cran()

  x <- ps("csardi")
  out <- capture.output(print(x))
  expect_equal(length(out), 12)
  expect_match(out[1], "csardi.*packages in.*seconds")
  expect_match(out[2], "#\\s+package\\s+version\\s+by\\s+@\\s+title")
  expect_match(out[3], "100\\s+igraph.*Gábor Csárdi.*Network Analysis")
})

test_that("long", {
  skip_on_cran()

  x <- ps("csardi", "long")
  out <- capture.output(print(x))
  expect_match(out[1], "csardi.*packages in.*seconds")
  expect_match(out[3], "^1 igraph")
  expect_true(any(grepl("igraph.org", out, fixed = TRUE)))
  expect_true(any(grepl("G.bor Cs.rdi", out)))
})

test_that("left_right if they do not fit", {
  expect_equal(
    left_right("12345678901234567890", "1234567890", width = 20),
    "          1234567890\n12345678901234567890"
  )
})
