


# CRAN package search

[![Linux Build Status](https://travis-ci.org/metacran/seer.svg?branch=master)](https://travis-ci.org/metacran/seer)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/github/metacran/seer?svg=true)](https://ci.appveyor.com/project/gaborcsardi/seer)

The `seer` package searches all CRAN packages. It uses a web service,
and a careful weighting that ranks popular packages before less
frequently used ones.

## Installation

Install the package from github, using `devtools`:

```r
devtools::install_github("metacran/seer")
```

## Usage

The current API is very minimal, the most important is the `see()` function,
that does the search:


```r
library(seer)
see("C++")
```

```
#> SAW "C++" ------------------------------------------- 3914 packages in 0.397 seconds --- 
#>  #  # Title      # Package                                                               
#>  1  Rcpp         Seamless R and C++ Integration                                          
#>  2  BH           Boost C++ Header Files                                                  
#>  3  inline       Functions to Inline C, C++, Fortran Function Calls from R               
#>  4  geometry     Mesh Generation and Surface Tesselation                                 
#>  5  SnowballC    Snowball stemmers based on the C libstemmer UTF-8 library               
#>  6  optimx       A Replacement and Extension of the optim() Function                     
#>  7  glpkAPI      R Interface to C API of GLPK                                            
#>  8  getopt       C-like getopt behavior.                                                 
#>  9  BASIX        BASIX: An efficient C/C++ toolset for R.                                
#>  10 RcppProgress An Interruptible Progress Bar with OpenMP Support for C++ in R Packag...
```

By default it returns a short summary of the ten best search hits. Their
details can be printed by using the `format = "long"` option of `see()`,
or just calling `see()` again, without any arguments, after a search:



```r
see()
```

```
#> SAW "C++" ------------------------------------------- 3914 packages in 0.397 seconds --- 
#> 
#> 1 Rcpp @ 0.12.11                                           Dirk Eddelbuettel, 3 days ago 
#> ----------------
#>   # Seamless R and C++ Integration
#>   The 'Rcpp' package provides R functions as well as C++ classes which offer a seamless
#>   integration of R and C++. Many R data types and objects can be mapped back and forth
#>   to C++ equivalents which facilitates both writing of new code as well as easier
#>   integration of third-party libraries. Documentation about 'Rcpp' is provided by
#>   several vignettes included in this package, via the 'Rcpp Gallery' site at
#>   <http://gallery.rcpp.org>, the paper by Eddelbuettel and Francois (2011, JSS), and
#>   the book by Eddelbuettel (2013, Springer); see 'citation("Rcpp")' for details on
#>   these last two.
#>   http://www.rcpp.org
#>   http://dirk.eddelbuettel.com/code/rcpp.html
#>   https://github.com/RcppCore/Rcpp
#> 
#> 2 BH @ 1.62.0-1                                          Dirk Eddelbuettel, 6 months ago 
#> ---------------
#>   # Boost C++ Header Files
#>   Boost provides free peer-reviewed portable C++ source libraries.  A large part of
#>   Boost is provided as C++ template code which is resolved entirely at compile-time
#>   without linking.  This package aims to provide the most useful subset of Boost
#>   libraries for template use among CRAN package. By placing these libraries in this
#>   package, we offer a more efficient distribution system for CRAN as replication of
#>   this code in the sources of other packages is avoided. As of release 1.62.0-1, the
#>   following Boost libraries are included: 'algorithm' 'any' 'atomic' 'bimap' 'bind'
#>   'circular_buffer' 'concept' 'config' 'container' 'date'_'time' 'detail'
#>   'dynamic_bitset' 'exception' 'filesystem' 'flyweight' 'foreach' 'functional' 'fusion'
#>   'geometry' 'graph' 'heap' 'icl' 'integer' 'interprocess' 'intrusive' 'io' 'iostreams'
#>   'iterator' 'math' 'move' 'mpl' 'multiprcecision' 'numeric' 'pending' 'phoenix'
#>   'preprocessor' 'propery_tree' 'random' 'range' 'scope_exit' 'smart_ptr' 'spirit'
#>   'tuple' 'type_traits' 'typeof' 'unordered' 'utility' 'uuid'.
#> 
#> 3 inline @ 0.3.14                                         Dirk Eddelbuettel, 2 years ago 
#> -----------------
#>   # Functions to Inline C, C++, Fortran Function Calls from R
#>   Functionality to dynamically define R functions and S4 methods with inlined C, C++ or
#>   Fortran code supporting .C and .Call calling conventions.
#> 
#> 4 geometry @ 0.3-6                                        David C. Sterratt, 2 years ago 
#> ------------------
#>   # Mesh Generation and Surface Tesselation
#>   Makes the qhull library (www.qhull.org) available in R, in a similar manner as in
#>   Octave and MATLAB. Qhull computes convex hulls, Delaunay triangulations, halfspace
#>   intersections about a point, Voronoi diagrams, furthest-site Delaunay triangulations,
#>   and furthest-site Voronoi diagrams. It runs in 2-d, 3-d, 4-d, and higher dimensions.
#>   It implements the Quickhull algorithm for computing the convex hull. Qhull does not
#>   support constrained Delaunay triangulations, or mesh generation of non-convex
#>   objects, but the package does include some R functions that allow for this. Currently
#>   the package only gives access to Delaunay triangulation and convex hull computation.
#>   http://geometry.r-forge.r-project.org/
#> 
#> 5 SnowballC @ 0.5.1                                     Milan Bouchet-Valat, 3 years ago 
#> -------------------
#>   # Snowball stemmers based on the C libstemmer UTF-8 library
#>   An R interface to the C libstemmer library that implements<U+000a>Porter's word
#>   stemming algorithm for collapsing words to a common<U+000a>root to aid comparison of
#>   vocabulary. Currently supported languages are<U+000a>Danish, Dutch, English, Finnish,
#>   French, German, Hungarian, Italian,<U+000a>Norwegian, Portuguese, Romanian, Russian,
#>   Spanish, Swedish<U+000a>and Turkish.
#>   https://r-forge.r-project.org/projects/r-temis/
#> 
#> 6 optimx @ 2013.8.7                                             John C Nash, 3 years ago 
#> -------------------
#>   # A Replacement and Extension of the optim() Function
#>   Provides a replacement and extension of the optim()<U+000a>function to unify and
#>   streamline optimization capabilities in R<U+000a>for smooth, possibly box constrained
#>   functions of several or<U+000a>many parameters. This is the CRAN version of the
#>   package.
#> 
#> 7 glpkAPI @ 1.3.0                                Claus Jonathan Fritzemeier, 2 years ago 
#> -----------------
#>   # R Interface to C API of GLPK
#>   R Interface to C API of GLPK, needs GLPK Version >= 4.42
#> 
#> 8 getopt @ 1.20.0                                            Trevor L Davis, 4 years ago 
#> -----------------
#>   # C-like getopt behavior.
#>   Package designed to be used with Rscript to write<U+000a>``#!'' shebang scripts that
#>   accept short and long flags/options.<U+000a>Many users will prefer using instead the
#>   packages optparse or argparse<U+000a>which add extra features like automatically
#>   generated help option and usage,<U+000a>support for default values, positional
#>   argument support, etc.
#>   https://github.com/trevorld/getopt
#> 
#> 9 BASIX @ 1.1                                               Bastian Pfeifer, 4 years ago 
#> -------------
#>   # BASIX: An efficient C/C++ toolset for R.
#>   BASIX provides some efficient C/C++ implementations to speed up calculations in R.
#> 
#> 10 RcppProgress @ 0.3                                          Karl Forner, 5 months ago 
#> ---------------------
#>   # An Interruptible Progress Bar with OpenMP Support for C++ in R Packages
#>   Allows to display a progress bar in the R console for long running computations
#>   taking place in c++ code, and support for interrupting those computations even in
#>   multithreaded code, typically using OpenMP.
#>   https://github.com/kforner/rcpp_progress
```

The `more()` function can be used to display the next batch of search hits,
batches contain ten packages by default:


```r
see("google")
```

```
#> SAW "google" ------------------------------------------ 77 packages in 0.027 seconds --- 
#>  #  # Title          # Package                                                           
#>  1  googleVis        R Interface to Google Charts                                        
#>  2  plotKML          Visualization of Spatial and Spatio-Temporal Objects in Google Ea...
#>  3  bigrquery        An Interface to Google's 'BigQuery' 'API'                           
#>  4  gcite            Google Citation Parser                                              
#>  5  RGA              A Google Analytics API Client                                       
#>  6  searchConsoleR   Google Search Console R Client                                      
#>  7  s2               Google's S2 Library for Geometry on the Sphere                      
#>  8  googleAnalyticsR Google Analytics API into R                                         
#>  9  bigQueryR        Interface with Google BigQuery with Shiny Compatibility             
#>  10 GAR              Authorize and Request Google Analytics Data
```


```r
more()
```

```
#> SAW "google" ------------------------------------------ 77 packages in 0.019 seconds --- 
#>  #  # Title              # Package                                 
#>  11 placement            Tools for Accessing the Google Maps API   
#>  12 RGoogleFit           R Interface to Google Fit API             
#>  13 gtrendsR             Perform and Display Google Trends Queries 
#>  14 googleAuthR          Easy Authentication with Google OAuth2 API
#>  15 RAdwords             Loading Google Adwords Data into R        
#>  16 googleCloudStorageR  R Interface with Google Cloud Storage     
#>  17 googleComputeEngineR R Interface with Google Compute Engine    
#>  18 gepaf                Google Encoded Polyline Algorithm Format  
#>  19 googlesheets         Manage Google Spreadsheets from R         
#>  20 scholar              Analyse Citation Data from Google Scholar
```


```r
more()
```

```
#> SAW "google" ------------------------------------------ 77 packages in 0.019 seconds --- 
#>  #  # Title                 # Package                                                    
#>  21 RGoogleAnalyticsPremium Unsampled Data in R for Google Analytics Premium Accounts    
#>  22 gdns                    Tools to Work with Google DNS Over HTTPS API                 
#>  23 googleformr             Collect Data Programmatically by POST Methods to Google Fo...
#>  24 gsheet                  Download Google Sheets Using Just the URL                    
#>  25 revgeo                  Reverse Geocoding with the Photon Geocoder for OpenStreetM...
#>  26 plotGoogleMaps          Plot Spatial or Spatio-Temporal Data Over Google Maps        
#>  27 googleway               Accesses Google Maps APIs to Retrieve Data and Plot Maps     
#>  28 gmapsdistance           Distance and Travel Time Between Two Points from Google Ma...
#>  29 googlePublicData        Working with Google Public Data Explorer DSPL Metadata Fil...
#>  30 rmarkdown               Dynamic Documents for R
```
