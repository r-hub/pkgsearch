
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgsearch

> Get/search CRAN metadata about packages by keyword, popularity, recent
> activity, package name and
more.

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

`pkgsearch` uses two R-hub web services
([crandb](http://crandb.r-pkg.org) and
[search](https://github.com/metacran/search)) that **munge CRAN metadata
and let you access it through several lenses**:

## Search relevant packages

Do you need to find packages solving a particular problem, e.g.
“permutation test”?

``` r
library("pkgsearch")
pkg_search("permutation test")
```

    #> - "permutation test" ----------------------------------- 1814 packages in 0.015 seconds - 
    #>   #     package        version by                      @ title                           
    #>   1 100 coin           1.3.1   Torsten Hothorn        2M Conditional Inference Procedu...
    #>   2  33 flip           2.5.0   Livio Finos            1y Multivariate Permutation Tests  
    #>   3  31 exactRankTests 0.8.30  Torsten Hothorn        6M Exact Distributions for Rank ...
    #>   4  31 perm           1.0.0.0 Michael Fay            9y Exact or Asymptotic permutati...
    #>   5  25 jmuOutlier     2.2     Steven T. Garren       3M Permutation Tests for Nonpara...
    #>   6  21 wPerm          1.0.1   Neil A. Weiss          4y Permutation Tests               
    #>   7  18 cpt            1.0.2   Johann Gagnon-Bartsch  1y Classification Permutation Test 
    #>   8  18 permutes       1.0     Cesko C. Voeten        3M Permutation Tests for Time Se...
    #>   9  18 GlobalDeviance 0.4     Frederike Fuhlbrueck   6y Global Deviance Permutation T...
    #>  10  17 AUtests        0.98    Arjun Sondhi           3y Approximate Unconditional and...

## Get package metadata

Do you want to find the dependencies the first versions of `testthat`
had and when each of these versions was released?

``` r
cran_package_history("testthat")
```

    #> # A tibble: 24 x 25
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
    #> # … with 14 more rows, and 15 more variables: Collate <chr>, Packaged <chr>,
    #> #   Repository <chr>, `Date/Publication` <chr>, crandb_file_date <chr>, date <chr>,
    #> #   dependencies <list>, NeedsCompilation <chr>, Roxygen <chr>, `Authors@R` <chr>,
    #> #   BugReports <chr>, RoxygenNote <chr>, VignetteBuilder <chr>, Encoding <chr>,
    #> #   MD5sum <chr>

## Discover packages

Do you want to know what packages are trending on CRAN these days?
`pkgsearch` can help\!

``` r
cran_trending()
```

    #> # A tibble: 100 x 2
    #>    package      score                
    #>    <chr>        <chr>                
    #>  1 random       3722.1369057343571300
    #>  2 fastmap      1539.8451530510436200
    #>  3 fuzzyforest  760.9407561774337600 
    #>  4 KernSmooth   629.8441807874601200 
    #>  5 cyclocomp    576.5858358760237700 
    #>  6 argparse     491.8775831283479200 
    #>  7 sets         486.9589461211403100 
    #>  8 binaryLogic  460.2492479587451700 
    #>  9 xmlparsedata 454.5915595000905600 
    #> 10 bayesAB      452.1981856245638500 
    #> # … with 90 more rows

``` r
cran_top_downloaded()
```

    #> # A tibble: 100 x 2
    #>    package         count 
    #>    <chr>           <chr> 
    #>  1 magrittr        798346
    #>  2 aws.s3          656735
    #>  3 aws.ec2metadata 648554
    #>  4 rsconnect       629664
    #>  5 rlang           356338
    #>  6 digest          286965
    #>  7 dplyr           265725
    #>  8 Rcpp            247808
    #>  9 ellipsis        245921
    #> 10 ggplot2         234535
    #> # … with 90 more rows

## Keep up with CRAN

are you curious about the latest releases or
    archivals?

``` r
cran_events()
```

    #> CRAN events (events)---------------------------------------------------------------------
    #>  . When     Package       Version Title                                                  
    #>  + 3 hours  mlr3learners  0.1.4   Recommended Learners for 'mlr3'                        
    #>  + 5 hours  PAutilities   0.3.0   Streamline Physical Activity Research                  
    #>  + 5 hours  mlr3pipelines 0.1.1   Preprocessing Operators and Pipelines for 'mlr3'       
    #>  + 5 hours  openxlsx      4.1.2   Read, Write and Edit xlsx Files                        
    #>  + 5 hours  ritis         0.8.0   Integrated Taxonomic Information System Client         
    #>  + 6 hours  shinybusy     0.2.0   Busy Indicator for 'Shiny' Applications                
    #>  + 6 hours  krige         0.3-1   Geospatial Kriging with Metropolis Sampling            
    #>  + 7 hours  StepReg       1.3.1   Stepwise Regression Analysis                           
    #>  + 7 hours  ADAPTS        0.9.26  Automated Deconvolution Augmentation of Profiles for...
    #>  + 13 hours SemNeT        1.1.2   Methods and Measures for Semantic Network Analysis

## More info

Find out more in [the documentation
website](https://r-hub.github.io/pkgsearch/), in particular the
[function
reference](https://r-hub.github.io/pkgsearch/reference/index.html) and
[the vignette about search
features](https://r-hub.github.io/pkgsearch/articles/search.html).

## Installation

You can install the package from CRAN:

``` r
install.packages("pkgsearch")
```

Or the development version from GitHub:

``` r
remotes::install_github("r-hub/pkgsearch")
```

## License

MIT @ [Gábor Csárdi](https://github.com/gaborcsardi),
[RStudio](https://github.com/rstudio), [R
Consortium](https://www.r-consortium.org/).
