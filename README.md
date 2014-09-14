


# CRAN package search

[![Linux Build Status](https://travis-ci.org/metacran/seer.png?branch=master)](https://travis-ci.org/metacran/seer)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/2tdve2yyct7ix1u8)](https://ci.appveyor.com/project/gaborcsardi/seer)

The `seer` package searches all CRAN packages. It uses a web service,
and a careful weighting that ranks popular packages before less
frequently used ones.

## Installation

Install the package from github, using `devtools`:


```r
devtools::install_github("metacran/seer")
```

## Usage

The current API is very minimal, there is a single `see()` function
that can be used to search. Here are some example searches.


```r
library(seer)
see("C++")
```

```
#> SEER: C++ -------------------------------------------------------------------------------
#>  + 1022 packages in 0.197 seconds
#> 
#> Rcpp @ 0.11.2                                            Dirk Eddelbuettel, 3 months ago 
#> -------------
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
#> BH @ 1.54.0-4                                             Dirk Eddelbuettel, 15 days ago 
#> -------------
#>   # Boost C++ header files
#>   Boost provides free peer-reviewed portable C++ source libraries.  A large part of
#>   Boost is provided as C++ template code which is resolved entirely at compile-time
#>   without linking.  This package aims to provide the most useful subset of Boost
#>   libraries for template use among CRAN package. By placing these libraries in this
#>   package, we offer a more efficient distribution system for CRAN as replication of
#>   this code in the sources of other packages is avoided.
#> 
#> inline @ 0.3.13                                      Dirk Eddelbuettel, about a year ago 
#> ---------------
#>   # Inline C, C++, Fortran function calls from R
#>   Functionality to dynamically define R functions and S4 methods with in-lined C, C++
#>   or Fortran code supporting .C and .Call calling conventions.
#> 
#> geometry @ 0.3-4                                         David C. Sterratt, 6 months ago 
#> ----------------
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
#> optimx @ 2013.8.6                                          John C Nash, about a year ago 
#> -----------------
#>   # A Replacement and Extension of the optim() Function
#>   Provides a replacement and extension of the optim() function to unify and streamline
#>   optimization capabilities in R for smooth, possibly box constrained functions of
#>   several or many parameters. This is the CRAN version of the package.
#> 
#> glpkAPI @ 1.2.10                                   Gabriel Gelius-Dietrich, 8 months ago 
#> ----------------
#>   # R Interface to C API of GLPK
#>   R Interface to C API of GLPK, needs GLPK Version >= 4.42
#> 
#> SnowballC @ 0.5.1                                 Milan Bouchet-Valat, about a month ago 
#> -----------------
#>   # Snowball stemmers based on the C libstemmer UTF-8 library
#>   An R interface to the C libstemmer library that implements Porter's word stemming
#>   algorithm for collapsing words to a common root to aid comparison of vocabulary.
#>   Currently supported languages are Danish, Dutch, English, Finnish, French, German,
#>   Hungarian, Italian, Norwegian, Portuguese, Romanian, Russian, Spanish, Swedish and
#>   Turkish.
#>   https://r-forge.r-project.org/projects/r-temis/
#> 
#> getopt @ 1.20.0                                         Trevor L Davis, about a year ago 
#> ---------------
#>   # C-like getopt behavior.
#>   Package designed to be used with Rscript to write ``#!'' shebang scripts that accept
#>   short and long flags/options. Many users will prefer using instead the packages
#>   optparse or argparse which add extra features like automatically generated help
#>   option and usage, support for default values, positional argument support, etc.
#>   https://github.com/trevorld/getopt
#> 
#> BASIX @ 1.1                                               Bastian Pfeifer, 10 months ago 
#> -----------
#>   # BASIX: An efficient C/C++ toolset for R.
#>   BASIX provides some efficient C/C++ implementations to speed up calculations in R.
#> 
#> e1071 @ 1.6-4                                                   David Meyer, 12 days ago 
#> -------------
#>   # Misc Functions of the Department of Statistics (e1071), TU Wien
#>   Functions for latent class analysis, short time Fourier transform, fuzzy clustering,
#>   support vector machines, shortest path computation, bagged clustering, naive Bayes
#>   classifier, ...
```


```r
see("survival")
```

```
#> SEER: survival --------------------------------------------------------------------------
#>  + 307 packages in 0.089 seconds
#> 
#> survival @ 2.37-7                                         Terry M Therneau, 7 months ago 
#> -----------------
#>   # Survival Analysis
#>   survival analysis: descriptive statistics, two-sample tests, parametric accelerated
#>   failure models, Cox model. Delayed entry (truncation) allowed for all models;
#>   interval censoring for parametric models. Case-cohort designs.
#>   http://r-forge.r-project.org
#> 
#> KMsurv @ 0.1-5                                                      Jun Yan, 1 years ago 
#> --------------
#>   # Data sets from Klein and Moeschberger (1997), Survival Analysis
#>   Data sets and functions for Klein and Moeschberger (1997), "Survival Analysis,
#>   Techniques for Censored and Truncated Data", Springer.
#> 
#> riskRegression @ 0.0.8                               Thomas Alexander Gerds, 1 years ago 
#> ----------------------
#>   # Risk regression for survival analysis
#>   Risk regression models for survival analysis with and without competing risks
#> 
#> timereg @ 1.8.5                                             Thomas Scheike, 3 months ago 
#> ---------------
#>   # Flexible regression models for survival data.
#>   Programs for Martinussen and Scheike (2006), `Dynamic Regression Models for Survival
#>   Data', Springer Verlag.  Plus more recent developments. Additive survival model,
#>   semiparametric proportional odds model, fast cumulative residuals, excess risk models
#>   and more. Flexible competing risks regression including GOF-tests. Two-stage frailty
#>   modelling. PLS for the additive risk model. Lasso in ahaz package.
#> 
#> survivalROC @ 1.0.3                                 Paramita Saha-Chaudhuri, 1 years ago 
#> -------------------
#>   # Time-dependent ROC curve estimation from censored survival data
#>   Compute time-dependent ROC curve from censored survival data using Kaplan-Meier (KM)
#>   or Nearest Neighbor Estimation (NNE) method of Heagerty, Lumley & Pepe (Biometrics,
#>   Vol 56 No 2, 2000, PP 337-344)
#> 
#> rpart @ 4.1-8                                                 Brian Ripley, 5 months ago 
#> -------------
#>   # Recursive Partitioning and Regression Trees
#>   Recursive partitioning for classification, regression and survival trees.  An
#>   implementation of most of the functionality of the 1984 book by Breiman, Friedman,
#>   Olshen and Stone.
#> 
#> prodlim @ 1.4.5                                             Thomas A. Gerds, 11 days ago 
#> ---------------
#>   # Product-limit estimation. Kaplan-Meier and Aalen-Johansson method for censored
#>     event history (survival) analysis
#>   Fast and user friendly implementation of nonparametric estimators for censored event
#>   history (survival) analysis.
#> 
#> pec @ 2.3.7                                                  Thomas A. Gerds, 8 days ago 
#> -----------
#>   # Prediction Error Curves for Survival Models
#>   Validation of predicted survival probabilities using inverse weighting and
#>   resampling.
#> 
#> CoxBoost @ 1.4                                           Harald Binder, about a year ago 
#> --------------
#>   # Cox models by likelihood based boosting for a single survival endpoint or competing
#>     risks
#>   This package provides routines for fitting Cox models by likelihood based boosting
#>   for a single endpoint or in presence of competing risks
#> 
#> randomForestSRC @ 1.5.5                                    Udaya B. Kogalur, 18 days ago 
#> -----------------------
#>   # Random Forests for Survival, Regression and Classification (RF-SRC)
#>   A unified treatment of Breiman's random forests for survival, regression and
#>   classification problems based on Ishwaran and Kogalur's random survival forests (RSF)
#>   package.  The package runs in both serial and parallel (OpenMP) modes.
#>   http://web.ccs.miami.edu/~hishwaran
#>   http://www.kogalur.com
```


```r
see("google")
```

```
#> SEER: google ----------------------------------------------------------------------------
#>  + 24 packages in 0.036 seconds
#> 
#> googleVis @ 0.5.5                                            Markus Gesmann, 28 days ago 
#> -----------------
#>   # Interface between R and Google Charts
#>   The googleVis package provides an interface between R and the Google Charts API. It
#>   allows users to create web pages with interactive charts based on R data frames,
#>   using the Google Charts API. The package provides plot methods in R to display the
#>   charts locally with the R HTTP help server without uploading the data to Google. A
#>   modern browser with Internet connection is required and for some charts Flash.
#>   http://github.com/mages/googleVis
#> 
#> RgoogleMaps @ 1.2.0.6                                       Markus Loecher, 4 months ago 
#> ---------------------
#>   # Overlays on Google map tiles in R
#>   This package serves two purposes: (i) Provide a comfortable R interface to query the
#>   Google server for static maps, and (ii) Use the map as a background image to overlay
#>   plots within R. This requires proper coordinate scaling.
#> 
#> ggmap @ 2.3                                                David Kahle, about a year ago 
#> -----------
#>   # A package for spatial visualization with Google Maps and OpenStreetMap
#>   ggmap allows for the easy visualization of spatial data and models on top of Google
#>   Maps, OpenStreetMaps, Stamen Maps, or CloudMade Maps using ggplot2.
#> 
#> plotKML @ 0.4-5                                        Tomislav Hengl, about a month ago 
#> ---------------
#>   # Visualization of spatial and spatio-temporal objects in Google Earth
#>   Writes sp-class, spacetime-class, raster-class and similar spatial and
#>   spatio-temporal objects to KML following some basic cartographic rules.
#>   http://plotkml.r-forge.r-project.org/
#> 
#> scholar @ 0.1.2                                             James Keirstead, 22 days ago 
#> ---------------
#>   # Analyse citation data from Google Scholar
#>   scholar provides functions to extract citation data from Google Scholar.  Convenience
#>   functions are also provided for comparing multiple scholars and predicting future
#>   h-index values.
#> 
#> RGA @ 0.1.2                                                  Artem Klevtsov, 12 days ago 
#> -----------
#>   # A Google Analytics API client for R
#>   Provides functions for accessing and retrieving data from the Google Analytics APIs
#>   (https://developers.google.com/analytics/). Supports OAuth 2.0 authorization. Package
#>   provides access to the Management, Core Reporting, Multi-Channel Funnels Reporting,
#>   Real Time Reporting and Metadata APIs. Access to all the Google Analytics accounts
#>   which the user has access to. Auto-pagination to return more than 10,000 rows of the
#>   results by combining multiple data requests. Also the RGA package provides shiny app
#>   to explore the core reporting API dimensions and metrics.
#>   https://bitbucket.org/unikum/rga
#> 
#> translateR @ 1.0                                         Christopher Lucas, 2 months ago 
#> ----------------
#>   # Bindings for the Google and Microsoft Translation APIs
#>   translateR provides easy access to the Google and Microsoft APIs. The package is easy
#>   to use with the related R package "stm" for the estimation of multilingual topic
#>   models.
#> 
#> plusser @ 0.4-0                                       Christoph Waldhauser, 4 months ago 
#> ---------------
#>   # A Google+ Interface for R
#>   plusser provides an API interface to Google+ so that posts, profiles and pages can be
#>   automatically retrieved.
#>   http://kdss.at
#> 
#> gooJSON @ 1.0.01                                          <cmarcum@uci.edu>, 2 years ago 
#> ----------------
#>   # Google JSON Data Interpreter for R
#>   A suite of helper functions for obtaining data from the Google Maps API JSON objects.
#>   Calls Google Maps API and returns results as an R data frame.
#> 
#> translate @ 0.1.2                                          Peter Danenberg, 2 months ago 
#> -----------------
#>   # Bindings for the Google Translate API v2
#>   Bindings for the Google Translate API v2
```
