


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
#> SAW "C++" ------------------------------------------- 1022 packages in 0.331 seconds --- 
#>  #  # Title   # Package                                                      
#>  1  Rcpp      Seamless R and C++ Integration                                 
#>  2  BH        Boost C++ header files                                         
#>  3  inline    Inline C, C++, Fortran function calls from R                   
#>  4  geometry  Mesh generation and surface tesselation                        
#>  5  optimx    A Replacement and Extension of the optim() Function            
#>  6  glpkAPI   R Interface to C API of GLPK                                   
#>  7  SnowballC Snowball stemmers based on the C libstemmer UTF-8 library      
#>  8  getopt    C-like getopt behavior.                                        
#>  9  BASIX     BASIX: An efficient C/C++ toolset for R.                       
#>  10 e1071     Misc Functions of the Department of Statistics (e1071), TU Wien
```

By default it returns a short summary of the ten best search hits. Their
details can be printed by using the `format = "long"` option of `see()`,
or just calling `see()` again, without any arguments, after a search:



```r
see()
```

```
#> SAW "C++" ------------------------------------------- 1022 packages in 0.331 seconds --- 
#> 
#> 1 Rcpp @ 0.11.2                                          Dirk Eddelbuettel, 3 months ago 
#> ---------------
#>   # Seamless R and C++ Integration
#>   The Rcpp package provides R functions as well as a C++ library which facilitate the
#>   integration of R and C++.
#> 
#>   R data types (SEXP) are matched to C++ objects in a class hierarchy.  All R types are
#>   supported (vectors, functions, environment, etc ...)  and each type is mapped to a
#>   dedicated class. For example, numeric vectors are represented as instances of the
#>   Rcpp::NumericVector class, environments are represented as instances of
#>   Rcpp::Environment, functions are represented as Rcpp::Function, etc ... The
#>   "Rcpp-introduction" vignette provides a good entry point to Rcpp.
#> 
#>   Conversion from C++ to R and back is driven by the templates Rcpp::wrap and Rcpp::as
#>   which are highly flexible and extensible, as documented in the "Rcpp-extending"
#>   vignette.
#> 
#>   Rcpp also provides Rcpp modules, a framework that allows exposing C++ functions and
#>   classes to the R level. The "Rcpp-modules" vignette details the current set of
#>   features of Rcpp-modules.
#> 
#>   Rcpp includes a concept called Rcpp sugar that brings many R functions into C++.
#>   Sugar takes advantage of lazy evaluation and expression templates to achieve great
#>   performance while exposing a syntax that is much nicer to use than the equivalent
#>   low-level loop code. The "Rcpp-sugar" vignette gives an overview of the feature.
#> 
#>   Rcpp attributes provide a high-level syntax for declaring C++ functions as callable
#>   from R and automatically generating the code required to invoke them.  Attributes are
#>   intended to facilitate both interactive use of C++ within R sessions as well as to
#>   support R package development. Attributes are built on top of Rcpp modules and their
#>   implementation is based on previous work in the inline package.
#> 
#>   Many examples are included, and around 900 unit tests in 446 unit test functions
#>   provide additional usage examples.
#> 
#>   An earlier version of Rcpp, containing what we now call the 'classic Rcpp API' was
#>   written during 2005 and 2006 by Dominick Samperi.  This code has been factored out of
#>   Rcpp into the package RcppClassic, and it is still available for code relying on the
#>   older interface. New development should always use this Rcpp package instead.
#> 
#>   Additional documentation is available via the paper by Eddelbuettel and Francois
#>   (2011, JSS) paper and the book by Eddelbuettel (2013, Springer); see
#>   'citation("Rcpp")' for details.
#>   http://www.rcpp.org
#>   http://dirk.eddelbuettel.com/code/rcpp.html
#>   https://github.com/RcppCore/Rcpp
#> 
#> 2 BH @ 1.54.0-4                                           Dirk Eddelbuettel, 16 days ago 
#> ---------------
#>   # Boost C++ header files
#>   Boost provides free peer-reviewed portable C++ source libraries.  A large part of
#>   Boost is provided as C++ template code which is resolved entirely at compile-time
#>   without linking.  This package aims to provide the most useful subset of Boost
#>   libraries for template use among CRAN package. By placing these libraries in this
#>   package, we offer a more efficient distribution system for CRAN as replication of
#>   this code in the sources of other packages is avoided.
#> 
#> 3 inline @ 0.3.13                                    Dirk Eddelbuettel, about a year ago 
#> -----------------
#>   # Inline C, C++, Fortran function calls from R
#>   Functionality to dynamically define R functions and S4 methods with in-lined C, C++
#>   or Fortran code supporting .C and .Call calling conventions.
#> 
#> 4 geometry @ 0.3-4                                       David C. Sterratt, 6 months ago 
#> ------------------
#>   # Mesh generation and surface tesselation
#>   This package makes the qhull library (www.qhull.org) available in R, in a similar
#>   manner as in Octave and MATLAB. Qhull computes convex hulls, Delaunay triangulations,
#>   halfspace intersections about a point, Voronoi diagrams, furthest-site Delaunay
#>   triangulations, and furthest-site Voronoi diagrams. It runs in 2-d, 3-d, 4-d, and
#>   higher dimensions. It implements the Quickhull algorithm for computing the convex
#>   hull. Qhull does not support constrained Delaunay triangulations, or mesh generation
#>   of non-convex objects, but the package does include some R functions that allow for
#>   this. Currently the package only gives access to Delaunay triangulation and convex
#>   hull computation.
#>   http://geometry.r-forge.r-project.org/
#> 
#> 5 optimx @ 2013.8.6                                        John C Nash, about a year ago 
#> -------------------
#>   # A Replacement and Extension of the optim() Function
#>   Provides a replacement and extension of the optim() function to unify and streamline
#>   optimization capabilities in R for smooth, possibly box constrained functions of
#>   several or many parameters. This is the CRAN version of the package.
#> 
#> 6 glpkAPI @ 1.2.10                                 Gabriel Gelius-Dietrich, 8 months ago 
#> ------------------
#>   # R Interface to C API of GLPK
#>   R Interface to C API of GLPK, needs GLPK Version >= 4.42
#> 
#> 7 SnowballC @ 0.5.1                               Milan Bouchet-Valat, about a month ago 
#> -------------------
#>   # Snowball stemmers based on the C libstemmer UTF-8 library
#>   An R interface to the C libstemmer library that implements Porter's word stemming
#>   algorithm for collapsing words to a common root to aid comparison of vocabulary.
#>   Currently supported languages are Danish, Dutch, English, Finnish, French, German,
#>   Hungarian, Italian, Norwegian, Portuguese, Romanian, Russian, Spanish, Swedish and
#>   Turkish.
#>   https://r-forge.r-project.org/projects/r-temis/
#> 
#> 8 getopt @ 1.20.0                                       Trevor L Davis, about a year ago 
#> -----------------
#>   # C-like getopt behavior.
#>   Package designed to be used with Rscript to write ``#!'' shebang scripts that accept
#>   short and long flags/options. Many users will prefer using instead the packages
#>   optparse or argparse which add extra features like automatically generated help
#>   option and usage, support for default values, positional argument support, etc.
#>   https://github.com/trevorld/getopt
#> 
#> 9 BASIX @ 1.1                                             Bastian Pfeifer, 10 months ago 
#> -------------
#>   # BASIX: An efficient C/C++ toolset for R.
#>   BASIX provides some efficient C/C++ implementations to speed up calculations in R.
#> 
#> 10 e1071 @ 1.6-4                                                David Meyer, 13 days ago 
#> ----------------
#>   # Misc Functions of the Department of Statistics (e1071), TU Wien
#>   Functions for latent class analysis, short time Fourier transform, fuzzy clustering,
#>   support vector machines, shortest path computation, bagged clustering, naive Bayes
#>   classifier, ...
```

The `more()` function can be used to display the next batch of search hits,
batches contain ten packages by default:


```r
see("google")
```

```
#> SAW "google" ------------------------------------------ 24 packages in 0.033 seconds --- 
#>  #  # Title     # Package                                                             
#>  1  googleVis   Interface between R and Google Charts                                 
#>  2  RgoogleMaps Overlays on Google map tiles in R                                     
#>  3  ggmap       A package for spatial visualization with Google Maps and OpenStreetMap
#>  4  plotKML     Visualization of spatial and spatio-temporal objects in Google Earth  
#>  5  scholar     Analyse citation data from Google Scholar                             
#>  6  RGA         A Google Analytics API client for R                                   
#>  7  translateR  Bindings for the Google and Microsoft Translation APIs                
#>  8  plusser     A Google+ Interface for R                                             
#>  9  gooJSON     Google JSON Data Interpreter for R                                    
#>  10 translate   Bindings for the Google Translate API v2
```


```r
more()
```

```
#> SAW "google" ------------------------------------------- 24 packages in 0.03 seconds --- 
#>  #  # Title          # Package                                                           
#>  11 ngramr           Retrieve and plot Google n-gram data                                
#>  12 RGoogleAnalytics R Wrapper for the Google Analytics API                              
#>  13 R2G2             Converting R CRAN outputs into Google Earth.                        
#>  14 plotGoogleMaps   Plot spatial or spatio-temporal data over Google Maps               
#>  15 googlePublicData An R library to build Google's Public Data Explorer DSPL Metadata...
#>  16 RWeather         R wrapper around the Yahoo! Weather, Google Weather and NOAA APIs   
#>  17 sysfonts         Loading system fonts into R                                         
#>  18 hashFunction     A collection of non-cryptographic hash functions                    
#>  19 rgauges          R wrapper to Gaug.es API                                            
#>  20 splitstackshape  Functions to split concatenated data, conveniently stack columns ...
```


```r
more()
```

```
#> SAW "google" ------------------------------------------ 24 packages in 0.034 seconds --- 
#>  #  # Title        # Package                                    
#>  21 RPostgreSQL    R interface to the PostgreSQL database system
#>  22 RProtoBuf      R Interface to the Protocol Buffers API      
#>  23 DescTools      Tools for descriptive statistics             
#>  24 HistogramTools Utility Functions for R Histograms
```
