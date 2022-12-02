
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nhanesGraph

<!-- badges: start -->
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
#library(nhanesGraph)

#nhanes_table("EPH","2007-2008")
```

There will be a plot that looks much nicer than this :)
