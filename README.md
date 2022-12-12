
<!-- README.md is generated from README.Rmd. Please edit that file -->

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

## Data Loading via nhanes_table function

From the console, the NHANES data can be accessed via nhanes_table()
function by specifying the cycle (or a specific year), file name, and
whether to include demographic information for the samples in the data
in the loaded data. The demographics parameter is False by default. The
recode parameter allows users to load the data with descriptive
categorical variables. By default, recode is False.

``` r
library(nhanesGraph)

head(nhanes_table("2008", "EPH", demographics = T, recode = F))
#> Downloading EPH_E.XPT to /var/folders/cb/pm2sn91x1kl5y2ch704fh_8c0000gn/T//RtmpcKLleM/EPH_E.XPT
#> Downloading DEMO_E.XPT to /var/folders/cb/pm2sn91x1kl5y2ch704fh_8c0000gn/T//RtmpcKLleM/DEMO_E.XPT
#> Caching CSV to /var/folders/cb/pm2sn91x1kl5y2ch704fh_8c0000gn/T//RtmpcKLleM/DEMO_E.csv
#>    SEQN     cycle SDDSRVYR RIDSTATR RIDEXMON RIAGENDR RIDAGEYR RIDAGEMN
#> 1 41476 2007-2008        5        2        1        2        6       81
#> 2 41479 2007-2008        5        2        1        1       52      629
#> 3 41486 2007-2008        5        2        1        2       61      734
#> 4 41489 2007-2008        5        2        1        2       40      482
#> 5 41492 2007-2008        5        2        2        1       72      866
#> 6 41496 2007-2008        5        2        2        2       64      776
#>   RIDAGEEX RIDRETH1 DMQMILIT DMDBORN2 DMDCITZN DMDYRSUS DMDEDUC3 DMDEDUC2
#> 1       82        5       NA        1        1       NA        0       NA
#> 2      630        1        2        2        1        6       NA        1
#> 3      735        1        2        2        1        8       NA        1
#> 4      483        1        2        1        1       NA       NA        3
#> 5      866        3        2        5        1        4       NA        1
#> 6      777        1        2        2        2        4       NA        1
#>   DMDSCHOL DMDMARTL DMDHHSIZ DMDFMSIZ INDHHIN2 INDFMIN2 INDFMPIR RIDEXPRG
#> 1       NA       NA        6        6       15       15     5.00       NA
#> 2       NA        1        5        5        8        8     2.20       NA
#> 3       NA        1        3        3        6        6     1.75       NA
#> 4       NA        1        3        3        7        7     2.15        2
#> 5       NA        1        2        2        3        3     1.02       NA
#> 6       NA        4        1        1        2        2     0.59       NA
#>   DMDHRGND DMDHRAGE DMDHRBR2 DMDHREDU DMDHRMAR DMDHSEDU SIALANG SIAPROXY
#> 1        1       51        1        5        1        5       1        1
#> 2        1       52        2        1        1        3       2        2
#> 3        1       67        2        1        1        1       2        2
#> 4        2       40        1        3        1        3       1        2
#> 5        2       68        4        3        1        1       1        2
#> 6        2       64        2        1        4       NA       2        2
#>   SIAINTRP FIALANG FIAPROXY FIAINTRP MIALANG MIAPROXY MIAINTRP AIALANG
#> 1        2       1        2        2      NA       NA       NA      NA
#> 2        2       1        2        2       2        2        2       2
#> 3        2       2        2        2       2        2        2       2
#> 4        2       1        2        2       1        2        2       1
#> 5        2       1        2        2       1        2        2       1
#> 6        2       2        2        2       2        2        2       2
#>    WTINT2YR  WTMEC2YR SDMVPSU SDMVSTRA   WTSB2YR URXUCR URX4TO URD4TOLC URXBP3
#> 1 35057.218 35353.210       1       70 120437.91     72   0.14        1    5.5
#> 2  8727.798  9234.056       1       70  30191.58    124   0.14        1   31.2
#> 3  5155.139  5436.241       1       73  17219.29     72   0.14        1   50.5
#> 4 25274.173 25651.324       1       66  77564.82     91   0.14        1   85.0
#> 5  7782.354  8620.700       1       62  25621.60     49   0.14        1    1.2
#> 6  7480.950  7390.024       1       71  23407.90     NA     NA       NA     NA
#>   URDBP3LC URXBPH URDBPHLC URXTRS URDTRSLC URXBUP URDBUPLC URXEPB URDEPBLC
#> 1        0    2.3        0   75.5        0   0.14        1   1.90        0
#> 2        0    1.1        0    7.4        0   1.40        0   4.40        0
#> 3        0    1.0        0  479.0        0   0.14        1   0.71        1
#> 4        0    1.5        0    9.4        0  21.10        0   2.00        0
#> 5        0    0.6        0   29.9        0   0.14        1   0.71        1
#> 6       NA     NA       NA     NA       NA     NA       NA     NA       NA
#>   URXMPB URDMPBLC URXPPB URDPPBLC file_name begin_year end_year
#> 1   15.8        0    0.8        0     EPH_E       2007     2008
#> 2  105.0        0    3.2        0     EPH_E       2007     2008
#> 3  235.0        0    1.4        0     EPH_E       2007     2008
#> 4  140.0        0   51.2        0     EPH_E       2007     2008
#> 5    4.8        0    0.3        0     EPH_E       2007     2008
#> 6     NA       NA     NA       NA     EPH_E       2007     2008
```

### File Search

In order to specify the year and file inputs in the nhanes_table
function, users can explore the NHANES files with nGraph_search Shiny
app. The Shiny app can be launched with the folloing code:

``` r
nGraph_search()
```

## Variable Visualization
