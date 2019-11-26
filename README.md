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

Do you need to find packages solving a particular problem, e.g.
“permutation test”?

``` r
library("pkgsearch")
pkg_search("permutation test")
```

    #> - "permutation test" ----------------------------------- 1835 packages in 0.014 seconds -
    #>   #     package        version by                      @ title                           
    #>   1 100 coin           1.3.1   Torsten Hothorn        3M Conditional Inference Procedu...
    #>   2  33 flip           2.5.0   Livio Finos            1y Multivariate Permutation Tests  
    #>   3  31 exactRankTests 0.8.30  Torsten Hothorn        7M Exact Distributions for Rank ...
    #>   4  30 perm           1.0.0.0 Michael Fay            9y Exact or Asymptotic permutati...
    #>   5  25 jmuOutlier     2.2     Steven T. Garren       4M Permutation Tests for Nonpara...
    #>   6  21 wPerm          1.0.1   Neil A. Weiss          4y Permutation Tests               
    #>   7  18 cpt            1.0.2   Johann Gagnon-Bartsch  1y Classification Permutation Test 
    #>   8  18 GlobalDeviance 0.4     Frederike Fuhlbrueck   6y Global Deviance Permutation T...
    #>   9  18 permutes       1.0     Cesko C. Voeten        4M Permutation Tests for Time Se...
    #>  10  17 AUtests        0.98    Arjun Sondhi           3y Approximate Unconditional and...

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

    #> # A tibble: 25 x 25
    #>    Package Type  Title Version Author Maintainer Description URL   License LazyData
    #>  * <chr>   <chr> <chr> <chr>   <chr>  <chr>      <chr>       <chr> <chr>   <chr>   
    #>  1 testth… Pack… Tool… 0.1     Hadle… Hadley Wi… Test_that … http… GPL     true    
    #>  2 testth… Pack… Test… 0.1.1   Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  3 testth… Pack… Test… 0.2     Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  4 testth… Pack… Test… 0.3     Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  5 testth… Pack… Test… 0.4     Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  6 testth… Pack… Test… 0.5     Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  7 testth… Pack… Test… 0.6     Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  8 testth… Pack… Test… 0.7     Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  9 testth… Pack… Test… 0.7.1   Hadle… Hadley Wi… A testing … http… GPL     true    
    #> 10 testth… Pack… Test… 0.8     Hadle… Hadley Wi… A testing … http… MIT + … true    
    #> # … with 15 more rows, and 15 more variables: Collate <chr>, Packaged <chr>,
    #> #   Repository <chr>, `Date/Publication` <chr>, crandb_file_date <chr>, date <chr>,
    #> #   dependencies <list>, NeedsCompilation <chr>, Roxygen <chr>, `Authors@R` <chr>,
    #> #   BugReports <chr>, RoxygenNote <chr>, VignetteBuilder <chr>, Encoding <chr>,
    #> #   MD5sum <chr>

### Discover packages

Do you want to know what packages are trending on CRAN these days?
`pkgsearch` can help!

``` r
cran_trending()
```

    #> # A tibble: 100 x 2
    #>    package           score                 
    #>    <chr>             <chr>                 
    #>  1 effectsize        62015.4696132596685100
    #>  2 leaflet.providers 6643.3748373908195500 
    #>  3 farver            2829.3291388772503400 
    #>  4 renv              1054.6458141674333000 
    #>  5 joint.Cox         713.9481572914829800  
    #>  6 rsq               605.0799623706491100  
    #>  7 NNS               604.4613918017159200  
    #>  8 fable             575.6197740941763200  
    #>  9 lobstr            558.1014729950900200  
    #> 10 feasts            523.3285233285233300  
    #> # … with 90 more rows

``` r
cran_top_downloaded()
```

    #> # A tibble: 100 x 2
    #>    package         count 
    #>    <chr>           <chr> 
    #>  1 magrittr        865875
    #>  2 aws.s3          727198
    #>  3 aws.ec2metadata 719639
    #>  4 rsconnect       700497
    #>  5 rlang           351085
    #>  6 Rcpp            268809
    #>  7 dplyr           264531
    #>  8 ellipsis        243197
    #>  9 ggplot2         237589
    #> 10 purrr           229599
    #> # … with 90 more rows

### Keep up with CRAN

Are you curious about the latest releases or archivals?

``` r
cran_events()
```

    #> CRAN events (events)---------------------------------------------------------------------
    #>  . When     Package      Version    Title                                                
    #>  + 3 hours  kohonen      3.0.10     Supervised and Unsupervised Self-Organising Maps     
    #>  + 3 hours  atable       0.1.4      Create Tables for Reporting Clinical Trials          
    #>  + 4 hours  rbiouml      1.9        Interact with BioUML Server                          
    #>  + 5 hours  lillies      0.2.5      Estimation of Life Years Lost                        
    #>  + 6 hours  CovTools     0.5.3      Statistical Tools for Covariance Analysis            
    #>  + 6 hours  quanteda     1.5.2      Quantitative Analysis of Textual Data                
    #>  + 6 hours  sptm         2019.11-25 SemiParametric Transformation Model Methods          
    #>  + 7 hours  IPDFileCheck 0.6.0      Basic Functions to Check Readability, Consistency,...
    #>  + 14 hours lcc          1.0.3      Longitudinal Concordance Correlation                 
    #>  + 14 hours MLeval       0.1        Machine Learning Model Evaluation

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

    #> - "C++" ------------------------------------------------- 7973 packages in 0.01 seconds -
    #>   #     package      version  by                    @ title                              
    #>   1 100 Rcpp         1.0.3    Dirk Eddelbuettel   18d Seamless R and C++ Integration     
    #>   2  30 BH           1.69.0.1 Dirk Eddelbuettel   11M Boost C++ Header Files             
    #>   3  16 markdown     1.1      Yihui Xie            4M Render Markdown with the C Libra...
    #>   4  14 StanHeaders  2.19.0   Ben Goodrich         3M C++ Header Files for Stan          
    #>   5  12 inline       0.3.15   Dirk Eddelbuettel    2y Functions to Inline C, C++, Fort...
    #>   6  11 RcppProgress 0.4.1    Karl Forner          2y An Interruptible Progress Bar wi...
    #>   7  10 SnowballC    0.6.0    Milan Bouchet-Valat 10M Snowball Stemmers Based on the C...
    #>   8  10 covr         3.3.2    Jim Hester           1M Test Coverage for Packages         
    #>   9   7 glpkAPI      1.3.1    Mayo Roettger        1y R Interface to C API of GLPK       
    #>  10   6 RNifti       1.0.0    Jon Clayden          5d Fast R and C++ Access to NIfTI I...

``` r
pkg_search()
```

    #> - "C++" ------------------------------------------------- 7973 packages in 0.01 seconds -
    #> 
    #> 1 Rcpp @ 1.0.3                                             Dirk Eddelbuettel, 18 days ago
    #> --------------
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
    #> 2 BH @ 1.69.0.1                                          Dirk Eddelbuettel, 11 months ago
    #> ---------------
    #>   # Boost C++ Header Files
    #>   Boost provides free peer-reviewed portable C++ source libraries.  A large part
    #>   of Boost is provided as C++ template code which is resolved entirely at
    #>   compile-time without linking.  This package aims to provide the most useful
    #>   subset of Boost libraries for template use among CRAN package. By placing
    #>   these libraries in this package, we offer a more efficient distribution system
    #>   for CRAN as replication of this code in the sources of other packages is
    #>   avoided. As of release 1.69.0-1, the following Boost libraries are included:
    #>   'algorithm' 'align' 'any' 'atomic' 'bimap' 'bind' 'circular_buffer' 'compute'
    #>   'concept' 'config' 'container' 'date_time' 'detail' 'dynamic_bitset'
    #>   'exception' 'filesystem' 'flyweight' 'foreach' 'functional' 'fusion'
    #>   'geometry' 'graph' 'heap' 'icl' 'integer' 'interprocess' 'intrusive' 'io'
    #>   'iostreams' 'iterator' 'math' 'move' 'mpl' 'multiprcecision' 'numeric'
    #>   'pending' 'phoenix' 'preprocessor' 'propery_tree' 'random' 'range'
    #>   'scope_exit' 'smart_ptr' 'sort' 'spirit' 'tuple' 'type_traits' 'typeof'
    #>   'unordered' 'utility' 'uuid'.
    #> 
    #> 3 markdown @ 1.1                                                  Yihui Xie, 4 months ago
    #> ----------------
    #>   # Render Markdown with the C Library 'Sundown'
    #>   Provides R bindings to the 'Sundown' Markdown rendering library
    #>   (<https://github.com/vmg/sundown>). Markdown is a plain-text formatting syntax
    #>   that can be converted to 'XHTML' or other formats. See
    #>   <http://en.wikipedia.org/wiki/Markdown> for more information about Markdown.
    #>   https://github.com/rstudio/markdown
    #> 
    #> 4 StanHeaders @ 2.19.0                                         Ben Goodrich, 3 months ago
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
    #> 6 RcppProgress @ 0.4.1                                           Karl Forner, 2 years ago
    #> ----------------------
    #>   # An Interruptible Progress Bar with OpenMP Support for C++ in R Packages
    #>   Allows to display a progress bar in the R console for long running
    #>   computations taking place in c++ code, and support for interrupting those
    #>   computations even in multithreaded code, typically using OpenMP.
    #>   https://github.com/kforner/rcpp_progress
    #> 
    #> 7 SnowballC @ 0.6.0                                    Milan Bouchet-Valat, 10 months ago
    #> -------------------
    #>   # Snowball Stemmers Based on the C 'libstemmer' UTF-8 Library
    #>   An R interface to the C 'libstemmer' library that implements Porter's word
    #>   stemming algorithm for collapsing words to a common root to aid comparison of
    #>   vocabulary. Currently supported languages are Danish, Dutch, English, Finnish,
    #>   French, German, Hungarian, Italian, Norwegian, Portuguese, Romanian, Russian,
    #>   Spanish, Swedish and Turkish.
    #>   https://r-forge.r-project.org/projects/r-temis/
    #> 
    #> 8 covr @ 3.3.2                                              Jim Hester, about a month ago
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
    #> 9 glpkAPI @ 1.3.1                                         Mayo Roettger, about a year ago
    #> -----------------
    #>   # R Interface to C API of GLPK
    #>   R Interface to C API of GLPK, depends on GLPK Version >= 4.42.
    #> 
    #> 10 RNifti @ 1.0.0                                                 Jon Clayden, 5 days ago
    #> -----------------
    #>   # Fast R and C++ Access to NIfTI Images
    #>   Provides very fast read and write access to images stored in the NIfTI-1 and
    #>   ANALYZE-7.5 formats, with seamless synchronisation between compiled C and
    #>   interpreted R code. Also provides a simple image viewer, and a C/C++ API that
    #>   can be used by other packages. Not to be confused with 'RNiftyReg', which
    #>   performs image registration.
    #>   https://github.com/jonclayden/RNifti

### Pagination

The `more()` function can be used to display the next batch of search
hits, batches contain ten packages by default. `ps()` is a shorter alias
to `pkg_search()`:

``` r
ps("google")
```

    #> - "google" ---------------------------------------------- 126 packages in 0.008 seconds -
    #>   #     package             version by               @ title                             
    #>   1 100 googleVis           0.6.4   Markus Gesmann  6M R Interface to Google Charts      
    #>   2  77 googleAuthR         1.1.1   Mark Edmondson  3M Authenticate and Create Google ...
    #>   3  66 lubridate           1.7.4   Vitalie Spinu   2y Make Dealing with Dates a Littl...
    #>   4  63 gargle              0.4.0   Jennifer Bryan  2M Utilities for Working with Goog...
    #>   5  52 googledrive         1.0.0   Jennifer Bryan  3M An Interface to Google Drive      
    #>   6  49 googleCloudStorageR 0.5.1   Mark Edmondson  3M Interface with Google Cloud Sto...
    #>   7  48 googlesheets        0.3.0   Jennifer Bryan  1y Manage Google Spreadsheets from R 
    #>   8  44 plotKML             0.6.0   Tomislav Hengl 14d Visualization of Spatial and Sp...
    #>   9  40 cld2                1.2     Jeroen Ooms     2y Google's Compact Language Detec...
    #>  10  37 gsheet              0.4.2   Max Conway      3y Download Google Sheets Using Ju...

``` r
more()
```

    #> - "google" ---------------------------------------------- 126 packages in 0.008 seconds -
    #>   #    package          version by                     @ title                           
    #>  11 36 bigQueryR        0.5.0   Mark Edmondson        2M Interface with Google BigQuer...
    #>  12 34 ggmap            3.0.0   ORPHANED             10M Spatial Visualization with gg...
    #>  13 34 googlePolylines  0.7.2   David Cooley          1y Encoding Coordinates into 'Go...
    #>  14 34 googleAnalyticsR 0.7.1   Mark Edmondson       22d Google Analytics API into R     
    #>  15 28 V8               2.3     Jeroen Ooms           5M Embedded JavaScript Engine for R
    #>  16 27 gcite            0.10.1  John Muschelli        9M Google Citation Parser          
    #>  17 27 rgoogleslides    0.3.1   Hairizuan Noorazman   1y R Interface to Google Slides    
    #>  18 26 plusser          0.4.0   Christoph Waldhauser  6y A Google+ Interface for R       
    #>  19 26 ganalytics       0.10.7  Johann de Boer        9M Interact with 'Google Analytics'
    #>  20 26 adwordsR         0.3.1   Sean Longthorpe       1y Access the 'Google Adwords' API

### Stemming

The search server uses the stems of the words in the indexed metadata,
and the search phrase. This means that “colour” and “colours” deliver
the exact same result. So do “coloring”, “colored”, etc. (Unless one is
happen to be an exact package name or match another non-stemmed field.)

``` r
ps("colour", size = 3)
```

    #> - "colour" ---------------------------------------------- 201 packages in 0.009 seconds -
    #>   #     package    version by              @ title                                       
    #>  1  100 crayon     1.3.4   Gábor Csárdi   2y Colored Terminal Output                     
    #>  2   71 colorspace 1.4.1   Achim Zeileis  8M A Toolbox for Manipulating and Assessing ...
    #>  3   67 viridis    0.5.1   Simon Garnier  2y Default Color Maps from 'matplotlib'

``` r
ps("colours", size = 3)
```

    #> - "colours" --------------------------------------------- 198 packages in 0.007 seconds -
    #>   #     package    version by              @ title                                       
    #>  1  100 crayon     1.3.4   Gábor Csárdi   2y Colored Terminal Output                     
    #>  2   71 colorspace 1.4.1   Achim Zeileis  8M A Toolbox for Manipulating and Assessing ...
    #>  3   67 viridis    0.5.1   Simon Garnier  2y Default Color Maps from 'matplotlib'

### Ranking

The most important feature of a search engine is the ranking of the
results. The best results should be listed first. pkgsearch uses
weighted scoring, where a match in the package title gets a higher score
than a match in the package description. It also uses the number of
reverse dependencies and the number of downloads to weight the scores:

``` r
ps("colour")[, c("score", "package", "revdeps", "downloads_last_month")]
```

    #> # A tibble: 10 x 4
    #>     score package      revdeps downloads_last_month
    #>     <dbl> <chr>          <int>                <int>
    #>  1 13168. crayon           203               570439
    #>  2  9408. colorspace       141               567057
    #>  3  8765. viridis          109               240556
    #>  4  5944. pillar            36               783872
    #>  5  5730. colourpicker      31                25273
    #>  6  4974. viridisLite       47               466781
    #>  7  4837. shape             34                48705
    #>  8  3887. RColorBrewer     451               517685
    #>  9  3617. colorRamps        15                 4968
    #> 10  3432. dichromat         12                23156

### Preferring Phrases

The search engine prefers matching whole phrases over single words. E.g.
the search phrase “permutation test” will rank coin higher than
testthat, even though testthat is a much better result for the single
word “test”. (In fact, at the time of writing testthat is not even on
the first page of results.)

``` r
ps("permutation test")
```

    #> - "permutation test" ----------------------------------- 1835 packages in 0.015 seconds -
    #>   #     package        version by                      @ title                           
    #>   1 100 coin           1.3.1   Torsten Hothorn        3M Conditional Inference Procedu...
    #>   2  33 flip           2.5.0   Livio Finos            1y Multivariate Permutation Tests  
    #>   3  31 exactRankTests 0.8.30  Torsten Hothorn        7M Exact Distributions for Rank ...
    #>   4  30 perm           1.0.0.0 Michael Fay            9y Exact or Asymptotic permutati...
    #>   5  25 jmuOutlier     2.2     Steven T. Garren       4M Permutation Tests for Nonpara...
    #>   6  21 wPerm          1.0.1   Neil A. Weiss          4y Permutation Tests               
    #>   7  18 cpt            1.0.2   Johann Gagnon-Bartsch  1y Classification Permutation Test 
    #>   8  18 GlobalDeviance 0.4     Frederike Fuhlbrueck   6y Global Deviance Permutation T...
    #>   9  18 permutes       1.0     Cesko C. Voeten        4M Permutation Tests for Time Se...
    #>  10  17 AUtests        0.98    Arjun Sondhi           3y Approximate Unconditional and...

If the whole phrase does not match, pkgsearch falls back to individual
matching words. For example, a match from either words is enough here,
to get on the first page of results:

``` r
ps("test http")
```

    #> - "test http" ------------------------------------------ 5860 packages in 0.018 seconds -
    #>   #     package   version   by                   @ title                                 
    #>   1 100 httptest  3.2.2     Neal Richardson     1y A Test Environment for HTTP Requests  
    #>   2  83 covr      3.3.2     Jim Hester          1M Test Coverage for Packages            
    #>   3  33 testthat  2.3.0     Hadley Wickham     21d Unit Testing for R                    
    #>   4  16 psych     1.8.12    William Revelle    11M Procedures for Psychological, Psych...
    #>   5  13 vcr       0.3.0     Scott Chamberlain   3M Record 'HTTP' Calls to Disk           
    #>   6  10 httr      1.4.1     Hadley Wickham      4M Tools for Working with URLs and HTTP  
    #>   7   8 webmockr  0.4.0     Scott Chamberlain   4M Stubbing and Setting Expectations o...
    #>   8   8 bnlearn   4.5       Marco Scutari       4M Bayesian Network Structure Learning...
    #>   9   7 RCurl     1.95.4.12 Duncan Temple Lang  9M General Network (HTTP/FTP/...) Clie...
    #>  10   6 oompaBase 3.2.9     Kevin R. Coombes    3M Class Unions, Matrix Operations, an...

### British vs American English

The search engine uses a dictionary to make sure that package metadata
and queries given in British and American English yield the same
results. E.g. note the spelling of colour/color in the results:

``` r
ps("colour")
```

    #> - "colour" ---------------------------------------------- 201 packages in 0.007 seconds -
    #>   #     package      version by                 @ title                                  
    #>   1 100 crayon       1.3.4   Gábor Csárdi      2y Colored Terminal Output                
    #>   2  71 colorspace   1.4.1   Achim Zeileis     8M A Toolbox for Manipulating and Asses...
    #>   3  67 viridis      0.5.1   Simon Garnier     2y Default Color Maps from 'matplotlib'   
    #>   4  45 pillar       1.4.2   Kirill Müller     5M Coloured Formatting for Columns        
    #>   5  44 colourpicker 1.0     Dean Attali       2y A Colour Picker Tool for Shiny and f...
    #>   6  38 viridisLite  0.3.0   Simon Garnier     2y Default Color Maps from 'matplotlib'...
    #>   7  37 shape        1.4.4   Karline Soetaert  2y Functions for Plotting Graphical Sha...
    #>   8  30 RColorBrewer 1.1.2   Erich Neuwirth    5y ColorBrewer Palettes                   
    #>   9  27 colorRamps   2.3     Tim Keitt         7y Builds color tables                    
    #>  10  26 dichromat    2.0.0   Thomas Lumley     7y Color Schemes for Dichromats

``` r
ps("color")
```

    #> - "color" ----------------------------------------------- 198 packages in 0.007 seconds -
    #>   #     package      version by                 @ title                                  
    #>   1 100 crayon       1.3.4   Gábor Csárdi      2y Colored Terminal Output                
    #>   2  71 colorspace   1.4.1   Achim Zeileis     8M A Toolbox for Manipulating and Asses...
    #>   3  67 viridis      0.5.1   Simon Garnier     2y Default Color Maps from 'matplotlib'   
    #>   4  45 pillar       1.4.2   Kirill Müller     5M Coloured Formatting for Columns        
    #>   5  44 colourpicker 1.0     Dean Attali       2y A Colour Picker Tool for Shiny and f...
    #>   6  38 viridisLite  0.3.0   Simon Garnier     2y Default Color Maps from 'matplotlib'...
    #>   7  37 shape        1.4.4   Karline Soetaert  2y Functions for Plotting Graphical Sha...
    #>   8  30 RColorBrewer 1.1.2   Erich Neuwirth    5y ColorBrewer Palettes                   
    #>   9  27 colorRamps   2.3     Tim Keitt         7y Builds color tables                    
    #>  10  26 dichromat    2.0.0   Thomas Lumley     7y Color Schemes for Dichromats

### Ascii Folding

Especially when searching for package maintainer names, it is convenient
to use the corresponding ASCII letters for non-ASCII characters in
search phrases. E.g. the following two queries yield the same results.
Note that case is also ignored.

``` r
ps("gabor", size = 5)
```

    #> - "gabor" ------------------------------------------------ 87 packages in 0.008 seconds -
    #>   #     package  version by              @ title                                         
    #>  1  100 igraph   1.2.4.1 Gábor Csárdi   7M Network Analysis and Visualization            
    #>  2   58 crayon   1.3.4   Gábor Csárdi   2y Colored Terminal Output                       
    #>  3   39 zoo      1.8.6   Achim Zeileis  6M S3 Infrastructure for Regular and Irregular...
    #>  4   38 cli      1.1.0   Gábor Csárdi   8M Helpers for Developing Command Line Interfaces
    #>  5   37 progress 1.2.2   Gábor Csárdi   6M Terminal Progress Bars

``` r
ps("Gábor", size = 5)
```

    #> - "Gábor" ------------------------------------------------ 87 packages in 0.008 seconds -
    #>   #     package  version by              @ title                                         
    #>  1  100 igraph   1.2.4.1 Gábor Csárdi   7M Network Analysis and Visualization            
    #>  2   58 crayon   1.3.4   Gábor Csárdi   2y Colored Terminal Output                       
    #>  3   39 zoo      1.8.6   Achim Zeileis  6M S3 Infrastructure for Regular and Irregular...
    #>  4   38 cli      1.1.0   Gábor Csárdi   8M Helpers for Developing Command Line Interfaces
    #>  5   37 progress 1.2.2   Gábor Csárdi   6M Terminal Progress Bars

More info
---------

See the [complete documentation](https://r-hub.github.io/pkgsearch/).

License
-------

MIT @ [Gábor Csárdi](https://github.com/gaborcsardi),
[RStudio](https://github.com/rstudio), [R
Consortium](https://www.r-consortium.org/).
