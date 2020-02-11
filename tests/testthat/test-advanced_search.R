test_that("advanced_search works", {
  query <- '{
"query": {
  "bool": {
    "must_not": {
      "exists": {
        "field": "URL"
      }
    }
  }
}
}'
  expect_error(
    advanced_search(json = query, Author = "Hester"),
    "You cannot specify", class = "rlib_error"
    )
  
  vcr::use_cassette("advanced_search_jsonquery",{
    as <- advanced_search(json = query)
  })
  
  expect_is(as, "pkg_search_result")
  expect_equal(names(as), 
               c("score", "package", "version", "title", "description", 
                 "date", "maintainer_name", "maintainer_email", "revdeps", 
                 "downloads_last_month", 
                 "license", "url", "bugreports", "package_data"))
  
  vcr::use_cassette("advanced_search_terms",{
    as2 <- advanced_search("permutation test AND NOT License: GPL OR GNU")
  })
  
  expect_is(as2, "pkg_search_result")
  expect_equal(names(as2), 
               c("score", "package", "version", "title", "description", 
                 "date", "maintainer_name", "maintainer_email", "revdeps", 
                 "downloads_last_month", 
                 "license", "url", "bugreports", "package_data"))
  
})
