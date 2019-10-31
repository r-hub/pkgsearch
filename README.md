
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Search and Query CRAN R Packages

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Linux Build
Status](https://travis-ci.org/r-hub/pkgsearch.svg?branch=master)](https://travis-ci.org/r-hub/pkgsearch)
[![Windows Build
status](https://ci.appveyor.com/api/projects/status/github/r-hub/pkgsearch?svg=true)](https://ci.appveyor.com/project/gaborcsardi/pkgsearch)
[![CRAN
status](https://www.r-pkg.org/badges/version/pkgsearch)](https://cran.r-project.org/package=pkgsearch)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/pkgsearch)](https://www.r-pkg.org/pkg/pkgsearch)
[![Coverage
status](https://codecov.io/gh/r-hub/pkgsearch/branch/master/graph/badge.svg)](https://codecov.io/github/r-hub/pkgsearch?branch=master)
<!-- badges: end -->

The pkgsearch package searches all CRAN packages. It uses a web service,
and a careful weighting that ranks popular packages before less
frequently used ones. The package also has functions to list the new /
most recently updated / archived packages, and list all versions of a
package.

In this README, read about how `pkgsearch` supports

  - [search over all CRAN
    packages](#search-cran-packages-with-pkgsearch), e.g. by keyword
    (“colour”, “GLM”, etc.);

  - [extraction of CRAN information](#get-cran-metadata), e.g. releases
    and archivals.

## Installation

You can install the package from CRAN:

``` r
install.packages("pkgsearch")
```

## Search CRAN packages with pkgsearch

For search of CRAN packages, pkgsearch uses a [web
service](https://github.com/metacran/search), and a careful weighting
that ranks popular packages before less frequently used ones.

Use `pkg_search()` to search for a term or phrase:

``` r
library(pkgsearch)
pkg_search("C++")
```

    #> - "C++" ------------------------------------------------ 6973 packages in 0.007 seconds - 
    #>   #     package      version  by                    @ title                              
    #>   1 100 Rcpp         1.0.1    Dirk Eddelbuettel    2M Seamless R and C++ Integration     
    #>   2  31 BH           1.69.0.1 Dirk Eddelbuettel    4M Boost C++ Header Files             
    #>   3  13 StanHeaders  2.18.1   Ben Goodrich         4M C++ Header Files for Stan          
    #>   4  12 inline       0.3.15   Dirk Eddelbuettel    1y Functions to Inline C, C++, Fort...
    #>   5  11 SnowballC    0.6.0    Milan Bouchet-Valat  4M Snowball Stemmers Based on the C...
    #>   6  10 RcppProgress 0.4.1    Karl Forner          1y An Interruptible Progress Bar wi...
    #>   7  10 covr         3.2.1    Jim Hester           7M Test Coverage for Packages         
    #>   8   7 RNifti       0.10.0   Jon Clayden          7M Fast R and C++ Access to NIfTI I...
    #>   9   7 glpkAPI      1.3.1    Mayo Roettger        8M R Interface to C API of GLPK       
    #>  10   6 xml2         1.2.0    James Hester         1y Parse XML

By default it returns a short summary of the ten best search hits. Their
details can be printed by using the `format = "long"` option of
`pkg_search()`, or just calling `pkg_search()` again, without any
arguments, after a
    search:

``` r
pkg_search()
```

    #> - "C++" ------------------------------------------------ 6973 packages in 0.007 seconds - 
    #> 
    #> 1 Rcpp @ 1.0.1                                            Dirk Eddelbuettel, 2 months ago 
    #> --------------
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
    #> 2 BH @ 1.69.0.1                                           Dirk Eddelbuettel, 4 months ago 
    #> ---------------
    #>   # Boost C++ Header Files
    #>   Boost provides free peer-reviewed portable C++ source libraries.  A large part of
    #>   Boost is provided as C++ template code which is resolved entirely at compile-time
    #>   without linking.  This package aims to provide the most useful subset of Boost
    #>   libraries for template use among CRAN package. By placing these libraries in this
    #>   package, we offer a more efficient distribution system for CRAN as replication of this
    #>   code in the sources of other packages is avoided. As of release 1.69.0-1, the
    #>   following Boost libraries are included: 'algorithm' 'align' 'any' 'atomic' 'bimap'
    #>   'bind' 'circular_buffer' 'compute' 'concept' 'config' 'container' 'date_time' 'detail'
    #>   'dynamic_bitset' 'exception' 'filesystem' 'flyweight' 'foreach' 'functional' 'fusion'
    #>   'geometry' 'graph' 'heap' 'icl' 'integer' 'interprocess' 'intrusive' 'io' 'iostreams'
    #>   'iterator' 'math' 'move' 'mpl' 'multiprcecision' 'numeric' 'pending' 'phoenix'
    #>   'preprocessor' 'propery_tree' 'random' 'range' 'scope_exit' 'smart_ptr' 'sort'
    #>   'spirit' 'tuple' 'type_traits' 'typeof' 'unordered' 'utility' 'uuid'.
    #> 
    #> 3 StanHeaders @ 2.18.1                                         Ben Goodrich, 4 months ago 
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
    #> 4 inline @ 0.3.15                                     Dirk Eddelbuettel, about a year ago 
    #> -----------------
    #>   # Functions to Inline C, C++, Fortran Function Calls from R
    #>   Functionality to dynamically define R functions and S4 methods with 'inlined' C, C++
    #>   or Fortran code supporting the .C and .Call calling conventions.
    #> 
    #> 5 SnowballC @ 0.6.0                                     Milan Bouchet-Valat, 4 months ago 
    #> -------------------
    #>   # Snowball Stemmers Based on the C 'libstemmer' UTF-8 Library
    #>   An R interface to the C 'libstemmer' library that implements Porter's word stemming
    #>   algorithm for collapsing words to a common root to aid comparison of vocabulary.
    #>   Currently supported languages are Danish, Dutch, English, Finnish, French, German,
    #>   Hungarian, Italian, Norwegian, Portuguese, Romanian, Russian, Spanish, Swedish and
    #>   Turkish.
    #>   https://r-forge.r-project.org/projects/r-temis/
    #> 
    #> 6 RcppProgress @ 0.4.1                                      Karl Forner, about a year ago 
    #> ----------------------
    #>   # An Interruptible Progress Bar with OpenMP Support for C++ in R Packages
    #>   Allows to display a progress bar in the R console for long running computations taking
    #>   place in c++ code, and support for interrupting those computations even in
    #>   multithreaded code, typically using OpenMP.
    #>   https://github.com/kforner/rcpp_progress
    #> 
    #> 7 covr @ 3.2.1                                                   Jim Hester, 7 months ago 
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
    #> 8 RNifti @ 0.10.0                                               Jon Clayden, 7 months ago 
    #> -----------------
    #>   # Fast R and C++ Access to NIfTI Images
    #>   Provides very fast read and write access to images stored in the NIfTI-1 and
    #>   ANALYZE-7.5 formats, with seamless synchronisation between compiled C and interpreted
    #>   R code. Also provides a C/C++ API that can be used by other packages. Not to be
    #>   confused with 'RNiftyReg', which performs image registration.
    #>   https://github.com/jonclayden/RNifti
    #> 
    #> 9 glpkAPI @ 1.3.1                                             Mayo Roettger, 8 months ago 
    #> -----------------
    #>   # R Interface to C API of GLPK
    #>   R Interface to C API of GLPK, depends on GLPK Version >= 4.42.
    #> 
    #> 10 xml2 @ 1.2.0                                            James Hester, about a year ago 
    #> ---------------
    #>   # Parse XML
    #>   Work with XML files using a simple, consistent interface. Built on top of the
    #>   'libxml2' C library.
    #>   https://github.com/r-lib/xml2

The `more()` function can be used to display the next batch of search
hits, batches contain ten packages by default. `ps()` is a shorter alias
to
    `pkg_search()`:

``` r
ps("google")
```

    #> - "google" ---------------------------------------------- 112 packages in 0.007 seconds - 
    #>   #     package             version by               @ title                             
    #>   1 100 googleVis           0.6.3   Markus Gesmann  6M R Interface to Google Charts      
    #>   2  68 googleAuthR         0.7.0   Mark Edmondson  6M Authenticate and Create Google ...
    #>   3  60 lubridate           1.7.4   Vitalie Spinu   1y Make Dealing with Dates a Littl...
    #>   4  54 googledrive         0.1.3   Jennifer Bryan  4M An Interface to Google Drive      
    #>   5  49 plotKML             0.5.9   Tomislav Hengl  4M Visualization of Spatial and Sp...
    #>   6  48 googlesheets        0.3.0   Jennifer Bryan 11M Manage Google Spreadsheets from R 
    #>   7  46 googleCloudStorageR 0.4.0   Mark Edmondson  1y Interface with Google Cloud Sto...
    #>   8  37 gsheet              0.4.2   Max Conway      2y Download Google Sheets Using Ju...
    #>   9  37 bigQueryR           0.4.0   Mark Edmondson  1y Interface with Google BigQuery ...
    #>  10  35 googleAnalyticsR    0.6.0   Mark Edmondson  5M Google Analytics API into R

``` r
more()
```

    #> - "google" ---------------------------------------------- 112 packages in 0.008 seconds - 
    #>   #    package         version by                     @ title                            
    #>  11 35 googlePolylines 0.7.2   David Cooley          6M Encoding Coordinates into 'Goo...
    #>  12 34 ggmap           3.0.0   ORPHANED              3M Spatial Visualization with ggp...
    #>  13 33 cld2            1.2     Jeroen Ooms           1y Google's Compact Language Dete...
    #>  14 29 V8              2.2     Jeroen Ooms           1M Embedded JavaScript Engine for R 
    #>  15 27 gcite           0.10.1  John Muschelli        2M Google Citation Parser           
    #>  16 27 rgoogleslides   0.3.1   Hairizuan Noorazman   8M R Interface to Google Slides     
    #>  17 27 plusser         0.4.0   Christoph Waldhauser  5y A Google+ Interface for R        
    #>  18 27 ganalytics      0.10.7  Johann de Boer        2M Interact with 'Google Analytics' 
    #>  19 27 pluscode        0.1.0   Michael Doyle         6M Encoder for Google 'Pluscodes'   
    #>  20 26 s2              0.4.0   Ege Rubak             1y Google's S2 Library for Geomet...

## Features

In addition to simple text matching the search server and client have
many improvements to deliver better results.

### Stemming

The search server uses the stems of the words in the indexed metadata,
and the search phrase. This means that “colour” and “colours” deliver
the exact same result. So do “coloring”, “colored”, etc. (Unless one is
happen to be an exact package name or match another non-stemmed
    field.)

``` r
ps("colour", size = 3)
```

    #> - "colour" ---------------------------------------------- 176 packages in 0.007 seconds - 
    #>   #     package    version by              @ title                                       
    #>  1  100 crayon     1.3.4   Gábor Csárdi   2y Colored Terminal Output                     
    #>  2   84 colorspace 1.4.1   Achim Zeileis  2M A Toolbox for Manipulating and Assessing ...
    #>  3   70 viridis    0.5.1   Simon Garnier  1y Default Color Maps from 'matplotlib'

``` r
ps("colours", size = 3)
```

    #> - "colours" ---------------------------------------------- 174 packages in 0.01 seconds - 
    #>   #     package    version by              @ title                                       
    #>  1  100 crayon     1.3.4   Gábor Csárdi   2y Colored Terminal Output                     
    #>  2   84 colorspace 1.4.1   Achim Zeileis  2M A Toolbox for Manipulating and Assessing ...
    #>  3   70 viridis    0.5.1   Simon Garnier  1y Default Color Maps from 'matplotlib'

### Ranking

The most important feature of a search engine is the ranking of the
results. The best results should be listed first. pkgsearch uses
weighted scoring, where a match in the package title gets a higher score
than a match in the package desciption. It also uses the number of
reverse dependencies and the number of downloads to weight the scores:

``` r
ps("colour")[, c("score", "package", "revdeps", "downloads_last_month")]
```

    #> # A tibble: 10 x 4
    #>     score package      revdeps downloads_last_month
    #>     <dbl> <chr>          <int>                <int>
    #>  1 10970. crayon           142               489589
    #>  2  9253. colorspace       138               444949
    #>  3  7669. viridis           86               184853
    #>  4  5018. colourpicker      22                21223
    #>  5  4882. shape             35                16545
    #>  6  4789. viridisLite       44               376462
    #>  7  4679. pillar            23               613278
    #>  8  3702. RColorBrewer     419               409670
    #>  9  3347. colorRamps        13                 4634
    #> 10  3086. dichromat         10                27602

### Preferring Phrases

The search engine prefers matching whole phrases over single words. E.g.
the search phrase “permutation test” will rank coin higher than
testthat, even though testthat is a much better result for the single
word “test”. (In fact, at the time of writing testhat is not even on the
first page of
    results.)

``` r
ps("permutation test")
```

    #> - "permutation test" ----------------------------------- 1668 packages in 0.018 seconds - 
    #>   #     package        version by                      @ title                           
    #>   1 100 coin           1.3.0   Torsten Hothorn        2M Conditional Inference Procedu...
    #>   2  35 flip           2.5.0   Livio Finos            9M Multivariate Permutation Tests  
    #>   3  32 perm           1.0.0.0 Michael Fay            9y Exact or Asymptotic permutati...
    #>   4  23 exactRankTests 0.8.30  Torsten Hothorn       16d Exact Distributions for Rank ...
    #>   5  23 wPerm          1.0.1   Neil A. Weiss          4y Permutation Tests               
    #>   6  19 cpt            1.0.2   Johann Gagnon-Bartsch  7M Classification Permutation Test 
    #>   7  19 GlobalDeviance 0.4     Frederike Fuhlbrueck   6y Global Deviance Permutation T...
    #>   8  19 permutes       0.1     Cesko Voeten           1y Permutation Tests for Time Se...
    #>   9  19 jmuOutlier     1.4     Steven T. Garren       1y Permutation Tests for Nonpara...
    #>  10  19 AUtests        0.98    Arjun Sondhi           3y Approximate Unconditional and...

If the whole phrase does not match, pkgsearch falls back to individual
matching words. For example, a match from either words is enough here,
to get on the first page of
    results:

``` r
ps("test http")
```

    #> - "test http" ------------------------------------------ 5403 packages in 0.014 seconds - 
    #>   #     package   version   by                   @ title                                 
    #>   1 100 httptest  3.2.2     Neal Richardson     5M A Test Environment for HTTP Requests  
    #>   2  80 covr      3.2.1     Jim Hester          7M Test Coverage for Packages            
    #>   3  34 testthat  2.1.1     Hadley Wickham     21d Unit Testing for R                    
    #>   4  17 psych     1.8.12    William Revelle     4M Procedures for Psychological, Psych...
    #>   5  13 vcr       0.2.6     Scott Chamberlain   3M Record 'HTTP' Calls to Disk           
    #>   6  10 httr      1.4.0     Hadley Wickham      5M Tools for Working with URLs and HTTP  
    #>   7   9 webmockr  0.3.4     Scott Chamberlain   3M Stubbing and Setting Expectations o...
    #>   8   8 bnlearn   4.4.1     Marco Scutari       2M Bayesian Network Structure Learning...
    #>   9   8 RCurl     1.95.4.12 Duncan Temple Lang  2M General Network (HTTP/FTP/...) Clie...
    #>  10   6 oompaBase 3.2.8     Kevin R. Coombes    8d Class Unions, Matrix Operations, an...

### British vs American English

The seach engine uses a dictionary to make sure that package metadata
and queries given in British and American English yield the same
results. E.g. note the spelling of colour/color in the
    results:

``` r
ps("colour")
```

    #> - "colour" ---------------------------------------------- 176 packages in 0.007 seconds - 
    #>   #     package      version by                 @ title                                  
    #>   1 100 crayon       1.3.4   Gábor Csárdi      2y Colored Terminal Output                
    #>   2  84 colorspace   1.4.1   Achim Zeileis     2M A Toolbox for Manipulating and Asses...
    #>   3  70 viridis      0.5.1   Simon Garnier     1y Default Color Maps from 'matplotlib'   
    #>   4  46 colourpicker 1.0     Dean Attali       2y A Colour Picker Tool for Shiny and f...
    #>   5  45 shape        1.4.4   Karline Soetaert  1y Functions for Plotting Graphical Sha...
    #>   6  44 viridisLite  0.3.0   Simon Garnier     1y Default Color Maps from 'matplotlib'...
    #>   7  43 pillar       1.4.0   Kirill Müller     3d Coloured Formatting for Columns        
    #>   8  34 RColorBrewer 1.1.2   Erich Neuwirth    4y ColorBrewer Palettes                   
    #>   9  31 colorRamps   2.3     Tim Keitt         7y Builds color tables                    
    #>  10  28 dichromat    2.0.0   Thomas Lumley     6y Color Schemes for Dichromats

``` r
ps("color")
```

    #> - "color" ----------------------------------------------- 174 packages in 0.007 seconds - 
    #>   #     package      version by                 @ title                                  
    #>   1 100 crayon       1.3.4   Gábor Csárdi      2y Colored Terminal Output                
    #>   2  84 colorspace   1.4.1   Achim Zeileis     2M A Toolbox for Manipulating and Asses...
    #>   3  70 viridis      0.5.1   Simon Garnier     1y Default Color Maps from 'matplotlib'   
    #>   4  46 colourpicker 1.0     Dean Attali       2y A Colour Picker Tool for Shiny and f...
    #>   5  45 shape        1.4.4   Karline Soetaert  1y Functions for Plotting Graphical Sha...
    #>   6  44 viridisLite  0.3.0   Simon Garnier     1y Default Color Maps from 'matplotlib'...
    #>   7  43 pillar       1.4.0   Kirill Müller     3d Coloured Formatting for Columns        
    #>   8  34 RColorBrewer 1.1.2   Erich Neuwirth    4y ColorBrewer Palettes                   
    #>   9  31 colorRamps   2.3     Tim Keitt         7y Builds color tables                    
    #>  10  28 dichromat    2.0.0   Thomas Lumley     6y Color Schemes for Dichromats

### Ascii Folding

Especially when searching for package maintainer names, it is convenient
to use the corresponding ASCII letters for non-ASCII characters in
search phrases. E.g. the following two queries yield the same results.
Note that case is also
    ignored.

``` r
ps("gabor", size = 5)
```

    #> - "gabor" ------------------------------------------------ 84 packages in 0.007 seconds - 
    #>   #     package  version by              @ title                                         
    #>  1  100 igraph   1.2.4.1 Gábor Csárdi  22d Network Analysis and Visualization            
    #>  2   50 crayon   1.3.4   Gábor Csárdi   2y Colored Terminal Output                       
    #>  3   37 zoo      1.8.5   Achim Zeileis  2M S3 Infrastructure for Regular and Irregular...
    #>  4   35 progress 1.2.1   Gábor Csárdi   1d Terminal Progress Bars                        
    #>  5   33 cli      1.1.0   Gábor Csárdi   2M Helpers for Developing Command Line Interfaces

``` r
ps("Gábor", size = 5)
```

    #> - "Gábor" ------------------------------------------------ 84 packages in 0.007 seconds - 
    #>   #     package  version by              @ title                                         
    #>  1  100 igraph   1.2.4.1 Gábor Csárdi  22d Network Analysis and Visualization            
    #>  2   50 crayon   1.3.4   Gábor Csárdi   2y Colored Terminal Output                       
    #>  3   37 zoo      1.8.5   Achim Zeileis  2M S3 Infrastructure for Regular and Irregular...
    #>  4   35 progress 1.2.1   Gábor Csárdi   1d Terminal Progress Bars                        
    #>  5   33 cli      1.1.0   Gábor Csárdi   2M Helpers for Developing Command Line Interfaces

## Get CRAN metadata

For obtaining CRAN metadata, pkgsearch uses the [crandb
webservice](http://crandb.r-pkg.org).

### Get metadata about a package

``` r
cran_package("pkgsearch")
```

    #> CRAN package pkgsearch 2.0.1, 5 months ago
    #> Title: Search CRAN R Packages
    #> Maintainer: Gábor Csárdi <csardi.gabor@gmail.com>
    #> Author: Gábor Csárdi [aut, cre]
    #> BugReports: https://github.com/metacran/pkgsearch/issues
    #> Date/Publication: 2018-12-05 06:50:03 UTC
    #> Description: Search CRAN R packages. Uses the 'METACRAN' search server, see
    #>     <https://r-pkg.org>.
    #> Encoding: UTF-8
    #> Imports: magrittr (*), httr (*), jsonlite (*), parsedate (*), prettyunits (*)
    #> LazyData: true
    #> License: MIT + file LICENSE
    #> MD5sum: 25c874565c70866576b8e2228980af7c
    #> NeedsCompilation: no
    #> Packaged: 2018-12-04 22:38:55 UTC; gaborcsardi
    #> releases:
    #> Repository: CRAN
    #> RoxygenNote: 6.1.0
    #> Suggests: covr (*), testthat (*), tibble (*)
    #> URL: https://github.com/metacran/pkgsearch#readme

``` r
cran_package("rhub")
```

    #> CRAN package rhub 1.1.1, about a month ago
    #> Title: Connect to 'R-hub'
    #> Maintainer: Gábor Csárdi <csardi.gabor@gmail.com>
    #> Author: Gábor Csárdi [aut, cre], Maëlle Salmon [aut]
    #>     (<https://orcid.org/0000-0002-2815-0399>), R Consortium [fnd]
    #> BugReports: https://github.com/r-hub/rhub/issues
    #> Date/Publication: 2019-04-08 08:30:03 UTC
    #> Description: Run 'R CMD check' on any of the 'R-hub'
    #>     (<https://builder.r-hub.io/>) architectures, from the command line. The
    #>     current architectures include 'Windows', 'macOS', 'Solaris' and various
    #>     'Linux' distributions.
    #> Encoding: UTF-8
    #> Imports: assertthat (*), callr (*), cli (>= 1.1.0), crayon (*), desc (*), digest
    #>     (*), httr (*), jsonlite (*), parsedate (*), pillar (*), prettyunits (*),
    #>     processx (*), R6 (*), rappdirs (*), rcmdcheck (>= 1.2.1), rematch (*),
    #>     tibble (*), utils (*), uuid (*), whoami (*), withr (*)
    #> LazyData: true
    #> License: MIT + file LICENSE
    #> MD5sum: 7be8e0a7b90ec1da851d9c24e23910d8
    #> NeedsCompilation: no
    #> Packaged: 2019-04-08 08:15:03 UTC; gaborcsardi
    #> releases:
    #> Repository: CRAN
    #> RoxygenNote: 6.1.1
    #> Suggests: covr (*), testthat (*), knitr (*), rmarkdown (*)
    #> URL: https://github.com/r-hub/rhub, https://r-hub.github.io/rhub/
    #> VignetteBuilder: knitr

### Get latest CRAN events (releases, archivals)

``` r
cran_events()
```

    #> CRAN events (events)---------------------------------------------------------------------
    #>  . When     Package  Version Title                                                       
    #>  + 14 hours dplyr    0.8.1   A Grammar of Data Manipulation                              
    #>  + 14 hours btergm   1.9.4   Temporal Exponential Random Graph Models by Bootstrapped ...
    #>  + 14 hours c212     0.95    Methods for Detecting Safety Signals in Clinical Trials U...
    #>  + 14 hours plm      2.0-0   Linear Models for Panel Data                                
    #>  + 14 hours ergm     3.10.1  Fit, Simulate and Diagnose Exponential-Family Models for ...
    #>  + 14 hours ukgasapi 0.16    API for UK Gas Market Information                           
    #>  + 14 hours pct      0.2.1   Propensity to Cycle Tool                                    
    #>  + 14 hours rticles  0.8     Article Formats for R Markdown                              
    #>  + 14 hours tinytex  0.13    Helper Functions to Install and Maintain 'TeX Live', and ...
    #>  + 14 hours xaringan 0.10    Presentation Ninja

``` r
cran_events(limit = 5, releases = FALSE)
```

    #> CRAN events (archivals)------------------------------------------------------------------
    #>  . When  Package         Version Title                                                   
    #>  - 1 day planor          1.4-1   Generation of Regular Factorial Designs                 
    #>  - 1 day packagefinder   0.1.2   Comfortable Search for R Packages on CRAN Directly fr...
    #>  - 1 day nestedRanksTest 0.2     Mann-Whitney-Wilcoxon Test for Nested Ranks             
    #>  - 1 day kmi             0.5.4   Kaplan-Meier Multiple Imputation for the Analysis of ...
    #>  - 1 day intReg          0.2-8   Interval Regression

``` r
cran_events(limit = 5, archivals = FALSE)
```

    #> CRAN events (pkgreleases)----------------------------------------------------------------
    #>  . When     Package Version Title                                                        
    #>  + 14 hours dplyr   0.8.1   A Grammar of Data Manipulation                               
    #>  + 14 hours btergm  1.9.4   Temporal Exponential Random Graph Models by Bootstrapped P...
    #>  + 14 hours c212    0.95    Methods for Detecting Safety Signals in Clinical Trials Us...
    #>  + 14 hours plm     2.0-0   Linear Models for Panel Data                                 
    #>  + 14 hours ergm    3.10.1  Fit, Simulate and Diagnose Exponential-Family Models for N...

### List active (available) packages

``` r
cran_packages()
```

    #> CRAN packages (short)--------------------------------------------------------------------
    #>  Package     Version Title                                                               
    #>  A3          1.0.0   Accurate, Adaptable, and Accessible Error Metrics for Predictive ...
    #>  abbyyR      0.5.4   Access to Abbyy Optical Character Recognition (OCR) API             
    #>  abc         2.1     Tools for Approximate Bayesian Computation (ABC)                    
    #>  abc.data    1.0     Data Only: Tools for Approximate Bayesian Computation (ABC)         
    #>  ABC.RAP     0.9.0   Array Based CpG Region Analysis Pipeline                            
    #>  ABCanalysis 1.2.1   Computed ABC Analysis                                               
    #>  abcdeFBA    0.4     ABCDE_FBA: A-Biologist-Can-Do-Everything of Flux Balance<U+000a>A...
    #>  ABCoptim    0.15.0  Implementation of Artificial Bee Colony (ABC) Optimization          
    #>  ABCp2       1.2     Approximate Bayesian Computational Model for Estimating P2          
    #>  abcrf       1.7.1   Approximate Bayesian Computation via Random Forests

``` r
cran_packages(from = "pkgsearch")
```

    #> CRAN packages (short)--------------------------------------------------------------------
    #>  Package    Version Title                                                                
    #>  pkgsearch  2.0.1   Search CRAN R Packages                                               
    #>  pkgverse   0.0.1   Build a Meta-Package Universe                                        
    #>  PKI        0.1-5.1 Public Key Infrastucture for R Based on the X.509 Standard           
    #>  pkmon      1.0     Least-Squares Estimator under k-Monotony Constraint for Discrete F...
    #>  PKNCA      0.8.5   Perform Pharmacokinetic Non-Compartmental Analysis                   
    #>  PKPDmisc   2.1.1   Pharmacokinetic and Pharmacodynamic Data Management Functions        
    #>  PKPDmodels 0.3.2   Pharmacokinetic/pharmacodynamic models                               
    #>  pkr        0.1.2   Pharmacokinetics in R                                                
    #>  PKreport   1.5     A reporting pipeline for checking population pharmacokinetic model...
    #>  pks        0.4-0   Probabilistic Knowledge Structures

### List R releases in the CRANDB database

``` r
cran_releases()
```

    #> R releases-------------------------------------------------------------------------------
    #>  Version Date               
    #>  2.0.0   2004-10-04 02:00:00
    #>  2.0.1   2004-11-15 01:00:00
    #>  2.1.0   2005-04-18 02:00:00
    #>  2.1.1   2005-06-20 02:00:00
    #>  2.2.0   2005-10-06 02:00:00
    #>  2.2.1   2005-12-20 01:00:00
    #>  2.3.0   2006-04-24 02:00:00
    #>  2.3.1   2006-06-01 02:00:00
    #>  2.4.0   2006-10-03 02:00:00
    #>  2.4.1   2006-12-18 01:00:00
    #>  2.5.0   2007-04-24 02:00:00
    #>  2.5.1   2007-06-28 02:00:00
    #>  2.6.0   2007-10-03 02:00:00
    #>  2.6.1   2007-11-26 01:00:00
    #>  2.6.2   2008-02-08 01:00:00
    #>  2.7.0   2008-04-22 02:00:00
    #>  2.7.1   2008-06-23 02:00:00
    #>  2.7.2   2008-08-25 02:00:00
    #>  2.8.0   2008-10-20 02:00:00
    #>  2.8.1   2008-12-22 01:00:00
    #>  2.9.0   2009-04-17 02:00:00
    #>  2.9.1   2009-06-26 02:00:00
    #>  2.9.2   2009-08-24 02:00:00
    #>  2.10.0  2009-10-26 01:00:00
    #>  2.10.1  2009-12-14 01:00:00
    #>  2.11.0  2010-04-22 02:00:00
    #>  2.11.1  2010-05-31 02:00:00
    #>  2.12.0  2010-10-15 02:00:00
    #>  2.12.1  2010-12-16 01:00:00
    #>  2.12.2  2011-02-25 01:00:00
    #>  2.13.0  2011-04-13 02:00:00
    #>  2.13.1  2011-07-08 02:00:00
    #>  2.13.2  2011-09-30 02:00:00
    #>  2.14.0  2011-10-31 01:00:00
    #>  2.14.1  2011-12-22 01:00:00
    #>  2.14.2  2012-02-29 01:00:00
    #>  2.15.0  2012-03-30 02:00:00
    #>  2.15.1  2012-06-22 02:00:00
    #>  2.15.2  2012-10-26 02:00:00
    #>  2.15.3  2013-03-01 01:00:00
    #>  3.0.0   2013-04-03 02:00:00
    #>  3.0.1   2013-05-16 02:00:00
    #>  3.0.2   2013-09-25 02:00:00
    #>  3.0.3   2014-03-06 01:00:00
    #>  3.1.0   2014-04-10 02:00:00
    #>  3.1.1   2014-07-10 02:00:00

## License

MIT @ [Gábor Csárdi](https://github.com/gaborcsardi),
[RStudio](https://github.com/rstudio), [R
Consortium](https://www.r-consortium.org/).
