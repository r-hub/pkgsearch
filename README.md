# Search and Query CRAN R Packages

<!-- badges: start -->
[![lifecycle](https://lifecycle.r-lib.org/articles/figures/lifecycle-stable.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable-1)
[![R-CMD-check](https://github.com/r-hub/pkgsearch/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/r-hub/pkgsearch/actions/workflows/R-CMD-check.yaml)
[![CRAN status](https://www.r-pkg.org/badges/version/pkgsearch)](https://cran.r-project.org/package=pkgsearch)
[![CRAN RStudio mirror downloads](https://cranlogs.r-pkg.org/badges/pkgsearch)](https://www.r-pkg.org/pkg/pkgsearch)
[![Codecov test coverage](https://codecov.io/gh/r-hub/pkgsearch/branch/main/graph/badge.svg)](https://app.codecov.io/gh/r-hub/pkgsearch?branch=main)
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
-   [Configuration](#configuration)
    -   [Options](#options)
-   [More info](#more-info)
-   [License](#license)

<!-- README.md is generated from README.Rmd. Please edit that file -->

## Installation

Install the latest pkgsearch release from CRAN:

``` r
install.packages("pkgsearch")
```

The development version is on GitHub:

``` r
pak::pak("r-hub/pkgsearch")
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

    #> - "permutation test" ----------------------------------- 2694 packages in 0.062 seconds -
    #>   #     package           version by                      @ title                        
    #>   1 100 coin              1.4.3   Torsten Hothorn        1y Conditional Inference Proc...
    #>   2  35 perm              1.0.0.4 Michael P. Fay         1y Exact or Asymptotic Permut...
    #>   3  32 exactRankTests    0.8.35  Torsten Hothorn        3y Exact Distributions for Ra...
    #>   4  31 lmPerm            2.1.0   Marco Torchiano        8y Permutation Tests for Line...
    #>   5  29 flip              2.5.0   Livio Finos            6y Multivariate Permutation T...
    #>   6  22 jmuOutlier        2.2     Steven T. Garren       5y Permutation Tests for Nonp...
    #>   7  22 nptest            1.1     Nathaniel E. Helwig    2y Nonparametric Bootstrap an...
    #>   8  19 phyloseqGraphTest 0.1.1   Julia Fukuyama         1y Graph-Based Permutation Te...
    #>   9  19 wPerm             1.0.1   Neil A. Weiss          9y Permutation Tests            
    #>  10  17 cpt               1.0.2   Johann Gagnon-Bartsch  6y Classification Permutation...

pkgsearch uses an [R-hub](https://github.com/r-hub) web service and a
careful ranking that puts popular packages before less frequently used
ones.

### Do it all *clicking*

For the search mentioned above, and other points of entry to CRAN
metadata, you can use pkgsearch RStudio add-in!

[![Addin
screencast](https://raw.githubusercontent.com/r-hub/pkgsearch/main/gifs/addin.gif)](https://vimeo.com/375618736)

Select the “CRAN package search” addin from the menu, or start it with
`pkg_search_addin()`.

### Get package metadata

Do you want to find the dependencies the first versions of `testthat`
had and when each of these versions was released?

``` r
cran_package_history("testthat")
```

    #> # A data frame: 47 × 29
    #>    Package  Type    Title     Version Author Maintainer Description URL   License LazyData
    #>  * <chr>    <chr>   <chr>     <chr>   <chr>  <chr>      <chr>       <chr> <chr>   <chr>   
    #>  1 testthat Package Tools fo… 0.1     Hadle… Hadley Wi… Test_that … http… GPL     true    
    #>  2 testthat Package Testthat… 0.1.1   Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  3 testthat Package Testthat… 0.2     Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  4 testthat Package Testthat… 0.3     Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  5 testthat Package Testthat… 0.4     Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  6 testthat Package Testthat… 0.5     Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  7 testthat Package Testthat… 0.6     Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  8 testthat Package Testthat… 0.7     Hadle… Hadley Wi… A testing … http… GPL     true    
    #>  9 testthat Package Testthat… 0.7.1   Hadle… Hadley Wi… A testing … http… GPL     true    
    #> 10 testthat Package Testthat… 0.8     Hadle… Hadley Wi… A testing … http… MIT + … true    
    #> # ℹ 37 more rows
    #> # ℹ 19 more variables: Collate <chr>, Packaged <chr>, Repository <chr>,
    #> #   `Date/Publication` <chr>, crandb_file_date <chr>, date <chr>, dependencies <list>,
    #> #   NeedsCompilation <chr>, Roxygen <chr>, `Authors@R` <chr>, BugReports <chr>,
    #> #   RoxygenNote <chr>, VignetteBuilder <chr>, Encoding <chr>, MD5sum <chr>,
    #> #   `Config/testthat/edition` <chr>, `Config/testthat/parallel` <chr>,
    #> #   `Config/testthat/start-first` <chr>, `Config/Needs/website` <chr>

### Discover packages

Do you want to know what packages are trending on CRAN these days?
`pkgsearch` can help!

``` r
cran_trending()
```

    #> # A data frame: 100 × 2
    #>    package   score                
    #>    <chr>     <chr>                
    #>  1 str2str   2633.3621434745030300
    #>  2 dataset   1982.4675324675324700
    #>  3 priceR    1980.9412623130244400
    #>  4 harbinger 545.1412604781123900 
    #>  5 spatial   539.8151018398643400 
    #>  6 gsubfn    527.1264266513903000 
    #>  7 proto     425.2139863982963500 
    #>  8 dad       420.7134086076252700 
    #>  9 class     371.7153561418388700 
    #> 10 nnet      351.3673143937156700 
    #> # ℹ 90 more rows

``` r
cran_top_downloaded()
```

    #> # A data frame: 100 × 2
    #>    package   count 
    #>    <chr>     <chr> 
    #>  1 rlang     297540
    #>  2 cli       279443
    #>  3 lifecycle 277978
    #>  4 dplyr     270181
    #>  5 glue      262172
    #>  6 ggplot2   256966
    #>  7 vctrs     252852
    #>  8 jsonlite  238025
    #>  9 withr     236281
    #> 10 curl      221302
    #> # ℹ 90 more rows

### Keep up with CRAN

Are you curious about the latest releases or archivals?

``` r
cran_events()
```

    #> CRAN events (events)---------------------------------------------------------------------
    #>  . When    Package      Version Title                                                    
    #>  + 2 hours eefAnalytics 1.1.5   Robust Analytical Methods for Evaluating Educational I...
    #>  + 3 hours mvhtests     1.1     Multivariate Hypothesis Tests                            
    #>  + 4 hours Compind      3.2     Composite Indicators Functions                           
    #>  + 4 hours pecora       0.1.2   Permutation Conditional Random Tests                     
    #>  + 5 hours oceanic      0.1.8   Location Identify Tool                                   
    #>  + 6 hours plotthis     0.5.0   High-Level Plotting Built Upon 'ggplot2' and Other Plo...
    #>  + 7 hours EnsembleBase 1.0.4   Extensible Package for Parallel, Batch Training of Bas...
    #>  + 7 hours OralOpioids  2.0.4   Retrieving Oral Opioid Information                       
    #>  + 7 hours BayesMixSurv 0.9.3   Bayesian Mixture Survival Models using Additive Mixtur...
    #>  + 7 hours EMCluster    0.2-17  EM Algorithm for Model-Based Clustering of Finite Mixt...

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

    #> - "C++" ----------------------------------------------- 10000 packages in 0.029 seconds -
    #>   #     package      version  by                    @ title                              
    #>   1 100 Rcpp         1.0.13.1 Dirk Eddelbuettel    2M Seamless R and C++ Integration     
    #>   2  33 BH           1.87.0.1 Dirk Eddelbuettel   23d Boost C++ Header Files             
    #>   3  21 StanHeaders  2.32.10  Ben Goodrich         6M C++ Header Files for Stan          
    #>   4  20 cpp11        0.5.1    Davis Vaughan        1M A C++11 Interface for R's C Inte...
    #>   5  15 RPostgres    1.4.7    Kirill Müller        8M C++ Interface to PostgreSQL        
    #>   6  14 RcppProgress 0.4.2    Karl Forner          5y An Interruptible Progress Bar wi...
    #>   7  12 covr         3.6.4    Jim Hester           1y Test Coverage for Packages         
    #>   8  10 RcppThread   2.2.0    Thomas Nagler        2d R-Friendly Threading in C++        
    #>   9  10 inline       0.3.20   Dirk Eddelbuettel    2M Functions to Inline C, C++, Fort...
    #>  10   9 SnowballC    0.7.1    Milan Bouchet-Valat  2y Snowball Stemmers Based on the C...

``` r
pkg_search()
```

    #> - "C++" ----------------------------------------------- 10000 packages in 0.029 seconds -
    #> 
    #> 1 Rcpp @ 1.0.13.1                                         Dirk Eddelbuettel, 2 months ago
    #> -----------------
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
    #>   https://www.rcpp.org
    #>   https://dirk.eddelbuettel.com/code/rcpp.html
    #>   https://github.com/RcppCore/Rcpp
    #> 
    #> 2 BH @ 1.87.0.1                                            Dirk Eddelbuettel, 23 days ago
    #> ---------------
    #>   # Boost C++ Header Files
    #>   Boost provides free peer-reviewed portable C++ source libraries.  A large part
    #>   of Boost is provided as C++ template code which is resolved entirely at
    #>   compile-time without linking.  This package aims to provide the most useful
    #>   subset of Boost libraries for template use among CRAN packages. By placing
    #>   these libraries in this package, we offer a more efficient distribution system
    #>   for CRAN as replication of this code in the sources of other packages is
    #>   avoided. As of release 1.84.0-0, the following Boost libraries are included:
    #>   'accumulators' 'algorithm' 'align' 'any' 'atomic' 'beast' 'bimap' 'bind'
    #>   'circular_buffer' 'compute' 'concept' 'config' 'container' 'date_time'
    #>   'detail' 'dynamic_bitset' 'exception' 'flyweight' 'foreach' 'functional'
    #>   'fusion' 'geometry' 'graph' 'heap' 'icl' 'integer' 'interprocess' 'intrusive'
    #>   'io' 'iostreams' 'iterator' 'lambda2' 'math' 'move' 'mp11' 'mpl'
    #>   'multiprecision' 'numeric' 'pending' 'phoenix' 'polygon' 'preprocessor'
    #>   'process' 'propery_tree' 'qvm' 'random' 'range' 'scope_exit' 'smart_ptr'
    #>   'sort' 'spirit' 'tuple' 'type_traits' 'typeof' 'unordered' 'url' 'utility'
    #>   'uuid'.
    #>   https://github.com/eddelbuettel/bh
    #>   https://dirk.eddelbuettel.com/code/bh.html
    #> 
    #> 3 StanHeaders @ 2.32.10                                        Ben Goodrich, 6 months ago
    #> -----------------------
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
    #> 4 cpp11 @ 0.5.1                                          Davis Vaughan, about a month ago
    #> ---------------
    #>   # A C++11 Interface for R's C Interface
    #>   Provides a header only, C++11 interface to R's C interface.  Compared to other
    #>   approaches 'cpp11' strives to be safe against long jumps from the C API as
    #>   well as C++ exceptions, conform to normal R function semantics and supports
    #>   interaction with 'ALTREP' vectors.
    #>   https://cpp11.r-lib.org
    #>   https://github.com/r-lib/cpp11
    #> 
    #> 5 RPostgres @ 1.4.7                                           Kirill Müller, 8 months ago
    #> -------------------
    #>   # C++ Interface to PostgreSQL
    #>   Fully DBI-compliant C++-backed interface to PostgreSQL
    #>   <https://www.postgresql.org/>, an open-source relational database.
    #>   https://rpostgres.r-dbi.org
    #>   https://github.com/r-dbi/RPostgres
    #> 
    #> 6 RcppProgress @ 0.4.2                                           Karl Forner, 5 years ago
    #> ----------------------
    #>   # An Interruptible Progress Bar with OpenMP Support for C++ in R Packages
    #>   Allows to display a progress bar in the R console for long running
    #>   computations taking place in c++ code, and support for interrupting those
    #>   computations even in multithreaded code, typically using OpenMP.
    #>   https://github.com/kforner/rcpp_progress
    #> 
    #> 7 covr @ 3.6.4                                               Jim Hester, about a year ago
    #> --------------
    #>   # Test Coverage for Packages
    #>   Track and report code coverage for your package and (optionally) upload the
    #>   results to a coverage service like 'Codecov' <https://about.codecov.io> or
    #>   'Coveralls' <https://coveralls.io>. Code coverage is a measure of the amount
    #>   of code being exercised by a set of tests. It is an indirect measure of test
    #>   quality and completeness. This package is compatible with any testing
    #>   methodology or framework and tracks coverage of both R code and compiled
    #>   C/C++/FORTRAN code.
    #>   https://covr.r-lib.org
    #>   https://github.com/r-lib/covr
    #> 
    #> 8 RcppThread @ 2.2.0                                            Thomas Nagler, 2 days ago
    #> --------------------
    #>   # R-Friendly Threading in C++
    #>   Provides a C++11-style thread class and thread pool that can safely be
    #>   interrupted from R. See Nagler (2021) <doi:10.18637/jss.v097.c01>.
    #>   https://github.com/tnagler/RcppThread
    #> 
    #> 9 inline @ 0.3.20                                         Dirk Eddelbuettel, 2 months ago
    #> -----------------
    #>   # Functions to Inline C, C++, Fortran Function Calls from R
    #>   Functionality to dynamically define R functions and S4 methods with 'inlined'
    #>   C, C++ or Fortran code supporting the .C and .Call calling conventions.
    #>   https://github.com/eddelbuettel/inline
    #>   https://dirk.eddelbuettel.com/code/inline.html
    #> 
    #> 10 SnowballC @ 0.7.1                                     Milan Bouchet-Valat, 2 years ago
    #> --------------------
    #>   # Snowball Stemmers Based on the C 'libstemmer' UTF-8 Library
    #>   An R interface to the C 'libstemmer' library that implements Porter's word
    #>   stemming algorithm for collapsing words to a common root to aid comparison of
    #>   vocabulary. Currently supported languages are Arabic, Basque, Catalan, Danish,
    #>   Dutch, English, Finnish, French, German, Greek, Hindi, Hungarian, Indonesian,
    #>   Irish, Italian, Lithuanian, Nepali, Norwegian, Portuguese, Romanian, Russian,
    #>   Spanish, Swedish, Tamil and Turkish.
    #>   https://github.com/nalimilan/R.TeMiS

### Pagination

The `more()` function can be used to display the next batch of search
hits, batches contain ten packages by default. `ps()` is a shorter alias
to `pkg_search()`:

``` r
ps("google")
```

    #> - "google" ----------------------------------------------- 180 packages in 0.01 seconds -
    #>   #     package             version by               @ title                             
    #>   1 100 googledrive         2.1.1   Jennifer Bryan  2y An Interface to Google Drive      
    #>   2  79 gargle              1.5.2   Jennifer Bryan  1y Utilities for Working with Goog...
    #>   3  73 googleVis           0.7.3   Markus Gesmann  8M R Interface to Google Charts      
    #>   4  65 googleAuthR         2.0.2   Erik Grönroos   8M Authenticate and Create Google ...
    #>   5  62 googlesheets4       1.1.1   Jennifer Bryan  2y Access Google Sheets using the ...
    #>   6  59 bigrquery           1.5.1   Hadley Wickham 10M An Interface to Google's 'BigQu...
    #>   7  51 googleCloudStorageR 0.7.0   Mark Edmondson  3y Interface with Google Cloud Sto...
    #>   8  48 googlePolylines     0.8.5   David Cooley    3M Encoding Coordinates into 'Goog...
    #>   9  48 cld2                1.2.5   Jeroen Ooms     3M Google's Compact Language Detec...
    #>  10  47 gsheet              0.4.6   Max Conway     27d Download Google Sheets Using Ju...

``` r
more()
```

    #> - "google" ----------------------------------------------- 180 packages in 0.01 seconds -
    #>   #    package          version by                    @ title                            
    #>  11 34 V8               6.0.0   Jeroen Ooms          3M Embedded JavaScript and WebAss...
    #>  12 32 cld3             1.6.1   Jeroen Ooms          3M Google's Compact Language Dete...
    #>  13 30 tensorflow       2.16.0  Tomasz Kalinowski    9M R Interface to 'TensorFlow'      
    #>  14 28 googleAnalyticsR 1.2.0   Erik Grönroos        5M Google Analytics API into R      
    #>  15 26 gfonts           0.2.0   Victor Perrier       2y Offline 'Google' Fonts for 'Ma...
    #>  16 26 re2              0.1.3   Girish Palya         1y R Interface to Google RE2 (C++...
    #>  17 25 gtrendsR         1.5.1   Philippe Massicotte  3y Perform and Display Google Tre...
    #>  18 25 googleway        2.7.8   David Cooley         1y Accesses Google Maps APIs to R...
    #>  19 24 scholar          0.2.4   Guangchuang Yu       2y Analyse Citation Data from Goo...
    #>  20 23 googletraffic    0.1.7   Robert Marty         4M Google Traffic

### Stemming

The search server uses the stems of the words in the indexed metadata,
and the search phrase. This means that “colour” and “colours” deliver
the exact same result. So do “coloring”, “colored”, etc. (Unless one is
happen to be an exact package name or match another non-stemmed field.)

``` r
ps("colour", size = 3)
```

    #> - "colour" ---------------------------------------------- 350 packages in 0.009 seconds -
    #>   #     package    version by              @ title                                       
    #>  1  100 crayon     1.5.3   Gábor Csárdi   7M Colored Terminal Output                     
    #>  2   66 viridis    0.6.5   Simon Garnier  1y Colorblind-Friendly Color Maps for R        
    #>  3   63 colorspace 2.1.1   Achim Zeileis  6M A Toolbox for Manipulating and Assessing ...

``` r
ps("colours", size = 3)
```

    #> - "colours" --------------------------------------------- 348 packages in 0.008 seconds -
    #>   #     package    version by              @ title                                       
    #>  1  100 crayon     1.5.3   Gábor Csárdi   7M Colored Terminal Output                     
    #>  2   66 viridis    0.6.5   Simon Garnier  1y Colorblind-Friendly Color Maps for R        
    #>  3   63 colorspace 2.1.1   Achim Zeileis  6M A Toolbox for Manipulating and Assessing ...

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
    #>  1 18395. crayon           378               731247
    #>  2 12138. viridis          230               165727
    #>  3 11601. colorspace       210               732566
    #>  4 10605. pillar           126               876646
    #>  5  7653. viridisLite      106               678701
    #>  6  7293. colourpicker      55                20121
    #>  7  5654. ggnewscale        50                26278
    #>  8  4692. shape             35               140417
    #>  9  4671. RColorBrewer     646               686954
    #> 10  4122. colorRamps        19                 3593

### Preferring Phrases

The search engine prefers matching whole phrases over single words. E.g.
the search phrase “permutation test” will rank coin higher than
testthat, even though testthat is a much better result for the single
word “test”. (In fact, at the time of writing testthat is not even on
the first page of results.)

``` r
ps("permutation test")
```

    #> - "permutation test" ----------------------------------- 2694 packages in 0.017 seconds -
    #>   #     package           version by                      @ title                        
    #>   1 100 coin              1.4.3   Torsten Hothorn        1y Conditional Inference Proc...
    #>   2  35 perm              1.0.0.4 Michael P. Fay         1y Exact or Asymptotic Permut...
    #>   3  32 exactRankTests    0.8.35  Torsten Hothorn        3y Exact Distributions for Ra...
    #>   4  31 lmPerm            2.1.0   Marco Torchiano        8y Permutation Tests for Line...
    #>   5  29 flip              2.5.0   Livio Finos            6y Multivariate Permutation T...
    #>   6  22 jmuOutlier        2.2     Steven T. Garren       5y Permutation Tests for Nonp...
    #>   7  22 nptest            1.1     Nathaniel E. Helwig    2y Nonparametric Bootstrap an...
    #>   8  19 phyloseqGraphTest 0.1.1   Julia Fukuyama         1y Graph-Based Permutation Te...
    #>   9  19 wPerm             1.0.1   Neil A. Weiss          9y Permutation Tests            
    #>  10  17 cpt               1.0.2   Johann Gagnon-Bartsch  6y Classification Permutation...

If the whole phrase does not match, pkgsearch falls back to individual
matching words. For example, a match from either words is enough here,
to get on the first page of results:

``` r
ps("test http")
```

    #> - "test http" ------------------------------------------ 7460 packages in 0.038 seconds -
    #>   #     package   version by                  @ title                                    
    #>   1 100 httptest  4.2.2   Neal Richardson    1y A Test Environment for HTTP Requests     
    #>   2  72 covr      3.6.4   Jim Hester         1y Test Coverage for Packages               
    #>   3  51 webfakes  1.3.1   Gábor Csárdi       9M Fake Web Apps for HTTP Testing           
    #>   4  16 testthat  3.2.2   Hadley Wickham     1M Unit Testing for R                       
    #>   5  13 psych     2.4.12  William Revelle   17d Procedures for Psychological, Psychome...
    #>   6  12 vcr       1.6.0   Scott Chamberlain  6M Record 'HTTP' Calls to Disk              
    #>   7   8 httr      1.4.7   Hadley Wickham     1y Tools for Working with URLs and HTTP     
    #>   8   7 webmockr  1.0.0   Scott Chamberlain  6M Stubbing and Setting Expectations on '...
    #>   9   6 rmarkdown 2.29    Yihui Xie          2M Dynamic Documents for R                  
    #>  10   6 knitr     1.49    Yihui Xie          2M A General-Purpose Package for Dynamic ...

### British vs American English

The search engine uses a dictionary to make sure that package metadata
and queries given in British and American English yield the same
results. E.g. note the spelling of colour/color in the results:

``` r
ps("colour")
```

    #> - "colour" ---------------------------------------------- 350 packages in 0.013 seconds -
    #>   #     package      version by                 @ title                                  
    #>   1 100 crayon       1.5.3   Gábor Csárdi      7M Colored Terminal Output                
    #>   2  66 viridis      0.6.5   Simon Garnier     1y Colorblind-Friendly Color Maps for R   
    #>   3  63 colorspace   2.1.1   Achim Zeileis     6M A Toolbox for Manipulating and Asses...
    #>   4  58 pillar       1.10.1  Kirill Müller     2d Coloured Formatting for Columns        
    #>   5  42 viridisLite  0.4.2   Simon Garnier     2y Colorblind-Friendly Color Maps (Lite...
    #>   6  40 colourpicker 1.3.0   Dean Attali       1y A Colour Picker Tool for Shiny and f...
    #>   7  31 ggnewscale   0.5.0   Elio Campitelli   6M Multiple Fill and Colour Scales in '...
    #>   8  26 shape        1.4.6.1 Karline Soetaert 11M Functions for Plotting Graphical Sha...
    #>   9  25 RColorBrewer 1.1.3   Erich Neuwirth    3y ColorBrewer Palettes                   
    #>  10  22 colorRamps   2.3.4   Gregory Jefferis 10M Builds Color Tables

``` r
ps("color")
```

    #> - "color" ----------------------------------------------- 349 packages in 0.006 seconds -
    #>   #     package      version by                 @ title                                  
    #>   1 100 crayon       1.5.3   Gábor Csárdi      7M Colored Terminal Output                
    #>   2  66 viridis      0.6.5   Simon Garnier     1y Colorblind-Friendly Color Maps for R   
    #>   3  63 colorspace   2.1.1   Achim Zeileis     6M A Toolbox for Manipulating and Asses...
    #>   4  58 pillar       1.10.1  Kirill Müller     2d Coloured Formatting for Columns        
    #>   5  42 viridisLite  0.4.2   Simon Garnier     2y Colorblind-Friendly Color Maps (Lite...
    #>   6  40 colourpicker 1.3.0   Dean Attali       1y A Colour Picker Tool for Shiny and f...
    #>   7  31 ggnewscale   0.5.0   Elio Campitelli   6M Multiple Fill and Colour Scales in '...
    #>   8  26 shape        1.4.6.1 Karline Soetaert 11M Functions for Plotting Graphical Sha...
    #>   9  25 RColorBrewer 1.1.3   Erich Neuwirth    3y ColorBrewer Palettes                   
    #>  10  22 colorRamps   2.3.4   Gregory Jefferis 10M Builds Color Tables

### Ascii Folding

Especially when searching for package maintainer names, it is convenient
to use the corresponding ASCII letters for non-ASCII characters in
search phrases. E.g. the following two queries yield the same results.
Note that case is also ignored.

``` r
ps("gabor", size = 5)
```

    #> - "gabor" ----------------------------------------------- 108 packages in 0.005 seconds -
    #>   #     package  version by              @ title                                         
    #>  1  100 cli      3.6.3   Gábor Csárdi   7M Helpers for Developing Command Line Interfaces
    #>  2   66 crayon   1.5.3   Gábor Csárdi   7M Colored Terminal Output                       
    #>  3   56 fs       1.6.5   Gábor Csárdi   2M Cross-Platform File System Operations Based...
    #>  4   56 progress 1.2.3   Gábor Csárdi   1y Terminal Progress Bars                        
    #>  5   46 zoo      1.8.12  Achim Zeileis  2y S3 Infrastructure for Regular and Irregular...

``` r
ps("Gábor", size = 5)
```

    #> - "Gábor" ----------------------------------------------- 108 packages in 0.005 seconds -
    #>   #     package  version by              @ title                                         
    #>  1  100 cli      3.6.3   Gábor Csárdi   7M Helpers for Developing Command Line Interfaces
    #>  2   66 crayon   1.5.3   Gábor Csárdi   7M Colored Terminal Output                       
    #>  3   56 fs       1.6.5   Gábor Csárdi   2M Cross-Platform File System Operations Based...
    #>  4   56 progress 1.2.3   Gábor Csárdi   1y Terminal Progress Bars                        
    #>  5   46 zoo      1.8.12  Achim Zeileis  2y S3 Infrastructure for Regular and Irregular...

## Configuration

### Options

-   `timeout`: pkgsearch follows the `timeout` options for HTTP requests
    (i.e. for `pkg_search()` and `advanced_search()`. `timeout` is the
    limit for the total time of the HTTP request, and it is in seconds.
    See `?options` for details.

## More info

See the [complete documentation](https://r-hub.github.io/pkgsearch/).

## License

MIT @ [Gábor Csárdi](https://github.com/gaborcsardi),
[RStudio](https://github.com/rstudio), [R
Consortium](https://r-consortium.org/).
