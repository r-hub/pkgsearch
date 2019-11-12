
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

`pkgsearch` uses R-hub web services that munge CRAN metadata and let you
access it through several lenses.

## Search relevant packages

Do you need to find packages solving a particular problem, e.g.
“permutation test”?

``` r
library("pkgsearch")
pkg_search("permutation test")
```

    #> - "permutation test" ----------------------------------- 1830 packages in 0.018 seconds - 
    #>   #     package        version by                      @ title                           
    #>   1 100 coin           1.3.1   Torsten Hothorn        3M Conditional Inference Procedu...
    #>   2  33 flip           2.5.0   Livio Finos            1y Multivariate Permutation Tests  
    #>   3  30 exactRankTests 0.8.30  Torsten Hothorn        7M Exact Distributions for Rank ...
    #>   4  30 perm           1.0.0.0 Michael Fay            9y Exact or Asymptotic permutati...
    #>   5  25 jmuOutlier     2.2     Steven T. Garren       3M Permutation Tests for Nonpara...
    #>   6  21 wPerm          1.0.1   Neil A. Weiss          4y Permutation Tests               
    #>   7  18 cpt            1.0.2   Johann Gagnon-Bartsch  1y Classification Permutation Test 
    #>   8  18 permutes       1.0     Cesko C. Voeten        4M Permutation Tests for Time Se...
    #>   9  18 GlobalDeviance 0.4     Frederike Fuhlbrueck   6y Global Deviance Permutation T...
    #>  10  17 AUtests        0.98    Arjun Sondhi           3y Approximate Unconditional and...

## Get package metadata

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

## Discover packages

Do you want to know what packages are trending on CRAN these days?
`pkgsearch` can help\!

``` r
cran_trending()
```

    #> # A tibble: 100 x 2
    #>    package        score                
    #>    <chr>          <chr>                
    #>  1 igraph0        1389.0109890109890100
    #>  2 dplyr.teradata 1358.5142558200366200
    #>  3 fable          1332.6763165999384000
    #>  4 feasts         980.8879741252572800 
    #>  5 fabletools     704.7784535186794100 
    #>  6 AzureGraph     659.8372426998563900 
    #>  7 fastmap        633.5330920730576100 
    #>  8 tsibble        414.2869064508053100 
    #>  9 gridSVG        409.2129507765201400 
    #> 10 echarts4r      401.4556598352806000 
    #> # … with 90 more rows

``` r
cran_top_downloaded()
```

    #> # A tibble: 100 x 2
    #>    package         count 
    #>    <chr>           <chr> 
    #>  1 magrittr        840456
    #>  2 aws.s3          696673
    #>  3 aws.ec2metadata 689101
    #>  4 rsconnect       671446
    #>  5 rlang           344355
    #>  6 Rcpp            264163
    #>  7 dplyr           253173
    #>  8 ellipsis        238927
    #>  9 digest          226958
    #> 10 ggplot2         222781
    #> # … with 90 more rows

## Keep up with CRAN

Are you curious about the latest releases or
    archivals?

``` r
cran_events()
```

    #> CRAN events (events)---------------------------------------------------------------------
    #>  . When    Package      Version Title                                                    
    #>  + 3 hours lime         0.5.1   Local Interpretable Model-Agnostic Explanations          
    #>  + 3 hours bestglm      0.37.1  Best Subset GLM and Regression Utilities                 
    #>  + 4 hours kernlab      0.9-29  Kernel-Based Machine Learning Lab                        
    #>  + 4 hours AzureAuth    1.2.3   Authentication Services for Azure Active Directory       
    #>  + 4 hours CondIndTests 0.1.5   Nonlinear Conditional Independence Tests                 
    #>  + 4 hours plotKML      0.6-0   Visualization of Spatial and Spatio-Temporal Objects i...
    #>  + 4 hours surveillance 1.17.2  Temporal and Spatio-Temporal Modeling and Monitoring o...
    #>  + 5 hours rayshader    0.13.1  Create and Visualize Hillshaded Maps from Elevation Ma...
    #>  + 5 hours qgcomp       1.2.0   Quantile G-Computation                                   
    #>  + 6 hours enveomics.R  1.6.0   Various Utilities for Microbial Genomics and Metagenom...

## More info

Find out more in [the documentation
website](https://r-hub.github.io/pkgsearch/), in particular the
[function
reference](https://r-hub.github.io/pkgsearch/reference/index.html) and
[the vignette about search
features](https://r-hub.github.io/pkgsearch/articles/search.html).

## Installation

Install the latest pkgsearch release from CRAN:

``` r
install.packages("pkgsearch")
```

## License

MIT @ [Gábor Csárdi](https://github.com/gaborcsardi),
[RStudio](https://github.com/rstudio), [R
Consortium](https://www.r-consortium.org/).
