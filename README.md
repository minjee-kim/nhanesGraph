
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nhanesGraph

<!-- badges: start -->

[![R-CMD-check](https://github.com/minjee-kim/nhanesGraph/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/minjee-kim/nhanesGraph/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of nhanesGraph is to provide an interactive graphical tools for
the users to access more easily. This package utilizes RNHANES, nhanesA,
and Shiny packages.

# Intermediate Project Update

So far, I have a function that retrieves data from the CDC website with
more flexible commands and a function that outputs the data into a
publication ready table.

To do:  
make the vignette look much nicer  
finish writing the function that outputs publication ready tables using
the sjPlot package <br> add variable search via nhanesA <br> finish the
function for interactive plots  
finish documentation <br> make the nhnaes_table to allow:  
 1. make the input case insensitive  
 2. downloading without year specification  
 3. if type and variables do not agree (variables specified by the user
are not in the specified type), ask if the user wants both (display yes
or no)

## Installation

You can install the development version of nhanesGraph from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("minjee-kim/nhanesGraph")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(nhanesGraph)

head(nhanes_table("2007-2008", "EPH"))
#> [1] 2007
#> [1] 2008
#> Downloading EPH_E.XPT to /var/folders/cb/pm2sn91x1kl5y2ch704fh_8c0000gn/T//Rtmp76CKAr/EPH_E.XPT
#>    SEQN   WTSB2YR URXUCR URX4TO URD4TOLC URXBP3 URDBP3LC URXBPH URDBPHLC URXTRS
#> 1 41476 120437.91     72   0.14        1    5.5        0    2.3        0   75.5
#> 2 41479  30191.58    124   0.14        1   31.2        0    1.1        0    7.4
#> 3 41486  17219.29     72   0.14        1   50.5        0    1.0        0  479.0
#> 4 41489  77564.82     91   0.14        1   85.0        0    1.5        0    9.4
#> 5 41492  25621.60     49   0.14        1    1.2        0    0.6        0   29.9
#> 6 41496  23407.90     NA     NA       NA     NA       NA     NA       NA     NA
#>   URDTRSLC URXBUP URDBUPLC URXEPB URDEPBLC URXMPB URDMPBLC URXPPB URDPPBLC
#> 1        0   0.14        1   1.90        0   15.8        0    0.8        0
#> 2        0   1.40        0   4.40        0  105.0        0    3.2        0
#> 3        0   0.14        1   0.71        1  235.0        0    1.4        0
#> 4        0  21.10        0   2.00        0  140.0        0   51.2        0
#> 5        0   0.14        1   0.71        1    4.8        0    0.3        0
#> 6       NA     NA       NA     NA       NA     NA       NA     NA       NA
#>   file_name     cycle begin_year end_year
#> 1     EPH_E 2007-2008       2007     2008
#> 2     EPH_E 2007-2008       2007     2008
#> 3     EPH_E 2007-2008       2007     2008
#> 4     EPH_E 2007-2008       2007     2008
#> 5     EPH_E 2007-2008       2007     2008
#> 6     EPH_E 2007-2008       2007     2008
```

There will be a plot that looks much nicer than this :)
