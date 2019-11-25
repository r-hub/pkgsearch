
# pkgsearch 3.0.1

* The "My packages" and "Most depended upon" items now work properly
  in the RStudio addin (#77).

* The RStudio addin has a better window title when running in a
  browser (#79).

* The addin now does not crash RStudio when closing the window (#78).

# pkgsearch 3.0.0

* New RStudio addin to search for packages in a GUI:
  `pkg_search_addin()`.

* New `cran_package()`, `cran_packages()` and `cran_package_history()`
  functions to query metadata about certain packages.

* New `cran_events()` function to list recent CRAN events, new, updated
  or archived packages.
    
* New `cran_top_downloaded()` function to query packages with the most
  downloads.

* New `cran_trending()` function to return the trending CRAN packages.

* New function `advanced_search()` for more search flexibility.

# pkgsearch 2.0.1

* Fix a bug when a search hit does not have a 'downloads' field.
  (Because it is a brand new package.)

# pkgsearch 2.0.0

First release on CRAN.
