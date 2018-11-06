


# CRAN package search

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Linux Build Status](https://travis-ci.org/metacran/pkgsearch.svg?branch=master)](https://travis-ci.org/metacran/pkgsearch)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/github/metacran/pkgsearch?svg=true)](https://ci.appveyor.com/project/gaborcsardi/pkgsearch)
[![CRAN status](https://www.r-pkg.org/badges/version/pkgsearch)](https://cran.r-project.org/package=pkgsearch)
[![CRAN RStudio mirror downloads](https://cranlogs.r-pkg.org/badges/pkgsearch)](https://www.r-pkg.org/pkg/pkgsearch)
[![Coverage status](https://codecov.io/gh/metacran/pkgsearch/branch/master/graph/badge.svg)](https://codecov.io/github/metacran/pkgsearch?branch=master)

The pkgsearch package searches all CRAN packages. It uses a web service,
and a careful weighting that ranks popular packages before less
frequently used ones.

## Installation

Once released, you can install the package from CRAN:

```r
install.packages("pkgsearch")
```

## Usage

Use `pkg_search()` to search for a term or phrase:


```r
library(pkgsearch)
pkg_search("C++")
```

```
#> - "C++" ------------------------------------------------ 6080 packages in 0.005 seconds - 
#>   #     package      version  by                    @ title                              
#>   1 100 Rcpp         0.12.19  Dirk Eddelbuettel    1M Seamless R and C++ Integration     
#>   2  31 BH           1.66.0.1 Dirk Eddelbuettel    9M Boost C++ Header Files             
#>   3  13 inline       0.3.15   Dirk Eddelbuettel    6M Functions to Inline C, C++, Fort...
#>   4  12 StanHeaders  2.18.0   Ben Goodrich        30d C++ Header Files for Stan          
#>   5  10 RcppProgress 0.4.1    Karl Forner          6M An Interruptible Progress Bar wi...
#>   6  10 SnowballC    0.5.1    Milan Bouchet-Valat  4y Snowball stemmers based on the C...
#>   7   9 covr         3.2.1    Jim Hester          19d Test Coverage for Packages         
#>   8   7 glpkAPI      1.3.1    Mayo Roettger        2M R Interface to C API of GLPK       
#>   9   7 RNifti       0.10.0   Jon Clayden         18d Fast R and C++ Access to NIfTI I...
#>  10   6 xml2         1.2.0    James Hester        10M Parse XML
```

By default it returns a short summary of the ten best search hits. Their
details can be printed by using the `format = "long"` option of `pkg_search()`,
or just calling `pkg_search()` again, without any arguments, after a search:



```r
pkg_search()
```

```
#> - "C++" ------------------------------------------------ 6080 packages in 0.005 seconds - 
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
#> 2 BH @ 1.66.0.1                                           Dirk Eddelbuettel, 9 months ago 
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
#> 3 inline @ 0.3.15                                         Dirk Eddelbuettel, 6 months ago 
#> -----------------
#>   # Functions to Inline C, C++, Fortran Function Calls from R
#>   Functionality to dynamically define R functions and S4 methods with 'inlined' C, C++
#>   or Fortran code supporting the .C and .Call calling conventions.
#> 
#> 4 StanHeaders @ 2.18.0                                          Ben Goodrich, 30 days ago 
#> ----------------------
#>   # C++ Header Files for Stan
#>   The C++ header files of the Stan project are provided by this package, but it contains
#>   no R code or function documentation. There is a shared object containing part of the
#>   'CVODES' library, but it is not accessible from R. 'StanHeaders' is only useful for
#>   developers who want to utilize the 'LinkingTo' directive of their package's
#>   DESCRIPTION file to build on the Stan library without incurring unnecessary
#>   dependencies. The Stan project develops a probabilistic programming language that
#>   implements full or approximate Bayesian statistical inference via Markov Chain Monte
#>   Carlo or 'variational' methods and implements (optionally penalized) maximum
#>   likelihood estimation via optimization. The Stan library includes an advanced
#>   automatic differentiation scheme, 'templated' statistical and linear algebra functions
#>   that can handle the automatically 'differentiable' scalar types (and doubles, 'ints',
#>   etc.), and a parser for the Stan language. The 'rstan' package provides user-facing R
#>   functions to parse, compile, test, estimate, and analyze Stan models.
#>   http://mc-stan.org/
#> 
#> 5 RcppProgress @ 0.4.1                                          Karl Forner, 6 months ago 
#> ----------------------
#>   # An Interruptible Progress Bar with OpenMP Support for C++ in R Packages
#>   Allows to display a progress bar in the R console for long running computations taking
#>   place in c++ code, and support for interrupting those computations even in
#>   multithreaded code, typically using OpenMP.
#>   https://github.com/kforner/rcpp_progress
#> 
#> 6 SnowballC @ 0.5.1                                      Milan Bouchet-Valat, 4 years ago 
#> -------------------
#>   # Snowball stemmers based on the C libstemmer UTF-8 library
#>   An R interface to the C libstemmer library that implements<U+000a>Porter's word
#>   stemming algorithm for collapsing words to a common<U+000a>root to aid comparison of
#>   vocabulary. Currently supported languages are<U+000a>Danish, Dutch, English, Finnish,
#>   French, German, Hungarian, Italian,<U+000a>Norwegian, Portuguese, Romanian, Russian,
#>   Spanish, Swedish<U+000a>and Turkish.
#>   https://r-forge.r-project.org/projects/r-temis/
#> 
#> 7 covr @ 3.2.1                                                    Jim Hester, 19 days ago 
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
#> 8 glpkAPI @ 1.3.1                                             Mayo Roettger, 2 months ago 
#> -----------------
#>   # R Interface to C API of GLPK
#>   R Interface to C API of GLPK, depends on GLPK Version >= 4.42.
#> 
#> 9 RNifti @ 0.10.0                                                Jon Clayden, 18 days ago 
#> -----------------
#>   # Fast R and C++ Access to NIfTI Images
#>   Provides very fast read and write access to images stored in the NIfTI-1 and
#>   ANALYZE-7.5 formats, with seamless synchronisation between compiled C and interpreted
#>   R code. Also provides a C/C++ API that can be used by other packages. Not to be
#>   confused with 'RNiftyReg', which performs image registration.
#>   https://github.com/jonclayden/RNifti
#> 
#> 10 xml2 @ 1.2.0                                               James Hester, 10 months ago 
#> ---------------
#>   # Parse XML
#>   Work with XML files using a simple, consistent interface. Built on top of the
#>   'libxml2' C library.
#>   https://github.com/r-lib/xml2
```

The `more()` function can be used to display the next batch of search hits,
batches contain ten packages by default. `ps()` is shorter alias to
`pkg_search()`:


```r
ps("google")
```

```
#> - "google" ---------------------------------------------- 106 packages in 0.004 seconds - 
#>   #     package             version by               @ title                             
#>   1 100 googleVis           0.6.2   Markus Gesmann  2y R Interface to Google Charts      
#>   2  66 googleAuthR         0.6.3   Mark Edmondson  5M Authenticate and Create Google ...
#>   3  54 lubridate           1.7.4   Vitalie Spinu   7M Make Dealing with Dates a Littl...
#>   4  51 plotKML             0.5.8   Tomislav Hengl  1y Visualization of Spatial and Sp...
#>   5  46 googlesheets        0.3.0   Jennifer Bryan  4M Manage Google Spreadsheets from R 
#>   6  42 googledrive         0.1.2   Jennifer Bryan  1M An Interface to Google Drive      
#>   7  39 googleCloudStorageR 0.4.0   Mark Edmondson  1y Interface with Google Cloud Sto...
#>   8  36 gsheet              0.4.2   Max Conway      2y Download Google Sheets Using Ju...
#>   9  36 bigQueryR           0.4.0   Mark Edmondson  5M Interface with Google BigQuery ...
#>  10  34 googlePolylines     0.7.1   David Cooley    2M Encoding Coordinates into 'Goog...
```


```r
more()
```

```
#> - "google" ---------------------------------------------- 106 packages in 0.005 seconds - 
#>   #    package          version by                     @ title                           
#>  11 34 googleAnalyticsR 0.5.0   Mark Edmondson        9M Google Analytics API into R     
#>  12 33 ggmap            2.6.1   David Kahle           3y Spatial Visualization with gg...
#>  13 32 cld2             1.2     Jeroen Ooms           6M Google's Compact Language Det...
#>  14 27 rgoogleslides    0.3.1   Hairizuan Noorazman   2M R Interface to Google Slides    
#>  15 27 gcite            0.9.2   John Muschelli        9M Google Citation Parser          
#>  16 26 plusser          0.4.0   Christoph Waldhauser  5y A Google+ Interface for R       
#>  17 26 ganalytics       0.10.4  Johann de Boer        4M Interact with 'Google Analytics'
#>  18 26 s2               0.4.0   Ege Rubak             7M Google's S2 Library for Geome...
#>  19 25 googlePrintr     0.0.1   Carl Ganz             9M Connect to 'Google Cloud Prin...
#>  20 25 adwordsR         0.3.1   Sean Longthorpe       5M Access the 'Google Adwords' API
```

## Features

In addition to simple text matching the search server and client have
many improvements to deliver better results.

### Stemming

The search server uses the stems of the words in the indexed metadata, and
the search phrase. This means that "colour" and "colours" deliver the
exact same result. So do "coloring", "colored", etc. (Unless one is happen
to be an exact package name or match another non-stemmed field.)


```r
ps("colour", size = 3)
```

```
#> - "colour" ---------------------------------------------- 164 packages in 0.004 seconds - 
#>   #     package    version by              @ title                               
#>  1  100 colorspace 1.3.2   Achim Zeileis  2y Color Space Manipulation            
#>  2   86 crayon     1.3.4   Gábor Csárdi   1y Colored Terminal Output             
#>  3   67 viridis    0.5.1   Simon Garnier  7M Default Color Maps from 'matplotlib'
```

```r
ps("colours", size = 3)
```

```
#> - "colours" --------------------------------------------- 162 packages in 0.005 seconds - 
#>   #     package    version by              @ title                               
#>  1  100 colorspace 1.3.2   Achim Zeileis  2y Color Space Manipulation            
#>  2   86 crayon     1.3.4   Gábor Csárdi   1y Colored Terminal Output             
#>  3   67 viridis    0.5.1   Simon Garnier  7M Default Color Maps from 'matplotlib'
```

### Ranking

The most important feature of a search engine is the ranking of the results.
The best results should be listed first. pkgsearch uses weighted scoring,
where a match in the package title gets a higher score than a match in the
package desciption. It also uses the number of reverse dependencies and
the number of downloads to weight the scores:


```r
ps("colour")[, c("score", "package", "revdeps", "downloads_last_month")]
```

```
#> # A tibble: 10 x 4
#>     score package      revdeps downloads_last_month
#>     <dbl> <chr>          <int>                <int>
#>  1 10785. colorspace       134               373346
#>  2  9293. crayon           104               500169
#>  3  7247. viridis           79               172186
#>  4  4938. shape             35                13223
#>  5  3999. colourpicker      14                15400
#>  6  3864. viridisLite       28               366798
#>  7  3848. pillar            16               541280
#>  8  3522. RColorBrewer     383               390994
#>  9  3191. dichromat         11                21658
#> 10  2946. colorRamps        10                 3883
```

### Preferring Phrases

The search engine prefers matching whole phrases over single words.
E.g. the search phrase "permutation test" will rank coin higher than
testthat, even though testthat is a much better result for the single word
"test". (In fact, at the time of writing testhat is not even on the first
page of results.)


```r
ps("permutation test")
```

```
#> - "permutation test" ----------------------------------- 1539 packages in 0.015 seconds - 
#>   #     package        version by                      @ title                           
#>   1 100 coin           1.2.2   Torsten Hothorn        1y Conditional Inference Procedu...
#>   2  35 flip           2.5.0   Livio Finos            2M Multivariate Permutation Tests  
#>   3  32 perm           1.0.0.0 Michael Fay            8y Exact or Asymptotic permutati...
#>   4  22 exactRankTests 0.8.29  Torsten Hothorn        2y Exact Distributions for Rank ...
#>   5  22 wPerm          1.0.1   Neil A. Weiss          3y Permutation Tests               
#>   6  19 cpt            1.0.2   Johann Gagnon-Bartsch  7d Classification Permutation Test 
#>   7  19 AUtests        0.98    Arjun Sondhi           2y Approximate Unconditional and...
#>   8  19 jmuOutlier     1.4     Steven T. Garren       9M Permutation Tests for Nonpara...
#>   9  18 permutes       0.1     Cesko Voeten           6M Permutation Tests for Time Se...
#>  10  18 GlobalDeviance 0.4     Frederike Fuhlbrueck   5y Global Deviance Permutation T...
```

If the whole phrase does not match, pkgsearch falls back to individual
matching words. For example, a match from either words is enough here,
to get on the fist page of results:


```r
ps("test http")
```

```
#> - "test http" ------------------------------------------- 5035 packages in 0.01 seconds - 
#>   #     package   version   by                   @ title                                 
#>   1 100 httptest  3.1.0     Neal Richardson     5M A Test Environment for HTTP Requests  
#>   2  88 covr      3.2.1     Jim Hester         19d Test Coverage for Packages            
#>   3  39 testthat  2.0.1     Hadley Wickham     24d Unit Testing for R                    
#>   4  19 psych     1.8.10    William Revelle     6d Procedures for Psychological, Psych...
#>   5  12 vcr       0.2.0     Scott Chamberlain  18d Record 'HTTP' Calls to Disk           
#>   6  12 httr      1.3.1     Hadley Wickham      1y Tools for Working with URLs and HTTP  
#>   7   9 RCurl     1.95.4.11 Duncan Temple Lang  4M General Network (HTTP/FTP/...) Clie...
#>   8   8 bnlearn   4.4       Marco Scutari      21d Bayesian Network Structure Learning...
#>   9   7 oompaBase 3.2.6     Kevin R. Coombes    6M Class Unions, Matrix Operations, an...
#>  10   7 pipeGS    0.4       Hera He             9M Permutation p-Value Estimation for ...
```

### British vs American English

The seach engine uses a dictionary to make sure that package metadata
and queries given in British and American English yield the same results.
E.g. note the spelling of colour/color in the results:


```r
ps("colour")
```

```
#> - "colour" ---------------------------------------------- 164 packages in 0.005 seconds - 
#>   #     package      version by                 @ title                                  
#>   1 100 colorspace   1.3.2   Achim Zeileis     2y Color Space Manipulation               
#>   2  86 crayon       1.3.4   Gábor Csárdi      1y Colored Terminal Output                
#>   3  67 viridis      0.5.1   Simon Garnier     7M Default Color Maps from 'matplotlib'   
#>   4  46 shape        1.4.4   Karline Soetaert  9M Functions for Plotting Graphical Sha...
#>   5  37 colourpicker 1.0     Dean Attali       1y A Colour Picker Tool for Shiny and f...
#>   6  36 viridisLite  0.3.0   Simon Garnier     9M Default Color Maps from 'matplotlib'...
#>   7  36 pillar       1.3.0   Kirill Müller     4M Coloured Formatting for Columns        
#>   8  33 RColorBrewer 1.1.2   Erich Neuwirth    4y ColorBrewer Palettes                   
#>   9  30 dichromat    2.0.0   Thomas Lumley     6y Color Schemes for Dichromats           
#>  10  27 colorRamps   2.3     Tim Keitt         6y Builds color tables
```

```r
ps("color")
```

```
#> - "color" ----------------------------------------------- 162 packages in 0.004 seconds - 
#>   #     package      version by                 @ title                                  
#>   1 100 colorspace   1.3.2   Achim Zeileis     2y Color Space Manipulation               
#>   2  86 crayon       1.3.4   Gábor Csárdi      1y Colored Terminal Output                
#>   3  67 viridis      0.5.1   Simon Garnier     7M Default Color Maps from 'matplotlib'   
#>   4  46 shape        1.4.4   Karline Soetaert  9M Functions for Plotting Graphical Sha...
#>   5  37 colourpicker 1.0     Dean Attali       1y A Colour Picker Tool for Shiny and f...
#>   6  36 viridisLite  0.3.0   Simon Garnier     9M Default Color Maps from 'matplotlib'...
#>   7  36 pillar       1.3.0   Kirill Müller     4M Coloured Formatting for Columns        
#>   8  33 RColorBrewer 1.1.2   Erich Neuwirth    4y ColorBrewer Palettes                   
#>   9  30 dichromat    2.0.0   Thomas Lumley     6y Color Schemes for Dichromats           
#>  10  27 colorRamps   2.3     Tim Keitt         6y Builds color tables
```

### Ascii Folding

Especially when searching for package maintainer names, it is convenient
to use the corresponding ASCII letters for non-ASCII characters in search
phrases. E.g. the following two queries yield the same results. Note that
case is also ignored.


```r
ps("gabor", size = 5)
```

```
#> - "gabor" ------------------------------------------------ 79 packages in 0.005 seconds - 
#>   #     package  version by              @ title                                         
#>  1  100 igraph   1.2.2   Gábor Csárdi   3M Network Analysis and Visualization            
#>  2   47 crayon   1.3.4   Gábor Csárdi   1y Colored Terminal Output                       
#>  3   38 zoo      1.8.4   Achim Zeileis  2M S3 Infrastructure for Regular and Irregular...
#>  4   33 progress 1.2.0   Gábor Csárdi   5M Terminal Progress Bars                        
#>  5   28 cli      1.0.1   Gábor Csárdi   1M Helpers for Developing Command Line Interfaces
```

```r
ps("Gábor", size = 5)
```

```
#> - "Gábor" ------------------------------------------------ 79 packages in 0.007 seconds - 
#>   #     package  version by              @ title                                         
#>  1  100 igraph   1.2.2   Gábor Csárdi   3M Network Analysis and Visualization            
#>  2   47 crayon   1.3.4   Gábor Csárdi   1y Colored Terminal Output                       
#>  3   38 zoo      1.8.4   Achim Zeileis  2M S3 Infrastructure for Regular and Irregular...
#>  4   33 progress 1.2.0   Gábor Csárdi   5M Terminal Progress Bars                        
#>  5   28 cli      1.0.1   Gábor Csárdi   1M Helpers for Developing Command Line Interfaces
```

## License

MIT @ [Gábor Csárdi](https://github.com/gaborcsardi),
      [RStudio](https://github.com/rstudio)
