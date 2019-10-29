# pkgsearch (development version)

## Major changes

* New function `advanced_search()` for more search flexibility. It accepts either search terms, named or unnamed; or a character string that contains the query to send to Elastic.

* Using the R-hub crandb API, new functions whose name all start with `cran_`:
    
    * Functions returning metadata about specific packages
    
      * `cran_packages()` returns metadata about multiple CRAN packages in a `tibble` whereas `cran_package()` returns metadata about a single CRAN package.
      
      * `cran_package_history()` returns a `tibble` containing the history of a package metadata, with one row per package version.
      
    * Functions returning metadata about packages across CRAN
    
      * `cran_events()` lists all CRAN events (new, updated, archived packages)
    
      * `cran_top_downloaded()` and `cran_trending()` return a `tibble` of the 100 most downloaded and trending packages, respectively.

# pkgsearch 2.0.1

* Fix a bug when a search hit does not have a 'downloads' field.
  (Because it is a brand new package.)

# pkgsearch 2.0.0

First release on CRAN.
