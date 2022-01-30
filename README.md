# Search and Query CRAN R Packages

<!-- badges: start -->
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![R build status](https://github.com/r-hub/pkgsearch/workflows/R-CMD-check/badge.svg)](https://github.com/r-hub/pkgsearch/actions)
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

## Installation

Install the latest pkgsearch release from CRAN:

``` r
install.packages("pkgsearch")
```

## Usage

### Search relevant packages

Do you need to find packages solving a particular problem, e.g.
“permutation test”?

``` r
library("pkgsearch")
library("pillar") # nicer data frame printing
pkg_search("permutation test")
```

    #> - "permutation test" ------------------------------------ 2229 packages in 0.01 seconds -
    #>   #     package        version by                      @ title                           
    #>   1 100 coin           1.4.2   Torsten Hothorn        4M Conditional Inference Procedu...
    #>   2  31 perm           1.0.0.2 Michael P. Fay         4M Exact or Asymptotic Permutati...
    #>   3  30 exactRankTests 0.8.34  Torsten Hothorn        4M Exact Distributions for Rank ...
    #>   4  29 flip           2.5.0   Livio Finos            3y Multivariate Permutation Tests  
    #>   5  22 jmuOutlier     2.2     Steven T. Garren       2y Permutation Tests for Nonpara...
    #>   6  19 wPerm          1.0.1   Neil A. Weiss          6y Permutation Tests               
    #>   7  16 cpt            1.0.2   Johann Gagnon-Bartsch  3y Classification Permutation Test 
    #>   8  16 GlobalDeviance 0.4     Frederike Fuhlbrueck   8y Global Deviance Permutation T...
    #>   9  16 AUtests        0.99    Arjun Sondhi           1y Approximate Unconditional and...
    #>  10  16 permutes       2.3.2   Cesko C. Voeten        2M Permutation Tests for Time Se...

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

    #> # A data frame: 35 × 29
    #>    Package  Type    Title  Version Author  Maintainer  Description  URL   License LazyData
    #>  * <chr>    <chr>   <chr>  <chr>   <chr>   <chr>       <chr>        <chr> <chr>   <chr>   
    #>  1 testthat Package Tools… 0.1     Hadley… Hadley Wic… Test_that c… http… GPL     true    
    #>  2 testthat Package Testt… 0.1.1   Hadley… Hadley Wic… A testing p… http… GPL     true    
    #>  3 testthat Package Testt… 0.2     Hadley… Hadley Wic… A testing p… http… GPL     true    
    #>  4 testthat Package Testt… 0.3     Hadley… Hadley Wic… A testing p… http… GPL     true    
    #>  5 testthat Package Testt… 0.4     Hadley… Hadley Wic… A testing p… http… GPL     true    
    #>  6 testthat Package Testt… 0.5     Hadley… Hadley Wic… A testing p… http… GPL     true    
    #>  7 testthat Package Testt… 0.6     Hadley… Hadley Wic… A testing p… http… GPL     true    
    #>  8 testthat Package Testt… 0.7     Hadley… Hadley Wic… A testing p… http… GPL     true    
    #>  9 testthat Package Testt… 0.7.1   Hadley… Hadley Wic… A testing p… http… GPL     true    
    #> 10 testthat Package Testt… 0.8     Hadley… Hadley Wic… A testing p… http… MIT + … true    
    #> # … with 25 more rows, and 19 more variables: Collate <chr>, Packaged <chr>,
    #> #   Repository <chr>, Date/Publication <chr>, crandb_file_date <chr>, date <chr>,
    #> #   dependencies <list>, NeedsCompilation <chr>, Roxygen <chr>, Authors@R <chr>,
    #> #   BugReports <chr>, RoxygenNote <chr>, VignetteBuilder <chr>, Encoding <chr>,
    #> #   MD5sum <chr>, Config/testthat/edition <chr>, Config/testthat/parallel <chr>,
    #> #   Config/testthat/start-first <chr>, Config/Needs/website <chr>

### Discover packages

Do you want to know what packages are trending on CRAN these days?
`pkgsearch` can help!

``` r
cran_trending()
```

    #> # A data frame: 100 × 2
    #>    package              score                 
    #>    <chr>                <chr>                 
    #>  1 SensusR              16654.8262548262548300
    #>  2 RcppTOML             1309.7784342688330900 
    #>  3 rgeoda               532.0293398533007300  
    #>  4 tvm                  434.1362258733450300  
    #>  5 admisc               429.4332034686439600  
    #>  6 reproj               423.8073602907769200  
    #>  7 tsfeatures           418.6191305636882500  
    #>  8 maditr               411.6492038610675700  
    #>  9 GameTheoryAllocation 406.8326012689116600  
    #> 10 crsmeta              389.7779639715123600  
    #> # … with 90 more rows

``` r
cran_top_downloaded()
```

    #> # A data frame: 100 × 2
    #>    package   count 
    #>    <chr>     <chr> 
    #>  1 ggplot2   520098
    #>  2 rlang     484204
    #>  3 glue      388030
    #>  4 pillar    383501
    #>  5 cli       374950
    #>  6 lifecycle 354413
    #>  7 dplyr     347728
    #>  8 vctrs     340291
    #>  9 ellipsis  326946
    #> 10 magrittr  320002
    #> # … with 90 more rows

### Keep up with CRAN

Are you curious about the latest releases or archivals?

``` r
cran_events()
```

    #> CRAN events (events)---------------------------------------------------------------------
    #>  . When     Package         Version  Title                                               
    #>  + 8 hours  mrgsim.parallel 0.2.0    Simulate with 'mrgsolve' in Parallel                
    #>  + 9 hours  report          0.5.0    Automated Reporting of Results and Statistical Mo...
    #>  + 11 hours ivsacim         2.1.0    Structural Additive Cumulative Intensity Models w...
    #>  + 16 hours bootcluster     0.3.2    Bootstrapping Estimates of Clustering Stability     
    #>  + 18 hours gtsummary       1.5.2    Presentation-Ready Data Summary and Analytic Resu...
    #>  + 18 hours vegawidget      0.4.1    'Htmlwidget' for 'Vega' and 'Vega-Lite'             
    #>  + 1 day    HDMT            1.0.5    A Multiple Testing Procedure for High-Dimensional...
    #>  + 1 day    RavenR          2.1.6    Raven Hydrological Modelling Framework R Support ...
    #>  + 1 day    braQCA          1.2.1.29 Bootstrapped Robustness Assessment for Qualitativ...
    #>  + 1 day    comat           0.9.3    Creates Co-Occurrence Matrices of Spatial Data

## Search features

### More details

By default it returns a short summary of the ten best search hits. Their
details can be printed by using the `format = "long"` option of
`pkg_search()`, or just calling `pkg_search()` again, without any
arguments, after a search:

``` r
library(pkgsearch)
pkg_search("C++")
```

    #> - "C++" ----------------------------------------------- 11735 packages in 0.006 seconds -
    #>   #     package      version  by                    @ title                              
    #>   1 100 Rcpp         1.0.8    Dirk Eddelbuettel   17d Seamless R and C++ Integration     
    #>   2  36 markdown     1.1      Yihui Xie            2y Render Markdown with the C Libra...
    #>   3  32 BH           1.78.0.0 Dirk Eddelbuettel    2M Boost C++ Header Files             
    #>   4  18 StanHeaders  2.21.0.7 Ben Goodrich         1y C++ Header Files for Stan          
    #>   5  13 RcppProgress 0.4.2    Karl Forner          2y An Interruptible Progress Bar wi...
    #>   6  12 cpp11        0.4.2    Romain François      2M A C++11 Interface for R's C Inte...
    #>   7  12 covr         3.5.1    Jim Hester           1y Test Coverage for Packages         
    #>   8  10 inline       0.3.19   Dirk Eddelbuettel    8M Functions to Inline C, C++, Fort...
    #>   9   9 SnowballC    0.7.0    Milan Bouchet-Valat  2y Snowball Stemmers Based on the C...
    #>  10   8 RcppThread   2.0.1    Thomas Nagler        3d R-Friendly Threading in C++

``` r
pkg_search()
```

    #> - "C++" ----------------------------------------------- 11735 packages in 0.006 seconds -
    #> 
    #> 1 Rcpp @ 1.0.8                                             Dirk Eddelbuettel, 17 days ago
    #> --------------
    #>   # Seamless R and C++ Integration
    #>   The 'Rcpp' package provides R functions as well as C++ classes which offer a
    #>   seamless integration of R and C++. Many R data types and objects can be mapped
    #>   back and forth to C++ equivalents which facilitates both writing of new code
    #>   as well as easier integration of third-party libraries. Documentation about
    #>   'Rcpp' is provided by several vignettes included in this package, via the
    #>   'Rcpp Gallery' site at <https://gallery.rcpp.org>, the paper by Eddelbuettel
    #>   and Francois (2011, <doi:10.18637/jss.v040.i08>), the book by Eddelbuettel
    #>   (2013, <doi:10.1007/978-1-4614-6868-4>) and the paper by Eddelbuettel and
    #>   Balamuta (2018, <doi:10.1080/00031305.2017.1375990>); see 'citation("Rcpp")'
    #>   for details.
    #>   http://www.rcpp.org
    #>   https://dirk.eddelbuettel.com/code/rcpp.html
    #>   https://github.com/RcppCore/Rcpp
    #> 
    #> 2 markdown @ 1.1                                                   Yihui Xie, 2 years ago
    #> ----------------
    #>   # Render Markdown with the C Library 'Sundown'
    #>   Provides R bindings to the 'Sundown' Markdown rendering library
    #>   (<https://github.com/vmg/sundown>). Markdown is a plain-text formatting syntax
    #>   that can be converted to 'XHTML' or other formats. See
    #>   <http://en.wikipedia.org/wiki/Markdown> for more information about Markdown.
    #>   https://github.com/rstudio/markdown
    #> 
    #> 3 BH @ 1.78.0.0                                           Dirk Eddelbuettel, 2 months ago
    #> ---------------
    #>   # Boost C++ Header Files
    #>   Boost provides free peer-reviewed portable C++ source libraries.  A large part
    #>   of Boost is provided as C++ template code which is resolved entirely at
    #>   compile-time without linking.  This package aims to provide the most useful
    #>   subset of Boost libraries for template use among CRAN packages. By placing
    #>   these libraries in this package, we offer a more efficient distribution system
    #>   for CRAN as replication of this code in the sources of other packages is
    #>   avoided. As of release 1.78.0-0, the following Boost libraries are included:
    #>   'accumulators' 'algorithm' 'align' 'any' 'atomic' 'beast' 'bimap' 'bind'
    #>   'circular_buffer' 'compute' 'concept' 'config' 'container' 'date_time'
    #>   'detail' 'dynamic_bitset' 'exception' 'flyweight' 'foreach' 'functional'
    #>   'fusion' 'geometry' 'graph' 'heap' 'icl' 'integer' 'interprocess' 'intrusive'
    #>   'io' 'iostreams' 'iterator' 'lambda2' 'math' 'move' 'mp11' 'mpl'
    #>   'multiprecision' 'numeric' 'pending' 'phoenix' 'polygon' 'preprocessor'
    #>   'process' 'propery_tree' 'random' 'range' 'scope_exit' 'smart_ptr' 'sort'
    #>   'spirit' 'tuple' 'type_traits' 'typeof' 'unordered' 'utility' 'uuid'.
    #>   https://github.com/eddelbuettel/bh
    #>   https://dirk.eddelbuettel.com/code/bh.html
    #> 
    #> 4 StanHeaders @ 2.21.0.7                                   Ben Goodrich, about a year ago
    #> ------------------------
    #>   # C++ Header Files for Stan
    #>   The C++ header files of the Stan project are provided by this package, but it
    #>   contains little R code or documentation. The main reference is the vignette.
    #>   There is a shared object containing part of the 'CVODES' library, but its
    #>   functionality is not accessible from R. 'StanHeaders' is primarily useful for
    #>   developers who want to utilize the 'LinkingTo' directive of their package's
    #>   DESCRIPTION file to build on the Stan library without incurring unnecessary
    #>   dependencies. The Stan project develops a probabilistic programming language
    #>   that implements full or approximate Bayesian statistical inference via Markov
    #>   Chain Monte Carlo or 'variational' methods and implements (optionally
    #>   penalized) maximum likelihood estimation via optimization. The Stan library
    #>   includes an advanced automatic differentiation scheme, 'templated' statistical
    #>   and linear algebra functions that can handle the automatically
    #>   'differentiable' scalar types (and doubles, 'ints', etc.), and a parser for
    #>   the Stan language. The 'rstan' package provides user-facing R functions to
    #>   parse, compile, test, estimate, and analyze Stan models.
    #>   https://mc-stan.org/
    #> 
    #> 5 RcppProgress @ 0.4.2                                           Karl Forner, 2 years ago
    #> ----------------------
    #>   # An Interruptible Progress Bar with OpenMP Support for C++ in R Packages
    #>   Allows to display a progress bar in the R console for long running
    #>   computations taking place in c++ code, and support for interrupting those
    #>   computations even in multithreaded code, typically using OpenMP.
    #>   https://github.com/kforner/rcpp_progress
    #> 
    #> 6 cpp11 @ 0.4.2                                             Romain François, 2 months ago
    #> ---------------
    #>   # A C++11 Interface for R's C Interface
    #>   Provides a header only, C++11 interface to R's C interface.  Compared to other
    #>   approaches 'cpp11' strives to be safe against long jumps from the C API as
    #>   well as C++ exceptions, conform to normal R function semantics and supports
    #>   interaction with 'ALTREP' vectors.
    #>   https://cpp11.r-lib.org
    #>   https://github.com/r-lib/cpp11
    #> 
    #> 7 covr @ 3.5.1                                               Jim Hester, about a year ago
    #> --------------
    #>   # Test Coverage for Packages
    #>   Track and report code coverage for your package and (optionally) upload the
    #>   results to a coverage service like 'Codecov' <https://codecov.io> or
    #>   'Coveralls' <https://coveralls.io>. Code coverage is a measure of the amount
    #>   of code being exercised by a set of tests. It is an indirect measure of test
    #>   quality and completeness. This package is compatible with any testing
    #>   methodology or framework and tracks coverage of both R code and compiled
    #>   C/C++/FORTRAN code.
    #>   https://covr.r-lib.org
    #>   https://github.com/r-lib/covr
    #> 
    #> 8 inline @ 0.3.19                                         Dirk Eddelbuettel, 8 months ago
    #> -----------------
    #>   # Functions to Inline C, C++, Fortran Function Calls from R
    #>   Functionality to dynamically define R functions and S4 methods with 'inlined'
    #>   C, C++ or Fortran code supporting the .C and .Call calling conventions.
    #>   https://github.com/eddelbuettel/inline
    #>   https://dirk.eddelbuettel.com/code/inline.html
    #> 
    #> 9 SnowballC @ 0.7.0                                      Milan Bouchet-Valat, 2 years ago
    #> -------------------
    #>   # Snowball Stemmers Based on the C 'libstemmer' UTF-8 Library
    #>   An R interface to the C 'libstemmer' library that implements Porter's word
    #>   stemming algorithm for collapsing words to a common root to aid comparison of
    #>   vocabulary. Currently supported languages are Danish, Dutch, English, Finnish,
    #>   French, German, Hungarian, Italian, Norwegian, Portuguese, Romanian, Russian,
    #>   Spanish, Swedish and Turkish.
    #>   https://github.com/nalimilan/R.TeMiS
    #> 
    #> 10 RcppThread @ 2.0.1                                           Thomas Nagler, 3 days ago
    #> ---------------------
    #>   # R-Friendly Threading in C++
    #>   Provides a C++11-style thread class and thread pool that can safely be
    #>   interrupted from R. See Nagler (2021) <doi:10.18637/jss.v097.c01>.
    #>   https://github.com/tnagler/RcppThread

### Pagination

The `more()` function can be used to display the next batch of search
hits, batches contain ten packages by default. `ps()` is a shorter alias
to `pkg_search()`:

``` r
ps("google")
```

    #> - "google" ---------------------------------------------- 155 packages in 0.005 seconds -
    #>   #     package             version by               @ title                             
    #>   1 100 googledrive         2.0.0   Jennifer Bryan  7M An Interface to Google Drive      
    #>   2  97 googleVis           0.6.11  Markus Gesmann 20d R Interface to Google Charts      
    #>   3  97 googleAuthR         2.0.0   Mark Edmondson  2d Authenticate and Create Google ...
    #>   4  90 lubridate           1.8.0   Vitalie Spinu   4M Make Dealing with Dates a Littl...
    #>   5  85 gargle              1.2.0   Jennifer Bryan  7M Utilities for Working with Goog...
    #>   6  61 googleCloudStorageR 0.7.0   Mark Edmondson  2M Interface with Google Cloud Sto...
    #>   7  59 gsheet              0.4.5   Max Conway      2y Download Google Sheets Using Ju...
    #>   8  56 googlesheets4       1.0.0   Jennifer Bryan  6M Access Google Sheets using the ...
    #>   9  52 googlePolylines     0.8.2   David Cooley    1y Encoding Coordinates into 'Goog...
    #>  10  50 cld2                1.2.1   Jeroen Ooms     1y Google's Compact Language Detec...

``` r
more()
```

    #> - "google" ---------------------------------------------- 155 packages in 0.005 seconds -
    #>   #    package          version by                  @ title                              
    #>  11 47 bigrquery        1.4.0   Hadley Wickham     6M An Interface to Google's 'BigQue...
    #>  12 41 googleAnalyticsR 1.0.1   Mark Edmondson     4M Google Analytics API into R        
    #>  13 39 cld3             1.4.2   Jeroen Ooms        6M Google's Compact Language Detect...
    #>  14 39 googlesheets     0.3.0   Jennifer Bryan     4y Manage Google Spreadsheets from R  
    #>  15 38 plotKML          0.8.2   Tomislav Hengl     3M Visualization of Spatial and Spa...
    #>  16 35 bigQueryR        0.5.0   Mark Edmondson     2y Interface with Google BigQuery w...
    #>  17 33 ggmap            3.0.0   ORPHANED           3y Spatial Visualization with ggplot2 
    #>  18 33 V8               4.0.0   Jeroen Ooms        1M Embedded JavaScript and WebAssem...
    #>  19 31 googleway        2.7.6   David Cooley       6d Accesses Google Maps APIs to Ret...
    #>  20 29 tensorflow       2.7.0   Tomasz Kalinowski  3M R Interface to 'TensorFlow'

### Stemming

The search server uses the stems of the words in the indexed metadata,
and the search phrase. This means that “colour” and “colours” deliver
the exact same result. So do “coloring”, “colored”, etc. (Unless one is
happen to be an exact package name or match another non-stemmed field.)

``` r
ps("colour", size = 3)
```

    #> - "colour" ---------------------------------------------- 269 packages in 0.006 seconds -
    #>   #     package    version by              @ title                                       
    #>  1  100 crayon     1.4.2   Gábor Csárdi   3M Colored Terminal Output                     
    #>  2   60 colorspace 2.0.2   Achim Zeileis  7M A Toolbox for Manipulating and Assessing ...
    #>  3   57 viridis    0.6.2   Simon Garnier  4M Colorblind-Friendly Color Maps for R

``` r
ps("colours", size = 3)
```

    #> - "colours" --------------------------------------------- 267 packages in 0.004 seconds -
    #>   #     package    version by              @ title                                       
    #>  1  100 crayon     1.4.2   Gábor Csárdi   3M Colored Terminal Output                     
    #>  2   60 colorspace 2.0.2   Achim Zeileis  7M A Toolbox for Manipulating and Assessing ...
    #>  3   57 viridis    0.6.2   Simon Garnier  4M Colorblind-Friendly Color Maps for R

### Ranking

The most important feature of a search engine is the ranking of the
results. The best results should be listed first. pkgsearch uses
weighted scoring, where a match in the package title gets a higher score
than a match in the package description. It also uses the number of
reverse dependencies and the number of downloads to weight the scores:

``` r
ps("colour")[, c("score", "package", "revdeps", "downloads_last_month")]
```

    #> # A data frame: 10 × 4
    #>     score package      revdeps downloads_last_month
    #>     <dbl> <chr>          <int>                <int>
    #>  1 17553. crayon           339               947171
    #>  2 10570. colorspace       177               564716
    #>  3  9967. viridis          162               344712
    #>  4  7337. pillar            63              1354547
    #>  5  6804. viridisLite       79               646038
    #>  6  6385. colourpicker      43                28126
    #>  7  4763. shape             34                60102
    #>  8  4382. RColorBrewer     571               560462
    #>  9  4089. colorRamps        19                 4723
    #> 10  3494. ggnewscale        18                 5600

### Preferring Phrases

The search engine prefers matching whole phrases over single words. E.g.
the search phrase “permutation test” will rank coin higher than
testthat, even though testthat is a much better result for the single
word “test”. (In fact, at the time of writing testthat is not even on
the first page of results.)

``` r
ps("permutation test")
```

    #> - "permutation test" ----------------------------------- 2229 packages in 0.009 seconds -
    #>   #     package        version by                      @ title                           
    #>   1 100 coin           1.4.2   Torsten Hothorn        4M Conditional Inference Procedu...
    #>   2  31 perm           1.0.0.2 Michael P. Fay         4M Exact or Asymptotic Permutati...
    #>   3  30 exactRankTests 0.8.34  Torsten Hothorn        4M Exact Distributions for Rank ...
    #>   4  29 flip           2.5.0   Livio Finos            3y Multivariate Permutation Tests  
    #>   5  22 jmuOutlier     2.2     Steven T. Garren       2y Permutation Tests for Nonpara...
    #>   6  19 wPerm          1.0.1   Neil A. Weiss          6y Permutation Tests               
    #>   7  16 cpt            1.0.2   Johann Gagnon-Bartsch  3y Classification Permutation Test 
    #>   8  16 GlobalDeviance 0.4     Frederike Fuhlbrueck   8y Global Deviance Permutation T...
    #>   9  16 AUtests        0.99    Arjun Sondhi           1y Approximate Unconditional and...
    #>  10  16 permutes       2.3.2   Cesko C. Voeten        2M Permutation Tests for Time Se...

If the whole phrase does not match, pkgsearch falls back to individual
matching words. For example, a match from either words is enough here,
to get on the first page of results:

``` r
ps("test http")
```

    #> - "test http" ------------------------------------------ 6342 packages in 0.011 seconds -
    #>   #     package   version by                  @ title                                    
    #>   1 100 httptest  4.1.0   Neal Richardson    4M A Test Environment for HTTP Requests     
    #>   2  77 covr      3.5.1   Jim Hester         1y Test Coverage for Packages               
    #>   3  36 webfakes  1.1.3   Gábor Csárdi       9M Fake Web Apps for HTTP Testing           
    #>   4  15 testthat  3.1.2   Hadley Wickham    10d Unit Testing for R                       
    #>   5  14 vcr       1.0.2   Scott Chamberlain  8M Record 'HTTP' Calls to Disk              
    #>   6  13 psych     2.1.9   William Revelle    4M Procedures for Psychological, Psychome...
    #>   7   9 webmockr  0.8.0   Scott Chamberlain 11M Stubbing and Setting Expectations on '...
    #>   8   8 httr      1.4.2   Hadley Wickham     2y Tools for Working with URLs and HTTP     
    #>   9   6 rmarkdown 2.11    Yihui Xie          5M Dynamic Documents for R                  
    #>  10   6 bnlearn   4.7     Marco Scutari      5M Bayesian Network Structure Learning, P...

### British vs American English

The search engine uses a dictionary to make sure that package metadata
and queries given in British and American English yield the same
results. E.g. note the spelling of colour/color in the results:

``` r
ps("colour")
```

    #> - "colour" ---------------------------------------------- 269 packages in 0.005 seconds -
    #>   #     package      version by                 @ title                                  
    #>   1 100 crayon       1.4.2   Gábor Csárdi      3M Colored Terminal Output                
    #>   2  60 colorspace   2.0.2   Achim Zeileis     7M A Toolbox for Manipulating and Asses...
    #>   3  57 viridis      0.6.2   Simon Garnier     4M Colorblind-Friendly Color Maps for R   
    #>   4  42 pillar       1.6.5   Kirill Müller     5d Coloured Formatting for Columns        
    #>   5  39 viridisLite  0.4.0   Simon Garnier    10M Colorblind-Friendly Color Maps (Lite...
    #>   6  36 colourpicker 1.1.1   Dean Attali       4M A Colour Picker Tool for Shiny and f...
    #>   7  27 shape        1.4.6   Karline Soetaert  9M Functions for Plotting Graphical Sha...
    #>   8  25 RColorBrewer 1.1.2   Erich Neuwirth    7y ColorBrewer Palettes                   
    #>   9  23 colorRamps   2.3     Tim Keitt         9y Builds color tables                    
    #>  10  20 ggnewscale   0.4.5   Elio Campitelli   1y Multiple Fill and Colour Scales in '...

``` r
ps("color")
```

    #> - "color" ----------------------------------------------- 268 packages in 0.005 seconds -
    #>   #     package      version by                 @ title                                  
    #>   1 100 crayon       1.4.2   Gábor Csárdi      3M Colored Terminal Output                
    #>   2  60 colorspace   2.0.2   Achim Zeileis     7M A Toolbox for Manipulating and Asses...
    #>   3  57 viridis      0.6.2   Simon Garnier     4M Colorblind-Friendly Color Maps for R   
    #>   4  42 pillar       1.6.5   Kirill Müller     5d Coloured Formatting for Columns        
    #>   5  39 viridisLite  0.4.0   Simon Garnier    10M Colorblind-Friendly Color Maps (Lite...
    #>   6  36 colourpicker 1.1.1   Dean Attali       4M A Colour Picker Tool for Shiny and f...
    #>   7  27 shape        1.4.6   Karline Soetaert  9M Functions for Plotting Graphical Sha...
    #>   8  25 RColorBrewer 1.1.2   Erich Neuwirth    7y ColorBrewer Palettes                   
    #>   9  23 colorRamps   2.3     Tim Keitt         9y Builds color tables                    
    #>  10  20 ggnewscale   0.4.5   Elio Campitelli   1y Multiple Fill and Colour Scales in '...

### Ascii Folding

Especially when searching for package maintainer names, it is convenient
to use the corresponding ASCII letters for non-ASCII characters in
search phrases. E.g. the following two queries yield the same results.
Note that case is also ignored.

``` r
ps("gabor", size = 5)
```

    #> - "gabor" ----------------------------------------------- 101 packages in 0.005 seconds -
    #>   #     package  version by              @ title                                         
    #>  1  100 crayon   1.4.2   Gábor Csárdi   3M Colored Terminal Output                       
    #>  2   85 cli      3.1.1   Gábor Csárdi  10d Helpers for Developing Command Line Interfaces
    #>  3   77 progress 1.2.2   Gábor Csárdi   3y Terminal Progress Bars                        
    #>  4   61 zoo      1.8.9   Achim Zeileis 11M S3 Infrastructure for Regular and Irregular...
    #>  5   60 fs       1.5.2   Gábor Csárdi   2M Cross-Platform File System Operations Based...

``` r
ps("Gábor", size = 5)
```

    #> - "Gábor" ----------------------------------------------- 101 packages in 0.004 seconds -
    #>   #     package  version by              @ title                                         
    #>  1  100 crayon   1.4.2   Gábor Csárdi   3M Colored Terminal Output                       
    #>  2   85 cli      3.1.1   Gábor Csárdi  10d Helpers for Developing Command Line Interfaces
    #>  3   77 progress 1.2.2   Gábor Csárdi   3y Terminal Progress Bars                        
    #>  4   61 zoo      1.8.9   Achim Zeileis 11M S3 Infrastructure for Regular and Irregular...
    #>  5   60 fs       1.5.2   Gábor Csárdi   2M Cross-Platform File System Operations Based...

## More info

See the [complete documentation](https://r-hub.github.io/pkgsearch/).

## License

MIT @ [Gábor Csárdi](https://github.com/gaborcsardi),
[RStudio](https://github.com/rstudio), [R
Consortium](https://www.r-consortium.org/).
