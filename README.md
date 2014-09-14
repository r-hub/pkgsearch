


# CRAN package search

The `seer` package searches all CRAN packages. It uses a web service,
and a careful weighting that ranks popular packages before less
frequently used ones.

## Installation

Install the package from github, using `devtools`:


```r
devtools::install_github("metacran/seer")
```

## Usage

The current API is very minimal, there is a single `seer()` function
that can be used to search. Here are some example searches.


```r
library(seer)
seer("C++")
```

```
#> SEER: C++ -------------------------------------------------------------------------------
#>  + 1021 packages in 0.229 seconds
#>  Package      Title                                                                     
#>  Rcpp         Seamless R and C++ Integration                                            
#>  BH           Boost C++ header files                                                    
#>  inline       Inline C, C++, Fortran function calls from R                              
#>  geometry     Mesh generation and surface tesselation                                   
#>  optimx       A Replacement and Extension of the optim() Function                       
#>  glpkAPI      R Interface to C API of GLPK                                              
#>  SnowballC    Snowball stemmers based on the C libstemmer UTF-8 library                 
#>  getopt       C-like getopt behavior.                                                   
#>  BASIX        BASIX: An efficient C/C++ toolset for R.                                  
#>  e1071        Misc Functions of the Department of Statistics (e1071), TU Wien           
#>  Rcgmin       Conjugate gradient minimization of nonlinear functions with box constra...
#>  colorspace   Color Space Manipulation                                                  
#>  RcppProgress An interruptible progress bar with OpenMP support for c++ in R packages   
#>  boot         Bootstrap Functions (originally by Angelo Canty for S)                    
#>  cplexAPI     R Interface to C API of IBM ILOG CPLEX                                    
#>  fts          R interface to tslib (a time series library in c++)                       
#>  cladoRcpp    C++ implementations of phylogenetic cladogenesis calculations             
#>  survC1       C-statistics for risk prediction models with censored survival data       
#>  LiblineaR    Linear Predictive Models Based On The Liblinear C/C++ Library.            
#>  CDVine       Statistical inference of C- and D-vine copulas
```


```r
seer("survival")
```

```
#> SEER: survival --------------------------------------------------------------------------
#>  + 307 packages in 0.111 seconds
#>  Package              Title                                                             
#>  survival             Survival Analysis                                                 
#>  KMsurv               Data sets from Klein and Moeschberger (1997), Survival Analysis   
#>  riskRegression       Risk regression for survival analysis                             
#>  timereg              Flexible regression models for survival data.                     
#>  survivalROC          Time-dependent ROC curve estimation from censored survival data   
#>  rpart                Recursive Partitioning and Regression Trees                       
#>  prodlim              Product-limit estimation. Kaplan-Meier and Aalen-Johansson meth...
#>  pec                  Prediction Error Curves for Survival Models                       
#>  CoxBoost             Cox models by likelihood based boosting for a single survival e...
#>  randomForestSRC      Random Forests for Survival, Regression and Classification (RF-...
#>  relsurv              Relative survival                                                 
#>  survrec              Survival analysis for recurrent event data                        
#>  JM                   Joint Modeling of Longitudinal and Survival Data                  
#>  p3state.msm          Analyzing survival data                                           
#>  muhaz                Hazard Function Estimation in Survival Analysis                   
#>  flexsurv             Flexible parametric survival models                               
#>  survC1               C-statistics for risk prediction models with censored survival ...
#>  smoothSurv           Survival Regression with Smoothed Error Distribution              
#>  risksetROC           Riskset ROC curve estimation from censored survival data          
#>  complex.surv.dat.sim Simulation of complex survival data
```


```r
seer("google")
```

```
#> SEER: google ----------------------------------------------------------------------------
#>  + 24 packages in 0.037 seconds
#>  Package          Title                                                                 
#>  googleVis        Interface between R and Google Charts                                 
#>  RgoogleMaps      Overlays on Google map tiles in R                                     
#>  ggmap            A package for spatial visualization with Google Maps and OpenStreet...
#>  plotKML          Visualization of spatial and spatio-temporal objects in Google Eart...
#>  scholar          Analyse citation data from Google Scholar                             
#>  RGA              A Google Analytics API client for R                                   
#>  translateR       Bindings for the Google and Microsoft Translation APIs                
#>  plusser          A Google+ Interface for R                                             
#>  gooJSON          Google JSON Data Interpreter for R                                    
#>  translate        Bindings for the Google Translate API v2                              
#>  ngramr           Retrieve and plot Google n-gram data                                  
#>  RGoogleAnalytics R Wrapper for the Google Analytics API                                
#>  R2G2             Converting R CRAN outputs into Google Earth.                          
#>  plotGoogleMaps   Plot spatial or spatio-temporal data over Google Maps                 
#>  googlePublicData An R library to build Google's Public Data Explorer DSPL Metadata f...
#>  RWeather         R wrapper around the Yahoo! Weather, Google Weather and NOAA APIs     
#>  sysfonts         Loading system fonts into R                                           
#>  hashFunction     A collection of non-cryptographic hash functions                      
#>  rgauges          R wrapper to Gaug.es API                                              
#>  splitstackshape  Functions to split concatenated data, conveniently stack columns of...
```
