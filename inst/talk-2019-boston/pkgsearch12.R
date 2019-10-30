
#' Cols: 80
#' Rows: 25
#' Empty_wait: 10

# Advanced search, by field
advanced_search(Maintainer = "ORPHANED")

# Non-matching packages
advanced_search("permutation test AND NOT License: GPL OR GNU")

# Packages that have a certain field
advanced_search("_exists_" = "URL")

# Packages that do not have a certain field:
advanced_search("NOT _exists_: URL")

# Regular expressions
advanced_search(Author = "/Joh?nathan/")

# Fuzzy search
advanced_search(Author = "Johnathan~1")
