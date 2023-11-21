test_that("output time zone is always UTC", {
  expect_equal(
    attr(parse_iso_8601("2010-07-01"), "tzone"),
    "UTC")

  expect_equal(
    attr(parse_iso_8601("2010-07-01", default_tz = "CET"), "tzone"),
    "UTC")
})

test_that("input time zone is respected (local CET)", {
  withr::local_timezone("CET")

  d <- parse_iso_8601("2010-07-01", default_tz = "CET")
  expect_equal(d, .POSIXct(as.POSIXct("2010-07-01", "CET"), "UTC"))

  d <- parse_iso_8601("2010-07-01", default_tz = "US/Pacific")
  expect_equal(d, .POSIXct(as.POSIXct("2010-07-01", "US/Pacific"), "UTC"))
})

test_that("input time zone is respected (local US/Pacific)", {
  withr::local_timezone("US/Pacific")

  d <- parse_iso_8601("2010-07-01", default_tz = "CET")
  expect_equal(d, .POSIXct(as.POSIXct("2010-07-01", "CET"), "UTC"))

  d <- parse_iso_8601("2010-07-01", default_tz = "US/Pacific")
  expect_equal(d, .POSIXct(as.POSIXct("2010-07-01", "US/Pacific"), "UTC"))
})

test_that("empty default time zone is the local time zone (CET)", {
  withr::local_timezone("CET")

  d <- parse_iso_8601("2010-07-01", default_tz = "")
  expect_equal(d, .POSIXct(as.POSIXct("2010-07-01", "CET"), "UTC"))
})

test_that("empty default time zone is the local time zone (US/Pacific)", {
  withr::local_timezone("US/Pacific")

  d <- parse_iso_8601("2010-07-01", default_tz = "")
  expect_equal(d, .POSIXct(as.POSIXct("2010-07-01", "US/Pacific"), "UTC"))
})
