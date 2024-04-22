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

    #> - "permutation test" ----------------------------------- 2545 packages in 0.525 seconds -
    #>   #     package    version by                      @ title                               
    #>   1 100 coin       1.4.3   Torsten Hothorn        7M Conditional Inference Procedures ...
    #>   2  29 wPerm      1.0.1   Neil A. Weiss          8y Permutation Tests                   
    #>   3  27 flip       2.5.0   Livio Finos            6y Multivariate Permutation Tests      
    #>   4  27 cpt        1.0.2   Johann Gagnon-Bartsch  5y Classification Permutation Test     
    #>   5  25 jmuOutlier 2.2     Steven T. Garren       5y Permutation Tests for Nonparametr...
    #>   6  25 lmPerm     2.1.0   Marco Torchiano        8y Permutation Tests for Linear Models 
    #>   7  25 perm       1.0.0.4 Michael P. Fay         8M Exact or Asymptotic Permutation T...
    #>   8  25 AUtests    0.99    Arjun Sondhi           4y Approximate Unconditional and Per...
    #>   9  24 peramo     0.1.3   Duy Nghia Pham        11M Permutation Tests for Randomizati...
    #>  10  24 nptest     1.1     Nathaniel E. Helwig    1y Nonparametric Bootstrap and Permu...

pkgsearch uses an [R-hub](https://docs.r-hub.io) web service and a
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

    #> # A data frame: 46 × 29
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
    #> # ℹ 36 more rows
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
    #>    package       score                 
    #>    <chr>         <chr>                 
    #>  1 phonfieldwork 12003.3660589060308600
    #>  2 piggyback     3533.5488580665345700 
    #>  3 bqror         2539.1373169766521600 
    #>  4 optigrab      2488.5245901639344300 
    #>  5 neuralGAM     2316.0993560257589700 
    #>  6 fido          1384.4350374470856400 
    #>  7 PKI           1086.1091255658803900 
    #>  8 gtExtras      937.5656399404342000  
    #>  9 toastui       830.0050684237202200  
    #> 10 EcoDiet       829.2880258899676400  
    #> # ℹ 90 more rows

``` r
cran_top_downloaded()
```

    #> # A data frame: 100 × 2
    #>    package   count 
    #>    <chr>     <chr> 
    #>  1 ggplot2   402253
    #>  2 rlang     388952
    #>  3 lifecycle 365594
    #>  4 dplyr     357313
    #>  5 cli       347970
    #>  6 vctrs     342368
    #>  7 jsonlite  296204
    #>  8 tibble    291159
    #>  9 Rcpp      289254
    #> 10 glue      285878
    #> # ℹ 90 more rows

### Keep up with CRAN

Are you curious about the latest releases or archivals?

``` r
cran_events()
```

    #> CRAN events (events)---------------------------------------------------------------------
    #>  . When     Package      Version Title                                                   
    #>  + 4 hours  LipidomicsR  0.3.6   Elegant Tools for Processing and Visualization of Lip...
    #>  + 4 hours  fabletools   0.4.2   Core Tools for Packages in the 'fable' Framework        
    #>  + 5 hours  ripc         0.3.0   Download and Tidy IPC and CH Data                       
    #>  + 6 hours  acled.api    1.1.8   Automated Retrieval of ACLED Conflict Event Data        
    #>  + 6 hours  memoiR       1.2-9   R Markdown and Bookdown Templates to Publish Document...
    #>  + 7 hours  SAiVE        1.0.5   Functions Used for SAiVE Group Research, Collaboratio...
    #>  + 7 hours  colorscience 1.0.9   Color Science Methods and Data                          
    #>  + 7 hours  ieugwasr     1.0.0   Interface to the 'OpenGWAS' Database API                
    #>  + 7 hours  rococo       1.1.8   Robust Rank Correlation Coefficient and Test            
    #>  + 10 hours BMRMM        1.0.1   An Implementation of the Bayesian Markov (Renewal) Mi...

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

    #> - "C++" ----------------------------------------------- 10000 packages in 0.304 seconds -
    #>   #     package      version  by                       @ title                           
    #>   1 100 Rcpp         1.0.12   Dirk Eddelbuettel       3M Seamless R and C++ Integration  
    #>   2  30 BH           1.84.0.0 Dirk Eddelbuettel       3M Boost C++ Header Files          
    #>   3  19 inline       0.3.19   Dirk Eddelbuettel       3y Functions to Inline C, C++, F...
    #>   4  14 SnowballC    0.7.1    Milan Bouchet-Valat     1y Snowball Stemmers Based on th...
    #>   5  12 glpkAPI      1.3.4    Mihail Anton            1y R Interface to C API of GLPK    
    #>   6  10 RcppProgress 0.4.2    Karl Forner             4y An Interruptible Progress Bar...
    #>   7   9 getopt       1.20.4   Trevor L Davis          7M C-Like 'getopt' Behavior        
    #>   8   8 boot         1.3.30   Alessandra R. Brazzale  2M Bootstrap Functions (Original...
    #>   9   8 LiblineaR    2.10.23  Thibault Helleputte     4M Linear Predictive Models Base...
    #>  10   7 lme4         1.1.35.3 Ben Bolker              6d Linear Mixed-Effects Models u...

``` r
pkg_search()
```

    #> - "C++" ----------------------------------------------- 10000 packages in 0.304 seconds -
    #> 
    #> 1 Rcpp @ 1.0.12                                           Dirk Eddelbuettel, 3 months ago
    #> ---------------
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
    #> 2 BH @ 1.84.0.0                                           Dirk Eddelbuettel, 3 months ago
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
    #> 3 inline @ 0.3.19                                          Dirk Eddelbuettel, 3 years ago
    #> -----------------
    #>   # Functions to Inline C, C++, Fortran Function Calls from R
    #>   Functionality to dynamically define R functions and S4 methods with 'inlined'
    #>   C, C++ or Fortran code supporting the .C and .Call calling conventions.
    #>   https://github.com/eddelbuettel/inline
    #>   https://dirk.eddelbuettel.com/code/inline.html
    #> 
    #> 4 SnowballC @ 0.7.1                                 Milan Bouchet-Valat, about a year ago
    #> -------------------
    #>   # Snowball Stemmers Based on the C 'libstemmer' UTF-8 Library
    #>   An R interface to the C 'libstemmer' library that implements Porter's word
    #>   stemming algorithm for collapsing words to a common root to aid comparison of
    #>   vocabulary. Currently supported languages are Arabic, Basque, Catalan, Danish,
    #>   Dutch, English, Finnish, French, German, Greek, Hindi, Hungarian, Indonesian,
    #>   Irish, Italian, Lithuanian, Nepali, Norwegian, Portuguese, Romanian, Russian,
    #>   Spanish, Swedish, Tamil and Turkish.
    #>   https://github.com/nalimilan/R.TeMiS
    #> 
    #> 5 glpkAPI @ 1.3.4                                          Mihail Anton, about a year ago
    #> -----------------
    #>   # R Interface to C API of GLPK
    #>   R Interface to C API of GLPK, depends on GLPK Version >= 4.42.
    #> 
    #> 6 RcppProgress @ 0.4.2                                           Karl Forner, 4 years ago
    #> ----------------------
    #>   # An Interruptible Progress Bar with OpenMP Support for C++ in R Packages
    #>   Allows to display a progress bar in the R console for long running
    #>   computations taking place in c++ code, and support for interrupting those
    #>   computations even in multithreaded code, typically using OpenMP.
    #>   https://github.com/kforner/rcpp_progress
    #> 
    #> 7 getopt @ 1.20.4                                            Trevor L Davis, 7 months ago
    #> -----------------
    #>   # C-Like 'getopt' Behavior
    #>   Package designed to be used with Rscript to write '#!' shebang scripts that
    #>   accept short and long flags/options. Many users will prefer using instead the
    #>   packages optparse or argparse which add extra features like automatically
    #>   generated help option and usage, support for default values, positional
    #>   argument support, etc.
    #>   https://github.com/trevorld/r-getopt
    #> 
    #> 8 boot @ 1.3.30                                      Alessandra R. Brazzale, 2 months ago
    #> ---------------
    #>   # Bootstrap Functions (Originally by Angelo Canty for S)
    #>   Functions and datasets for bootstrapping from the book "Bootstrap Methods and
    #>   Their Application" by A. C. Davison and D. V. Hinkley (1997, CUP), originally
    #>   written by Angelo Canty for S.
    #> 
    #> 9 LiblineaR @ 2.10.23                                   Thibault Helleputte, 4 months ago
    #> ---------------------
    #>   # Linear Predictive Models Based on the LIBLINEAR C/C++ Library
    #>   A wrapper around the LIBLINEAR C/C++ library for machine learning (available
    #>   at <https://www.csie.ntu.edu.tw/~cjlin/liblinear/>). LIBLINEAR is a simple
    #>   library for solving large-scale regularized linear classification and
    #>   regression. It currently supports L2-regularized classification (such as
    #>   logistic regression, L2-loss linear SVM and L1-loss linear SVM) as well as
    #>   L1-regularized classification (such as L2-loss linear SVM and logistic
    #>   regression) and L2-regularized support vector regression (with L1- or
    #>   L2-loss). The main features of LiblineaR include multi-class classification
    #>   (one-vs-the rest, and Crammer & Singer method), cross validation for model
    #>   selection, probability estimates (logistic regression only) or weights for
    #>   unbalanced data. The estimation of the models is particularly fast as compared
    #>   to other libraries.
    #>   <https://dnalytics.com/software/liblinear/>
    #> 
    #> 10 lme4 @ 1.1.35.3                                                 Ben Bolker, 6 days ago
    #> ------------------
    #>   # Linear Mixed-Effects Models using 'Eigen' and S4
    #>   Fit linear and generalized linear mixed-effects models. The models and their
    #>   components are represented using S4 classes and methods.  The core
    #>   computational algorithms are implemented using the 'Eigen' C++ library for
    #>   numerical linear algebra and 'RcppEigen' "glue".
    #>   https://github.com/lme4/lme4/

### Pagination

The `more()` function can be used to display the next batch of search
hits, batches contain ten packages by default. `ps()` is a shorter alias
to `pkg_search()`:

``` r
ps("google")
```

    #> - "google" ---------------------------------------------- 171 packages in 0.034 seconds -
    #>   #     package          version by                     @ title                          
    #>   1 100 googleVis        0.7.1   Markus Gesmann        1y R Interface to Google Charts   
    #>   2  44 bigQueryR        0.5.0   Mark Edmondson        5y Interface with Google BigQue...
    #>   3  40 googletraffic    0.1.5   Robert Marty          3M Google Traffic                 
    #>   4  40 rgoogleclassroom 0.9.1   Candace Savonen       9M API Wrapper for Google Class...
    #>   5  36 googledrive      2.1.1   Jennifer Bryan       11M An Interface to Google Drive   
    #>   6  36 gcite            0.10.1  John Muschelli        5y Google Citation Parser         
    #>   7  36 plusser          0.4.0   Christoph Waldhauser 10y A Google+ Interface for R      
    #>   8  36 ganalytics       0.10.7  Johann de Boer        5y Interact with 'Google Analyt...
    #>   9  36 pluscode         0.1.0   Michael Doyle         5y Encoder for Google 'Pluscodes' 
    #>  10  34 gargle           1.5.2   Jennifer Bryan        9M Utilities for Working with G...

``` r
more()
```

    #> - "google" ---------------------------------------------- 171 packages in 0.051 seconds -
    #>   #    package          version by                    @ title                            
    #>  11 33 r4googleads      0.1.1   Johannes Burkhardt   2y 'Google Ads API' Interface       
    #>  12 33 adwordsR         0.3.1   Sean Longthorpe      6y Access the 'Google Adwords' API  
    #>  13 33 rgoogleslides    0.3.2   Hairizuan Noorazman  4y R Interface to Google Slides     
    #>  14 33 sparkbq          0.1.1   Martin Studer        4y Google 'BigQuery' Support for ...
    #>  15 33 bigrquery        1.5.1   Hadley Wickham       1M An Interface to Google's 'BigQ...
    #>  16 33 googleAuthR      2.0.1   Mark Edmondson       1y Authenticate and Create Google...
    #>  17 33 googlePolylines  0.8.4   David Cooley         8M Encoding Coordinates into 'Goo...
    #>  18 33 googleAnalyticsR 1.1.0   Mark Edmondson       2y Google Analytics API into R      
    #>  19 33 googler          0.0.1   Michael W. Kearney   5y Google from the R Console        
    #>  20 31 bigrquerystorage 1.1.0   Bruno Tremblay      19d An Interface to Google's 'BigQ...

### Stemming

The search server uses the stems of the words in the indexed metadata,
and the search phrase. This means that “colour” and “colours” deliver
the exact same result. So do “coloring”, “colored”, etc. (Unless one is
happen to be an exact package name or match another non-stemmed field.)

``` r
ps("colour", size = 3)
```

    #> - "colour" ---------------------------------------------- 329 packages in 0.021 seconds -
    #>   #     package    version by                 @ title                                    
    #>  1  100 colorspace 2.1.0   Achim Zeileis     1y A Toolbox for Manipulating and Assessi...
    #>  2   51 shape      1.4.6.1 Karline Soetaert  2M Functions for Plotting Graphical Shape...
    #>  3   37 dichromat  2.0.0.1 Thomas Lumley     2y Color Schemes for Dichromats

``` r
ps("colours", size = 3)
```

    #> - "colours" --------------------------------------------- 327 packages in 0.018 seconds -
    #>   #     package    version by                 @ title                                    
    #>  1  100 colorspace 2.1.0   Achim Zeileis     1y A Toolbox for Manipulating and Assessi...
    #>  2   51 shape      1.4.6.1 Karline Soetaert  2M Functions for Plotting Graphical Shape...
    #>  3   37 dichromat  2.0.0.1 Thomas Lumley     2y Color Schemes for Dichromats

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
    #>    score package      revdeps downloads_last_month
    #>    <dbl> <chr>          <int>                <int>
    #>  1 6717. colorspace        71                    1
    #>  2 3442. shape             19                    1
    #>  3 2490. dichromat          7                    1
    #>  4 2110. RColorBrewer     130                    1
    #>  5 1632. crayon             3                    1
    #>  6 1631. colorRamps         3                    1
    #>  7 1546. colorizer          1                    1
    #>  8 1496. munsell            3                    1
    #>  9 1463. colouR             1                    1
    #> 10 1457. plotrix           62                    1

### Preferring Phrases

The search engine prefers matching whole phrases over single words. E.g.
the search phrase “permutation test” will rank coin higher than
testthat, even though testthat is a much better result for the single
word “test”. (In fact, at the time of writing testthat is not even on
the first page of results.)

``` r
ps("permutation test")
```

    #> - "permutation test" ----------------------------------- 2545 packages in 0.048 seconds -
    #>   #     package    version by                      @ title                               
    #>   1 100 coin       1.4.3   Torsten Hothorn        7M Conditional Inference Procedures ...
    #>   2  29 wPerm      1.0.1   Neil A. Weiss          8y Permutation Tests                   
    #>   3  27 flip       2.5.0   Livio Finos            6y Multivariate Permutation Tests      
    #>   4  27 cpt        1.0.2   Johann Gagnon-Bartsch  5y Classification Permutation Test     
    #>   5  25 jmuOutlier 2.2     Steven T. Garren       5y Permutation Tests for Nonparametr...
    #>   6  25 lmPerm     2.1.0   Marco Torchiano        8y Permutation Tests for Linear Models 
    #>   7  25 perm       1.0.0.4 Michael P. Fay         8M Exact or Asymptotic Permutation T...
    #>   8  25 AUtests    0.99    Arjun Sondhi           4y Approximate Unconditional and Per...
    #>   9  24 peramo     0.1.3   Duy Nghia Pham        11M Permutation Tests for Randomizati...
    #>  10  24 nptest     1.1     Nathaniel E. Helwig    1y Nonparametric Bootstrap and Permu...

If the whole phrase does not match, pkgsearch falls back to individual
matching words. For example, a match from either words is enough here,
to get on the first page of results:

``` r
ps("test http")
```

    #> - "test http" ------------------------------------------ 7037 packages in 0.182 seconds -
    #>   #     package  version    by                  @ title                                  
    #>   1 100 httptest 4.2.2      Neal Richardson    3M A Test Environment for HTTP Requests   
    #>   2  92 webfakes 1.3.0      Gábor Csárdi       4M Fake Web Apps for HTTP Testing         
    #>   3  42 psych    2.4.3      William Revelle    1M Procedures for Psychological, Psycho...
    #>   4  29 testthat 3.2.1.1    Hadley Wickham     9d Unit Testing for R                     
    #>   5  23 pipeGS   0.4        Hera He            6y Permutation p-Value Estimation for G...
    #>   6  19 RCurl    1.98.1.14  CRAN Team          3M General Network (HTTP/FTP/...) Clien...
    #>   7  16 httr     1.4.7      Hadley Wickham     8M Tools for Working with URLs and HTTP   
    #>   8  16 tseries  0.10.55    Kurt Hornik        5M Time Series Analysis and Computation...
    #>   9  15 MASS     7.3.60.0.1 Brian Ripley       3M Support Functions and Datasets for V...
    #>  10  14 webmockr 0.9.0      Scott Chamberlain  1y Stubbing and Setting Expectations on...

### British vs American English

The search engine uses a dictionary to make sure that package metadata
and queries given in British and American English yield the same
results. E.g. note the spelling of colour/color in the results:

``` r
ps("colour")
```

    #> - "colour" ---------------------------------------------- 329 packages in 0.472 seconds -
    #>   #     package      version by                  @ title                                 
    #>   1 100 colorspace   2.1.0   Achim Zeileis      1y A Toolbox for Manipulating and Asse...
    #>   2  51 shape        1.4.6.1 Karline Soetaert   2M Functions for Plotting Graphical Sh...
    #>   3  37 dichromat    2.0.0.1 Thomas Lumley      2y Color Schemes for Dichromats          
    #>   4  31 RColorBrewer 1.1.3   Erich Neuwirth     2y ColorBrewer Palettes                  
    #>   5  24 crayon       1.5.2   Gábor Csárdi       2y Colored Terminal Output               
    #>   6  24 colorRamps   2.3.4   Gregory Jefferis   2M Builds Color Tables                   
    #>   7  23 colorizer    0.1.0   David Zumbach      3y Colorize Old Images Using the 'DeOl...
    #>   8  22 munsell      0.5.1   Charlotte Wickham 21d Utilities for Using Munsell Colours   
    #>   9  22 colouR       0.1.1   Alan Inglis        7M Create Colour Palettes from Images    
    #>  10  22 plotrix      3.8.4   Duncan Murdoch     5M Various Plotting Functions

``` r
ps("color")
```

    #> - "color" ----------------------------------------------- 328 packages in 0.028 seconds -
    #>   #     package      version by                  @ title                                 
    #>   1 100 colorspace   2.1.0   Achim Zeileis      1y A Toolbox for Manipulating and Asse...
    #>   2  51 shape        1.4.6.1 Karline Soetaert   2M Functions for Plotting Graphical Sh...
    #>   3  37 dichromat    2.0.0.1 Thomas Lumley      2y Color Schemes for Dichromats          
    #>   4  31 RColorBrewer 1.1.3   Erich Neuwirth     2y ColorBrewer Palettes                  
    #>   5  24 crayon       1.5.2   Gábor Csárdi       2y Colored Terminal Output               
    #>   6  24 colorRamps   2.3.4   Gregory Jefferis   2M Builds Color Tables                   
    #>   7  23 colorizer    0.1.0   David Zumbach      3y Colorize Old Images Using the 'DeOl...
    #>   8  22 munsell      0.5.1   Charlotte Wickham 21d Utilities for Using Munsell Colours   
    #>   9  22 plotrix      3.8.4   Duncan Murdoch     5M Various Plotting Functions            
    #>  10  22 colouR       0.1.1   Alan Inglis        7M Create Colour Palettes from Images

### Ascii Folding

Especially when searching for package maintainer names, it is convenient
to use the corresponding ASCII letters for non-ASCII characters in
search phrases. E.g. the following two queries yield the same results.
Note that case is also ignored.

``` r
ps("gabor", size = 5)
```

    #> - "gabor" ----------------------------------------------- 105 packages in 0.017 seconds -
    #>   #     package  version by               @ title                                        
    #>  1  100 zoo      1.8.12  Achim Zeileis   1y S3 Infrastructure for Regular and Irregula...
    #>  2   73 lpSolve  5.6.20  Gábor Csárdi    4M Interface to 'Lp_solve' v. 5.5 to Solve Li...
    #>  3   61 roxygen2 7.3.1   Hadley Wickham  3M In-Line Documentation for R                  
    #>  4   59 rgl      1.3.1   Duncan Murdoch  2M 3D Visualization Using OpenGL                
    #>  5   58 igraph   2.0.3   Kirill Müller   1M Network Analysis and Visualization

``` r
ps("Gábor", size = 5)
```

    #> - "Gábor" ----------------------------------------------- 105 packages in 0.013 seconds -
    #>   #     package  version by               @ title                                        
    #>  1  100 zoo      1.8.12  Achim Zeileis   1y S3 Infrastructure for Regular and Irregula...
    #>  2   73 lpSolve  5.6.20  Gábor Csárdi    4M Interface to 'Lp_solve' v. 5.5 to Solve Li...
    #>  3   61 roxygen2 7.3.1   Hadley Wickham  3M In-Line Documentation for R                  
    #>  4   59 rgl      1.3.1   Duncan Murdoch  2M 3D Visualization Using OpenGL                
    #>  5   58 igraph   2.0.3   Kirill Müller   1M Network Analysis and Visualization

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
Consortium](https://www.r-consortium.org/).
