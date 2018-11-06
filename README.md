


# CRAN package search

[![Linux Build Status](https://travis-ci.org/metacran/pkgsearch.svg?branch=master)](https://travis-ci.org/metacran/pkgsearch)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/github/metacran/pkgsearch?svg=true)](https://ci.appveyor.com/project/gaborcsardi/pkgsearch)

The `pkgsearch` package searches all CRAN packages. It uses a web service,
and a careful weighting that ranks popular packages before less
frequently used ones.

## Installation

Install the package from github, using `devtools`:

```r
devtools::install_github("metacran/pkgsearch")
```

## Usage

The current API is very minimal, the most important is the `pkg_search()` function,
that does the search:


```r
library(pkgsearch)
pkg_search("C++")
```

```
#> - "C++" ------------------------------------------------ 6080 packages in 0.006 seconds -
#>   #     package       version     by                  @ title
#>   1 100 Rcpp          0.12.19     Dirk Eddelbuettel  1M Seamless R and C++ Integration
#>   2  35 covr          3.2.1       Jim Hester        19d Test Coverage for Packages
#>   3  31 BH            1.66.0.1    Dirk Eddelbuettel  9M Boost C++ Header Files
#>   4  24 xml2          1.2.0       James Hester      10M Parse XML
#>   5  20 boot          1.3.20      Brian Ripley       1y Bootstrap Functions (Originall...
#>   6  19 lme4          1.1.18.1    Ben Bolker         3M Linear Mixed-Effects Models us...
#>   7  17 roxygen2      6.1.0       Hadley Wickham     3M In-Line Documentation for R
#>   8  16 rJava         0.9.10      Simon Urbanek      5M Low-Level R to Java Interface
#>   9  16 rgeos         0.4.1       Roger Bivand      18d Interface to Geometry Engine -...
#>  10  15 RcppArmadillo 0.9.100.5.0 Dirk Eddelbuettel  3M 'Rcpp' Integration for the 'Ar...
```

By default it returns a short summary of the ten best search hits. Their
details can be printed by using the `format = "long"` option of `pkg_search()`,
or just calling `pkg_search()` again, without any arguments, after a search:



```r
pkg_search()
```

```
#> - "C++" ------------------------------------------------ 6080 packages in 0.006 seconds -
#>
#> 1 Rcpp @ 0.12.19                                     Dirk Eddelbuettel, about a month ago
#> ----------------
#>   # Seamless R and C++ Integration
#>   The 'Rcpp' package provides R functions as well as C++ classes which offer a seamless
#>   integration of R and C++. Many R data types and objects can be mapped back and forth
#>   to C++ equivalents which facilitates both writing of new code as well as easier
#>   integration of third-party libraries. Documentation about 'Rcpp' is provided by
#>   several vignettes included in this package, via the 'Rcpp Gallery' site at
#>   <http://gallery.rcpp.org>, the paper by Eddelbuettel and Francois (2011,
#>   <doi:10.18637/jss.v040.i08>), the book by Eddelbuettel (2013,
#>   <doi:10.1007/978-1-4614-6868-4>) and the paper by Eddelbuettel and Balamuta (2018,
#>   <doi:10.1080/00031305.2017.1375990>); see 'citation("Rcpp")' for details.
#>   http://www.rcpp.org
#>   http://dirk.eddelbuettel.com/code/rcpp.html
#>   https://github.com/RcppCore/Rcpp
#>
#> 2 covr @ 3.2.1                                                    Jim Hester, 19 days ago
#> --------------
#>   # Test Coverage for Packages
#>   Track and report code coverage for your package and (optionally) upload the results to
#>   a coverage service like 'Codecov' <http://codecov.io> or 'Coveralls'
#>   <http://coveralls.io>. Code coverage is a measure of the amount of code being
#>   exercised by a set of tests. It is an indirect measure of test quality and
#>   completeness. This package is compatible with any testing methodology or framework and
#>   tracks coverage of both R code and compiled C/C++/FORTRAN code.
#>   https://github.com/r-lib/covr
#>
#> 3 BH @ 1.66.0.1                                           Dirk Eddelbuettel, 9 months ago
#> ---------------
#>   # Boost C++ Header Files
#>   Boost provides free peer-reviewed portable C++ source libraries.  A large part of
#>   Boost is provided as C++ template code which is resolved entirely at compile-time
#>   without linking.  This package aims to provide the most useful subset of Boost
#>   libraries for template use among CRAN package. By placing these libraries in this
#>   package, we offer a more efficient distribution system for CRAN as replication of this
#>   code in the sources of other packages is avoided. As of release 1.65.0-1, the
#>   following Boost libraries are included: 'algorithm' 'align' 'any' 'atomic' 'bimap'
#>   'bind' 'circular_buffer' 'compute' 'concept' 'config' 'container' 'date'_'time'
#>   'detail' 'dynamic_bitset' 'exception' 'filesystem' 'flyweight' 'foreach' 'functional'
#>   'fusion' 'geometry' 'graph' 'heap' 'icl' 'integer' 'interprocess' 'intrusive' 'io'
#>   'iostreams' 'iterator' 'math' 'move' 'mpl' 'multiprcecision' 'numeric' 'pending'
#>   'phoenix' 'preprocessor' 'propery_tree' 'random' 'range' 'scope_exit' 'smart_ptr'
#>   'sort' 'spirit' 'tuple' 'type_traits' 'typeof' 'unordered' 'utility' 'uuid'.
#>
#> 4 xml2 @ 1.2.0                                                James Hester, 10 months ago
#> --------------
#>   # Parse XML
#>   Work with XML files using a simple, consistent interface. Built on top of the
#>   'libxml2' C library.
#>   https://github.com/r-lib/xml2
#>
#> 5 boot @ 1.3.20                                            Brian Ripley, about a year ago
#> ---------------
#>   # Bootstrap Functions (Originally by Angelo Canty for S)
#>   Functions and datasets for bootstrapping from the book "Bootstrap Methods and Their
#>   Application" by A. C. Davison and D. V. Hinkley (1997, CUP), originally written by
#>   Angelo Canty for S.
#>
#> 6 lme4 @ 1.1.18.1                                                Ben Bolker, 3 months ago
#> -----------------
#>   # Linear Mixed-Effects Models using 'Eigen' and S4
#>   Fit linear and generalized linear mixed-effects models. The models and their
#>   components are represented using S4 classes and methods.  The core computational
#>   algorithms are implemented using the 'Eigen' C++ library for numerical linear algebra
#>   and 'RcppEigen' "glue".
#>   https://github.com/lme4/lme4/
#>   http://lme4.r-forge.r-project.org/
#>
#> 7 roxygen2 @ 6.1.0                                           Hadley Wickham, 3 months ago
#> ------------------
#>   # In-Line Documentation for R
#>   Generate your Rd documentation, 'NAMESPACE' file, and collation field using specially
#>   formatted comments. Writing documentation in-line with code makes it easier to keep
#>   your documentation up-to-date as your requirements change. 'Roxygen2' is inspired by
#>   the 'Doxygen' system for C++.
#>   https://github.com/klutometis/roxygen
#>
#> 8 rJava @ 0.9.10                                              Simon Urbanek, 5 months ago
#> ----------------
#>   # Low-Level R to Java Interface
#>   Low-level interface to Java VM very much like .C/.Call and friends. Allows creation of
#>   objects, calling methods and accessing fields.
#>   http://www.rforge.net/rJava/
#>
#> 9 rgeos @ 0.4.1                                                 Roger Bivand, 18 days ago
#> ---------------
#>   # Interface to Geometry Engine - Open Source ('GEOS')
#>   Interface to Geometry Engine - Open Source ('GEOS') using the C 'API' for topology
#>   operations on geometries. The 'GEOS' library is external to the package, and, when
#>   installing the package from source, must be correctly installed first. Windows and Mac
#>   Intel OS X binaries are provided on 'CRAN'.
#>   https://r-forge.r-project.org/projects/rgeos/
#>   http://trac.osgeo.org/geos/
#>
#> 10 RcppArmadillo @ 0.9.100.5.0                            Dirk Eddelbuettel, 3 months ago
#> ------------------------------
#>   # 'Rcpp' Integration for the 'Armadillo' Templated Linear Algebra Library
#>   'Armadillo' is a templated C++ linear algebra library (by Conrad Sanderson) that aims
#>   towards a good balance between speed and ease of use. Integer, floating point and
#>   complex numbers are supported, as well as a subset of trigonometric and statistics
#>   functions. Various matrix decompositions are provided through optional integration
#>   with LAPACK and ATLAS libraries. The 'RcppArmadillo' package includes the header files
#>   from the templated 'Armadillo' library. Thus users do not need to install 'Armadillo'
#>   itself in order to use 'RcppArmadillo'. From release 7.800.0 on, 'Armadillo' is
#>   licensed under Apache License 2; previous releases were under licensed as MPL 2.0 from
#>   version 3.800.0 onwards and LGPL-3 prior to that; 'RcppArmadillo' (the 'Rcpp'
#>   bindings/bridge to Armadillo) is licensed under the GNU GPL version 2 or later, as is
#>   the rest of 'Rcpp'. Note that Armadillo requires a fairly recent compiler; for the g++
#>   family at least version 4.6.* is required.
#>   http://dirk.eddelbuettel.com/code/rcpp.armadillo.html
```

The `more()` function can be used to display the next batch of search hits,
batches contain ten packages by default:


```r
pkg_search("google")
```

```
#> - "google" ---------------------------------------------- 106 packages in 0.008 seconds -
#>   #     package      version by               @ title
#>   1 100 lubridate    1.7.4   Vitalie Spinu   7M Make Dealing with Dates a Little Easier
#>   2  61 ggmap        2.6.1   David Kahle     3y Spatial Visualization with ggplot2
#>   3  48 googleVis    0.6.2   Markus Gesmann  2y R Interface to Google Charts
#>   4  40 V8           1.5     Jeroen Ooms     2y Embedded JavaScript Engine for R
#>   5  32 googleAuthR  0.6.3   Mark Edmondson  5M Authenticate and Create Google APIs
#>   6  31 RgoogleMaps  1.4.2   Markus Loecher  5M Overlays on Static Maps
#>   7  30 sysfonts     0.8     Yixuan Qiu     26d Loading Fonts into R
#>   8  25 tensorflow   1.9     JJ Allaire      3M R Interface to 'TensorFlow'
#>   9  24 googlesheets 0.3.0   Jennifer Bryan  4M Manage Google Spreadsheets from R
#>  10  24 plotKML      0.5.8   Tomislav Hengl  1y Visualization of Spatial and Spatio-Te...
```


```r
more()
```

```
#> - "google" ---------------------------------------------- 106 packages in 0.005 seconds -
#>   #    package             version by                @ title
#>  11 22 gsheet              0.4.2   Max Conway       2y Download Google Sheets Using Ju...
#>  12 21 hrbrthemes          0.5.0.1 ORPHANED         3M Additional Themes, Theme Compon...
#>  13 20 googledrive         0.1.2   Jennifer Bryan   1M An Interface to Google Drive
#>  14 18 googleCloudStorageR 0.4.0   Mark Edmondson   1y Interface with Google Cloud Sto...
#>  15 17 bigQueryR           0.4.0   Mark Edmondson   5M Interface with Google BigQuery ...
#>  16 16 googlePolylines     0.7.1   David Cooley     2M Encoding Coordinates into 'Goog...
#>  17 16 googleAnalyticsR    0.5.0   Mark Edmondson   9M Google Analytics API into R
#>  18 15 DescTools           0.99.25 Andri Signorell  3M Tools for Descriptive Statistics
#>  19 15 cld2                1.2     Jeroen Ooms      6M Google's Compact Language Detec...
#>  20 14 searchConsoleR      0.3.0   Mark Edmondson  10M Google Search Console R Client
```


```r
more()
```

```
#> - "google" ---------------------------------------------- 106 packages in 0.005 seconds -
#>   #    package       version by                     @ title
#>  21 13 RProtoBuf     0.4.13  Dirk Eddelbuettel     3d R Interface to the 'Protocol Buf...
#>  22 13 googleformr   0.0.3   Steve Simpson         3y Collect Data Programmatically by...
#>  23 13 choroplethr   3.6.3   Ari Lamstein          3M Simplify the Creation of Choropl...
#>  24 13 rgoogleslides 0.3.1   Hairizuan Noorazman   2M R Interface to Google Slides
#>  25 13 gcite         0.9.2   John Muschelli        9M Google Citation Parser
#>  26 13 plusser       0.4.0   Christoph Waldhauser  5y A Google+ Interface for R
#>  27 13 ganalytics    0.10.4  Johann de Boer        4M Interact with 'Google Analytics'
#>  28 12 translate     0.1.2   Peter Danenberg       4y Bindings for the Google Translat...
#>  29 12 s2            0.4.0   Ege Rubak             7M Google's S2 Library for Geometry...
#>  30 12 googlePrintr  0.0.1   Carl Ganz             9M Connect to 'Google Cloud Print' API
```
