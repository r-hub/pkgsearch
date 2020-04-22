# Search and Query CRAN R Packages

<!-- badges: start -->
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Linux Build Status](https://travis-ci.org/r-hub/pkgsearch.svg?branch=master)](https://travis-ci.org/r-hub/pkgsearch)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/github/r-hub/pkgsearch?svg=true)](https://ci.appveyor.com/project/gaborcsardi/pkgsearch)
[![CRAN status](https://www.r-pkg.org/badges/version/pkgsearch)](https://cran.r-project.org/package=pkgsearch)
[![CRAN RStudio mirror downloads](https://cranlogs.r-pkg.org/badges/pkgsearch)](https://www.r-pkg.org/pkg/pkgsearch)
[![Coverage status](https://codecov.io/gh/r-hub/pkgsearch/branch/master/graph/badge.svg)](https://codecov.io/github/r-hub/pkgsearch?branch=master)
<!-- badges: end -->

`pkgsearch` uses R-hub web services that munge CRAN metadata and let you
access it through several lenses.

-   [Installation](#installation)
-   [Usage](#usage)
    -   [Search relevant packages](#search-relevant-packages)
    -   [Do it all *clicking*](#do-it-all-clicking)
    -   [Get package metadata](#get-package-metadata)
    -   [Discover packages](#discover-packages)
    -   [Keep up with CRAN](#keep-up-with-cran)
-   [Search features](#search-features)
    -   [More details](#more-details)
    -   [Pagination](#pagination)
    -   [Stemming](#stemming)
    -   [Ranking](#ranking)
    -   [Preferring Phrases](#preferring-phrases)
    -   [British vs American English](#british-vs-american-english)
    -   [Ascii Folding](#ascii-folding)
-   [More info](#more-info)
-   [License](#license)

<!-- README.md is generated from README.Rmd. Please edit that file -->

Installation
------------

Install the latest pkgsearch release from CRAN:

``` r
install.packages("pkgsearch")
```

Usage
-----

### Search relevant packages

Do you need to find packages solving a particular problem,
e.g. “permutation test”?

``` r
library("pkgsearch")
pkg_search("permutation test")
```

    #> - "permutation test" ----------------------------------- 1934 packages in 0.015 seconds -
    #>   #     package        version by                      @ title                           
    #>   1 100 coin           1.3.1   Torsten Hothorn        8M Conditional Inference Procedu...
    #>   2  34 exactRankTests 0.8.31  Torsten Hothorn        4M Exact Distributions for Rank ...
    #>   3  33 flip           2.5.0   Livio Finos            2y Multivariate Permutation Tests  
    #>   4  30 perm           1.0.0.0 Michael Fay           10y Exact or Asymptotic permutati...
    #>   5  25 jmuOutlier     2.2     Steven T. Garren       9M Permutation Tests for Nonpara...
    #>   6  21 wPerm          1.0.1   Neil A. Weiss          4y Permutation Tests               
    #>   7  18 cpt            1.0.2   Johann Gagnon-Bartsch  1y Classification Permutation Test 
    #>   8  18 permutes       1.0     Cesko C. Voeten        9M Permutation Tests for Time Se...
    #>   9  18 GlobalDeviance 0.4     Frederike Fuhlbrueck   7y Global Deviance Permutation T...
    #>  10  17 AUtests        0.98    Arjun Sondhi           4y Approximate Unconditional and...

pkgsearch uses an [R-hub](https://docs.r-hub.io) web service and a
careful ranking that puts popular packages before less frequently used
ones.

### Do it all *clicking*

For the search mentioned above, and other points of entry to CRAN
metadata, you can use pkgsearch RStudio add-in!

[![Addin
screencast](https://raw.githubusercontent.com/r-hub/pkgsearch/master/gifs/addin.gif)](https://vimeo.com/375618736)

Select the “CRAN package search” addin from the menu, or start it with
`pkg_search_addin()`.

### Get package metadata

Do you want to find the dependencies the first versions of `testthat`
had and when each of these versions was released?

``` r
cran_package_history("testthat")
```

    #> [90m# A tibble: 27 x 25[39m
    #>    Package Type  Title Version Author Maintainer Description URL   License LazyData
    #>  [90m*[39m [3m[90m<chr>[39m[23m   [3m[90m<chr>[39m[23m [3m[90m<chr>[39m[23m [3m[90m<chr>[39m[23m   [3m[90m<chr>[39m[23m  [3m[90m<chr>[39m[23m      [3m[90m<chr>[39m[23m       [3m[90m<chr>[39m[23m [3m[90m<chr>[39m[23m   [3m[90m<chr>[39m[23m   
    #> [90m 1[39m testth… Pack… Tool… 0.1     Hadle… Hadley Wi… Test_that … http… GPL     true    
    #> [90m 2[39m testth… Pack… Test… 0.1.1   Hadle… Hadley Wi… A testing … http… GPL     true    
    #> [90m 3[39m testth… Pack… Test… 0.2     Hadle… Hadley Wi… A testing … http… GPL     true    
    #> [90m 4[39m testth… Pack… Test… 0.3     Hadle… Hadley Wi… A testing … http… GPL     true    
    #> [90m 5[39m testth… Pack… Test… 0.4     Hadle… Hadley Wi… A testing … http… GPL     true    
    #> [90m 6[39m testth… Pack… Test… 0.5     Hadle… Hadley Wi… A testing … http… GPL     true    
    #> [90m 7[39m testth… Pack… Test… 0.6     Hadle… Hadley Wi… A testing … http… GPL     true    
    #> [90m 8[39m testth… Pack… Test… 0.7     Hadle… Hadley Wi… A testing … http… GPL     true    
    #> [90m 9[39m testth… Pack… Test… 0.7.1   Hadle… Hadley Wi… A testing … http… GPL     true    
    #> [90m10[39m testth… Pack… Test… 0.8     Hadle… Hadley Wi… A testing … http… MIT + … true    
    #> [90m# … with 17 more rows, and 15 more variables: Collate [3m[90m<chr>[90m[23m, Packaged [3m[90m<chr>[90m[23m,[39m
    #> [90m#   Repository [3m[90m<chr>[90m[23m, `Date/Publication` [3m[90m<chr>[90m[23m, crandb_file_date [3m[90m<chr>[90m[23m, date [3m[90m<chr>[90m[23m,[39m
    #> [90m#   dependencies [3m[90m<list>[90m[23m, NeedsCompilation [3m[90m<chr>[90m[23m, Roxygen [3m[90m<chr>[90m[23m, `Authors@R` [3m[90m<chr>[90m[23m,[39m
    #> [90m#   BugReports [3m[90m<chr>[90m[23m, RoxygenNote [3m[90m<chr>[90m[23m, VignetteBuilder [3m[90m<chr>[90m[23m, Encoding [3m[90m<chr>[90m[23m,[39m
    #> [90m#   MD5sum [3m[90m<chr>[90m[23m[39m

### Discover packages

Do you want to know what packages are trending on CRAN these days?
`pkgsearch` can help!

``` r
cran_trending()
```

    #> [90m# A tibble: 100 x 2[39m
    #>    package       score                
    #>    [3m[90m<chr>[39m[23m         [3m[90m<chr>[39m[23m                
    #> [90m 1[39m tidyBF        4020.0886262924667700
    #> [90m 2[39m correlation   2148.1910274963820500
    #> [90m 3[39m gt            1511.6375481196328100
    #> [90m 4[39m pkgdown       1314.2765288079546200
    #> [90m 5[39m sfheaders     1147.8341297980576500
    #> [90m 6[39m spatialwidget 1095.8937943809817800
    #> [90m 7[39m mapdeck       1025.2380635280016000
    #> [90m 8[39m colourvalues  875.4086088583905200 
    #> [90m 9[39m rematch2      850.0773258305539500 
    #> [90m10[39m geojsonsf     799.5651464912757500 
    #> [90m# … with 90 more rows[39m

``` r
cran_top_downloaded()
```

    #> [90m# A tibble: 100 x 2[39m
    #>    package         count  
    #>    [3m[90m<chr>[39m[23m           [3m[90m<chr>[39m[23m  
    #> [90m 1[39m magrittr        1321083
    #> [90m 2[39m aws.s3          1167069
    #> [90m 3[39m aws.ec2metadata 1162406
    #> [90m 4[39m rsconnect       1137336
    #> [90m 5[39m jsonlite        476877 
    #> [90m 6[39m ggplot2         406346 
    #> [90m 7[39m fs              380446 
    #> [90m 8[39m rlang           369550 
    #> [90m 9[39m devtools        364636 
    #> [90m10[39m usethis         350344 
    #> [90m# … with 90 more rows[39m

### Keep up with CRAN

Are you curious about the latest releases or archivals?

``` r
cran_events()
```

    #> CRAN events (events)---------------------------------------------------------------------
    #>  . When    Package           Version Title                                               
    #>  + 2 hours decoder           1.2.2   Decode Coded Variables to Plain Text and the Othe...
    #>  + 3 hours wyz.code.rdoc     1.1.16  Wizardry Code Offensive Programming R Documentati...
    #>  + 3 hours wyz.code.testthat 1.1.17  Wizardry Code Offensive Programming Test Generati...
    #>  + 4 hours CNVScope          3.0.5   A Versatile Toolkit for Copy Number Variation Rel...
    #>  + 4 hours PRISM.forecast    0.2.0   Penalized Regression with Inferred Seasonality Mo...
    #>  + 4 hours ParallelLogger    1.2.0   Support for Parallel Computation, Logging, and Fu...
    #>  + 4 hours bnma              1.1.1   Bayesian Network Meta-Analysis using 'JAGS'         
    #>  + 4 hours dsm               2.3.0   Density Surface Modelling of Distance Sampling Da...
    #>  + 4 hours pmml              2.3.1   Generate PMML for Various Models                    
    #>  + 4 hours quantspec         1.2-2   Quantile-Based Spectral Analysis of Time Series

Search features
---------------

### More details

By default it returns a short summary of the ten best search hits. Their
details can be printed by using the `format = "long"` option of
`pkg_search()`, or just calling `pkg_search()` again, without any
arguments, after a search:

``` r
library(pkgsearch)
pkg_search("C++")
```

    #> - "C++" ------------------------------------------------ 8765 packages in 0.008 seconds -
    #>   #     package      version  by                    @ title                              
    #>   1 100 Rcpp         1.0.4.6  Dirk Eddelbuettel   13d Seamless R and C++ Integration     
    #>   2  31 BH           1.72.0.3 Dirk Eddelbuettel    3M Boost C++ Header Files             
    #>   3  16 markdown     1.1      Yihui Xie            9M Render Markdown with the C Libra...
    #>   4  14 StanHeaders  2.19.2   Ben Goodrich         2M C++ Header Files for Stan          
    #>   5  11 inline       0.3.15   Dirk Eddelbuettel    2y Functions to Inline C, C++, Fort...
    #>   6  11 RcppProgress 0.4.2    Karl Forner          3M An Interruptible Progress Bar wi...
    #>   7  11 covr         3.5.0    Jim Hester           2M Test Coverage for Packages         
    #>   8  10 SnowballC    0.7.0    Milan Bouchet-Valat 21d Snowball Stemmers Based on the C...
    #>   9   6 glpkAPI      1.3.2    Mayo Roettger        2M R Interface to C API of GLPK       
    #>  10   6 xml2         1.3.1    Jim Hester          13d Parse XML

``` r
pkg_search()
```

    #> - "C++" ------------------------------------------------ 8765 packages in 0.008 seconds -
    #> 
    #> 1 Rcpp @ 1.0.4.6                                           Dirk Eddelbuettel, 13 days ago
    #> ----------------
    #>   # Seamless R and C++ Integration
    #>   The 'Rcpp' package provides R functions as well as C++ classes which offer a
    #>   seamless integration of R and C++. Many R data types and objects can be mapped
    #>   back and forth to C++ equivalents which facilitates both writing of new code
    #>   as well as easier integration of third-party libraries. Documentation about
    #>   'Rcpp' is provided by several vignettes included in this package, via the
    #>   'Rcpp Gallery' site at <http://gallery.rcpp.org>, the paper by Eddelbuettel
    #>   and Francois (2011, <doi:10.18637/jss.v040.i08>), the book by Eddelbuettel
    #>   (2013, <doi:10.1007/978-1-4614-6868-4>) and the paper by Eddelbuettel and
    #>   Balamuta (2018, <doi:10.1080/00031305.2017.1375990>); see 'citation("Rcpp")'
    #>   for details.
    #>   http://www.rcpp.org
    #>   http://dirk.eddelbuettel.com/code/rcpp.html
    #>   https://github.com/RcppCore/Rcpp
    #> 
    #> 2 BH @ 1.72.0.3                                           Dirk Eddelbuettel, 3 months ago
    #> ---------------
    #>   # Boost C++ Header Files
    #>   Boost provides free peer-reviewed portable C++ source libraries.  A large part
    #>   of Boost is provided as C++ template code which is resolved entirely at
    #>   compile-time without linking.  This package aims to provide the most useful
    #>   subset of Boost libraries for template use among CRAN packages. By placing
    #>   these libraries in this package, we offer a more efficient distribution system
    #>   for CRAN as replication of this code in the sources of other packages is
    #>   avoided. As of release 1.72.0-3, the following Boost libraries are included:
    #>   'accumulators' 'algorithm' 'align' 'any' 'atomic' 'bimap' 'bind'
    #>   'circular_buffer' 'compute' 'concept' 'config' 'container' 'date_time'
    #>   'detail' 'dynamic_bitset' 'exception' 'flyweight' 'foreach' 'functional'
    #>   'fusion' 'geometry' 'graph' 'heap' 'icl' 'integer' 'interprocess' 'intrusive'
    #>   'io' 'iostreams' 'iterator' 'math' 'move' 'mp11' 'mpl' 'multiprcecision'
    #>   'numeric' 'pending' 'phoenix' 'polygon' 'preprocessor' 'propery_tree' 'random'
    #>   'range' 'scope_exit' 'smart_ptr' 'sort' 'spirit' 'tuple' 'type_traits'
    #>   'typeof' 'unordered' 'utility' 'uuid'.
    #>   https://github.com/eddelbuettel/bh
    #> 
    #> 3 markdown @ 1.1                                                  Yihui Xie, 9 months ago
    #> ----------------
    #>   # Render Markdown with the C Library 'Sundown'
    #>   Provides R bindings to the 'Sundown' Markdown rendering library
    #>   (<https://github.com/vmg/sundown>). Markdown is a plain-text formatting syntax
    #>   that can be converted to 'XHTML' or other formats. See
    #>   <http://en.wikipedia.org/wiki/Markdown> for more information about Markdown.
    #>   https://github.com/rstudio/markdown
    #> 
    #> 4 StanHeaders @ 2.19.2                                         Ben Goodrich, 2 months ago
    #> ----------------------
    #>   # C++ Header Files for Stan
    #>   The C++ header files of the Stan project are provided by this package, but it
    #>   contains no R code or function documentation. There is a shared object
    #>   containing part of the 'CVODES' library, but it is not accessible from R.
    #>   'StanHeaders' is only useful for developers who want to utilize the
    #>   'LinkingTo' directive of their package's DESCRIPTION file to build on the Stan
    #>   library without incurring unnecessary dependencies. The Stan project develops
    #>   a probabilistic programming language that implements full or approximate
    #>   Bayesian statistical inference via Markov Chain Monte Carlo or 'variational'
    #>   methods and implements (optionally penalized) maximum likelihood estimation
    #>   via optimization. The Stan library includes an advanced automatic
    #>   differentiation scheme, 'templated' statistical and linear algebra functions
    #>   that can handle the automatically 'differentiable' scalar types (and doubles,
    #>   'ints', etc.), and a parser for the Stan language. The 'rstan' package
    #>   provides user-facing R functions to parse, compile, test, estimate, and
    #>   analyze Stan models.
    #>   http://mc-stan.org/
    #> 
    #> 5 inline @ 0.3.15                                          Dirk Eddelbuettel, 2 years ago
    #> -----------------
    #>   # Functions to Inline C, C++, Fortran Function Calls from R
    #>   Functionality to dynamically define R functions and S4 methods with 'inlined'
    #>   C, C++ or Fortran code supporting the .C and .Call calling conventions.
    #> 
    #> 6 RcppProgress @ 0.4.2                                          Karl Forner, 3 months ago
    #> ----------------------
    #>   # An Interruptible Progress Bar with OpenMP Support for C++ in R Packages
    #>   Allows to display a progress bar in the R console for long running
    #>   computations taking place in c++ code, and support for interrupting those
    #>   computations even in multithreaded code, typically using OpenMP.
    #>   https://github.com/kforner/rcpp_progress
    #> 
    #> 7 covr @ 3.5.0                                                   Jim Hester, 2 months ago
    #> --------------
    #>   # Test Coverage for Packages
    #>   Track and report code coverage for your package and (optionally) upload the
    #>   results to a coverage service like 'Codecov' <http://codecov.io> or
    #>   'Coveralls' <http://coveralls.io>. Code coverage is a measure of the amount of
    #>   code being exercised by a set of tests. It is an indirect measure of test
    #>   quality and completeness. This package is compatible with any testing
    #>   methodology or framework and tracks coverage of both R code and compiled
    #>   C/C++/FORTRAN code.
    #>   https://covr.r-lib.org
    #>   https://github.com/r-lib/covr
    #> 
    #> 8 SnowballC @ 0.7.0                                      Milan Bouchet-Valat, 21 days ago
    #> -------------------
    #>   # Snowball Stemmers Based on the C 'libstemmer' UTF-8 Library
    #>   An R interface to the C 'libstemmer' library that implements Porter's word
    #>   stemming algorithm for collapsing words to a common root to aid comparison of
    #>   vocabulary. Currently supported languages are Danish, Dutch, English, Finnish,
    #>   French, German, Hungarian, Italian, Norwegian, Portuguese, Romanian, Russian,
    #>   Spanish, Swedish and Turkish.
    #>   https://github.com/nalimilan/R.TeMiS
    #> 
    #> 9 glpkAPI @ 1.3.2                                             Mayo Roettger, 2 months ago
    #> -----------------
    #>   # R Interface to C API of GLPK
    #>   R Interface to C API of GLPK, depends on GLPK Version >= 4.42.
    #> 
    #> 10 xml2 @ 1.3.1                                                   Jim Hester, 13 days ago
    #> ---------------
    #>   # Parse XML
    #>   Work with XML files using a simple, consistent interface. Built on top of the
    #>   'libxml2' C library.
    #>   https://xml2.r-lib.org/
    #>   https://github.com/r-lib/xml2

### Pagination

The `more()` function can be used to display the next batch of search
hits, batches contain ten packages by default. `ps()` is a shorter alias
to `pkg_search()`:

``` r
ps("google")
```

    #> - "google" ---------------------------------------------- 133 packages in 0.007 seconds -
    #>   #     package             version by               @ title                             
    #>   1 100 googleVis           0.6.4   Markus Gesmann  1y R Interface to Google Charts      
    #>   2  79 googleAuthR         1.1.1   Mark Edmondson  8M Authenticate and Create Google ...
    #>   3  68 lubridate           1.7.8   Vitalie Spinu  16d Make Dealing with Dates a Littl...
    #>   4  63 gargle              0.4.0   Jennifer Bryan  7M Utilities for Working with Goog...
    #>   5  52 googledrive         1.0.0   Jennifer Bryan  8M An Interface to Google Drive      
    #>   6  49 googleCloudStorageR 0.5.1   Mark Edmondson  8M Interface with Google Cloud Sto...
    #>   7  47 googlePolylines     0.7.2   David Cooley    1y Encoding Coordinates into 'Goog...
    #>   8  44 plotKML             0.6.1   Tomislav Hengl  1M Visualization of Spatial and Sp...
    #>   9  43 gsheet              0.4.5   Max Conway     15d Download Google Sheets Using Ju...
    #>  10  40 googlesheets        0.3.0   Jennifer Bryan  2y Manage Google Spreadsheets from R

``` r
more()
```

    #> - "google" ---------------------------------------------- 133 packages in 0.007 seconds -
    #>   #    package          version by                     @ title                           
    #>  11 40 cld2             1.2     Jeroen Ooms           2y Google's Compact Language Det...
    #>  12 36 bigQueryR        0.5.0   Mark Edmondson        7M Interface with Google BigQuer...
    #>  13 34 ggmap            3.0.0   ORPHANED              1y Spatial Visualization with gg...
    #>  14 34 googleAnalyticsR 0.7.1   Mark Edmondson        6M Google Analytics API into R     
    #>  15 29 V8               3.0.2   Jeroen Ooms           1M Embedded JavaScript and WebAs...
    #>  16 27 gcite            0.10.1  John Muschelli        1y Google Citation Parser          
    #>  17 27 rgoogleslides    0.3.2   Hairizuan Noorazman   1M R Interface to Google Slides    
    #>  18 26 plusser          0.4.0   Christoph Waldhauser  6y A Google+ Interface for R       
    #>  19 26 ganalytics       0.10.7  Johann de Boer        1y Interact with 'Google Analytics'
    #>  20 26 s2               0.4.2   Ege Rubak             8M Google's S2 Library for Geome...

### Stemming

The search server uses the stems of the words in the indexed metadata,
and the search phrase. This means that “colour” and “colours” deliver
the exact same result. So do “coloring”, “colored”, etc. (Unless one is
happen to be an exact package name or match another non-stemmed field.)

``` r
ps("colour", size = 3)
```

    #> - "colour" ---------------------------------------------- 212 packages in 0.011 seconds -
    #>   #     package    version by              @ title                                       
    #>  1  100 crayon     1.3.4   Gábor Csárdi   3y Colored Terminal Output                     
    #>  2   70 colorspace 1.4.1   Achim Zeileis  1y A Toolbox for Manipulating and Assessing ...
    #>  3   64 viridis    0.5.1   Simon Garnier  2y Default Color Maps from 'matplotlib'

``` r
ps("colours", size = 3)
```

    #> - "colours" --------------------------------------------- 209 packages in 0.006 seconds -
    #>   #     package    version by              @ title                                       
    #>  1  100 crayon     1.3.4   Gábor Csárdi   3y Colored Terminal Output                     
    #>  2   70 colorspace 1.4.1   Achim Zeileis  1y A Toolbox for Manipulating and Assessing ...
    #>  3   64 viridis    0.5.1   Simon Garnier  2y Default Color Maps from 'matplotlib'

### Ranking

The most important feature of a search engine is the ranking of the
results. The best results should be listed first. pkgsearch uses
weighted scoring, where a match in the package title gets a higher score
than a match in the package description. It also uses the number of
reverse dependencies and the number of downloads to weight the scores:

``` r
ps("colour")[, c("score", "package", "revdeps", "downloads_last_month")]
```

    #> [90m# A tibble: 10 x 4[39m
    #>     score package      revdeps downloads_last_month
    #>     [3m[90m<dbl>[39m[23m [3m[90m<chr>[39m[23m          [3m[90m<int>[39m[23m                [3m[90m<int>[39m[23m
    #> [90m 1[39m [4m1[24m[4m3[24m825. crayon           222               [4m5[24m[4m0[24m[4m1[24m167
    #> [90m 2[39m  [4m9[24m713. colorspace       148               [4m5[24m[4m0[24m[4m4[24m134
    #> [90m 3[39m  [4m8[24m822. viridis          114               [4m2[24m[4m4[24m[4m1[24m947
    #> [90m 4[39m  [4m6[24m091. pillar            39               [4m8[24m[4m1[24m[4m4[24m477
    #> [90m 5[39m  [4m5[24m898. colourpicker      33                [4m2[24m[4m3[24m136
    #> [90m 6[39m  [4m4[24m849. viridisLite       47               [4m3[24m[4m6[24m[4m5[24m793
    #> [90m 7[39m  [4m4[24m575. shape             32                [4m5[24m[4m5[24m812
    #> [90m 8[39m  [4m3[24m864. RColorBrewer     454               [4m4[24m[4m0[24m[4m4[24m710
    #> [90m 9[39m  [4m3[24m765. colorRamps        16                 [4m5[24m981
    #> [90m10[39m  [4m3[24m235. dichromat         11                [4m2[24m[4m3[24m599

### Preferring Phrases

The search engine prefers matching whole phrases over single words. E.g.
the search phrase “permutation test” will rank coin higher than
testthat, even though testthat is a much better result for the single
word “test”. (In fact, at the time of writing testthat is not even on
the first page of results.)

``` r
ps("permutation test")
```

    #> - "permutation test" ----------------------------------- 1934 packages in 0.014 seconds -
    #>   #     package        version by                      @ title                           
    #>   1 100 coin           1.3.1   Torsten Hothorn        8M Conditional Inference Procedu...
    #>   2  34 exactRankTests 0.8.31  Torsten Hothorn        4M Exact Distributions for Rank ...
    #>   3  33 flip           2.5.0   Livio Finos            2y Multivariate Permutation Tests  
    #>   4  30 perm           1.0.0.0 Michael Fay           10y Exact or Asymptotic permutati...
    #>   5  25 jmuOutlier     2.2     Steven T. Garren       9M Permutation Tests for Nonpara...
    #>   6  21 wPerm          1.0.1   Neil A. Weiss          4y Permutation Tests               
    #>   7  18 cpt            1.0.2   Johann Gagnon-Bartsch  1y Classification Permutation Test 
    #>   8  18 permutes       1.0     Cesko C. Voeten        9M Permutation Tests for Time Se...
    #>   9  18 GlobalDeviance 0.4     Frederike Fuhlbrueck   7y Global Deviance Permutation T...
    #>  10  17 AUtests        0.98    Arjun Sondhi           4y Approximate Unconditional and...

If the whole phrase does not match, pkgsearch falls back to individual
matching words. For example, a match from either words is enough here,
to get on the first page of results:

``` r
ps("test http")
```

    #> - "test http" ------------------------------------------ 6169 packages in 0.019 seconds -
    #>   #     package   version   by                  @ title                                  
    #>   1 100 httptest  3.3.0     Neal Richardson    3M A Test Environment for HTTP Requests   
    #>   2  77 covr      3.5.0     Jim Hester         2M Test Coverage for Packages             
    #>   3  30 testthat  2.3.2     Hadley Wickham     2M Unit Testing for R                     
    #>   4  15 psych     1.9.12.31 William Revelle    3M Procedures for Psychological, Psycho...
    #>   5  13 vcr       0.5.4     Scott Chamberlain 22d Record 'HTTP' Calls to Disk            
    #>   6   9 httr      1.4.1     Hadley Wickham     9M Tools for Working with URLs and HTTP   
    #>   7   8 webmockr  0.6.2     Scott Chamberlain 29d Stubbing and Setting Expectations on...
    #>   8   7 bnlearn   4.5       Marco Scutari      9M Bayesian Network Structure Learning,...
    #>   9   5 knitr     1.28      Yihui Xie          3M A General-Purpose Package for Dynami...
    #>  10   5 oompaBase 3.2.9     Kevin R. Coombes   8M Class Unions, Matrix Operations, and...

### British vs American English

The search engine uses a dictionary to make sure that package metadata
and queries given in British and American English yield the same
results. E.g. note the spelling of colour/color in the results:

``` r
ps("colour")
```

    #> - "colour" ---------------------------------------------- 212 packages in 0.007 seconds -
    #>   #     package      version by                 @ title                                  
    #>   1 100 crayon       1.3.4   Gábor Csárdi      3y Colored Terminal Output                
    #>   2  70 colorspace   1.4.1   Achim Zeileis     1y A Toolbox for Manipulating and Asses...
    #>   3  64 viridis      0.5.1   Simon Garnier     2y Default Color Maps from 'matplotlib'   
    #>   4  44 pillar       1.4.3   Kirill Müller     4M Coloured Formatting for Columns        
    #>   5  43 colourpicker 1.0     Dean Attali       3y A Colour Picker Tool for Shiny and f...
    #>   6  35 viridisLite  0.3.0   Simon Garnier     2y Default Color Maps from 'matplotlib'...
    #>   7  33 shape        1.4.4   Karline Soetaert  2y Functions for Plotting Graphical Sha...
    #>   8  28 RColorBrewer 1.1.2   Erich Neuwirth    5y ColorBrewer Palettes                   
    #>   9  27 colorRamps   2.3     Tim Keitt         7y Builds color tables                    
    #>  10  23 dichromat    2.0.0   Thomas Lumley     7y Color Schemes for Dichromats

``` r
ps("color")
```

    #> - "color" ----------------------------------------------- 209 packages in 0.008 seconds -
    #>   #     package      version by                 @ title                                  
    #>   1 100 crayon       1.3.4   Gábor Csárdi      3y Colored Terminal Output                
    #>   2  70 colorspace   1.4.1   Achim Zeileis     1y A Toolbox for Manipulating and Asses...
    #>   3  64 viridis      0.5.1   Simon Garnier     2y Default Color Maps from 'matplotlib'   
    #>   4  44 pillar       1.4.3   Kirill Müller     4M Coloured Formatting for Columns        
    #>   5  43 colourpicker 1.0     Dean Attali       3y A Colour Picker Tool for Shiny and f...
    #>   6  35 viridisLite  0.3.0   Simon Garnier     2y Default Color Maps from 'matplotlib'...
    #>   7  33 shape        1.4.4   Karline Soetaert  2y Functions for Plotting Graphical Sha...
    #>   8  28 RColorBrewer 1.1.2   Erich Neuwirth    5y ColorBrewer Palettes                   
    #>   9  27 colorRamps   2.3     Tim Keitt         7y Builds color tables                    
    #>  10  23 dichromat    2.0.0   Thomas Lumley     7y Color Schemes for Dichromats

### Ascii Folding

Especially when searching for package maintainer names, it is convenient
to use the corresponding ASCII letters for non-ASCII characters in
search phrases. E.g. the following two queries yield the same results.
Note that case is also ignored.

``` r
ps("gabor", size = 5)
```

    #> - "gabor" ------------------------------------------------ 89 packages in 0.011 seconds -
    #>   #     package  version by              @ title                                         
    #>  1  100 igraph   1.2.5   Gábor Csárdi   1M Network Analysis and Visualization            
    #>  2   62 crayon   1.3.4   Gábor Csárdi   3y Colored Terminal Output                       
    #>  3   42 cli      2.0.2   Gábor Csárdi   2M Helpers for Developing Command Line Interfaces
    #>  4   41 progress 1.2.2   Gábor Csárdi   1y Terminal Progress Bars                        
    #>  5   39 zoo      1.8.7   Achim Zeileis  3M S3 Infrastructure for Regular and Irregular...

``` r
ps("Gábor", size = 5)
```

    #> - "Gábor" ------------------------------------------------ 89 packages in 0.008 seconds -
    #>   #     package  version by              @ title                                         
    #>  1  100 igraph   1.2.5   Gábor Csárdi   1M Network Analysis and Visualization            
    #>  2   62 crayon   1.3.4   Gábor Csárdi   3y Colored Terminal Output                       
    #>  3   42 cli      2.0.2   Gábor Csárdi   2M Helpers for Developing Command Line Interfaces
    #>  4   41 progress 1.2.2   Gábor Csárdi   1y Terminal Progress Bars                        
    #>  5   39 zoo      1.8.7   Achim Zeileis  3M S3 Infrastructure for Regular and Irregular...

More info
---------

See the [complete documentation](https://r-hub.github.io/pkgsearch/).

License
-------

MIT @ [Gábor Csárdi](https://github.com/gaborcsardi),
[RStudio](https://github.com/rstudio), [R
Consortium](https://www.r-consortium.org/).
