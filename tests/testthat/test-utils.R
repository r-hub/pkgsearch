
context("utils")

test_that("meta", {
  foo <- 42
  expect_identical(meta(foo), NULL)

  meta(foo)$key <- "value"
  meta(foo)$key2 <- "value2"

  expect_identical(
    meta(foo),
    list(key = "value", key2 = "value2"))

  expect_identical(meta(foo)$key, "value")
  expect_identical(meta(foo)$key2, "value2")
})

test_that("check_count", {
  expect_error(check_count(NA_integer_))
  expect_error(check_count(integer()))
  expect_error(check_count(1:2))
  expect_error(check_count(-1))
  expect_error(check_count(1.5))
  expect_error(check_count(list(1)))

  expect_error(check_count(1L), NA)
  expect_error(check_count(1), NA)
  expect_error(check_count(0), NA)
  expect_error(check_count(101), NA)
})

test_that("check_string", {
  expect_error(check_string(123))
  expect_error(check_string(character()))
  expect_error(check_string(letters))
  expect_error(check_string(NA_character_))

  expect_error(check_string("foo"), NA)
  expect_error(check_string(""), NA)
})
