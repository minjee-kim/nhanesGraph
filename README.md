
<!-- README.md is generated from README.Rmd. Please edit that file -->

CODECOV_TOKEN=52721b18-0aff-4ed8-b515-2c348f7cc091

# nhanesGraph

<!-- badges: start -->

[![R-CMD-check](https://github.com/minjee-kim/nhanesGraph/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/minjee-kim/nhanesGraph/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

nhanesGraph is a package that provides an accessible and interactive way
for users to export NHANES data as well as view data trends via Shiny
package. This package is an extension of the
[RNHANES](https://cran.r-project.org/web/packages/RNHANES/vignettes/introduction.html)
package created by Herb Susmann.

## Installation

You can install the development version of nhanesGraph from
[GitHub](https://github.com/minjee-kim/nhanesGraph) with:

``` r
# install.packages("devtools")
devtools::install_github("minjee-kim/nhanesGraph")
```

## Example

Users are able to search the NHANES file of interest via nGraph_search()
Shiny app.

For a console command, users can access nhanes_table function

``` r
library(nhanesGraph)

#nGraph_search()
head(nhanes_table("2007-2008", "EPH"))
#> Downloading EPH_E.XPT to /var/folders/cb/pm2sn91x1kl5y2ch704fh_8c0000gn/T//Rtmp8czzXi/EPH_E.XPT
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
