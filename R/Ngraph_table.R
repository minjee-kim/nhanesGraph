

## call data using rnhanes
## outputs the data in a workable dataframe format


##### purpose: create a function that converts the inputted year into a range of years (in string) that is compatible with the RNHANES format

## RNHANES only accpets years that are
## accept a year range that is more flexible
## not sensitive to upper/lower case

## year is the range of cycles
#' Create a data frame with specified parameters
#'
#' @param year String vector that contains a range of years or a specific year
#' @param variables A list or a specific variable the user is interested in. Search for a specific variable using the "nhanesA::nhanesTableVars('EXAM', 'BMX_D')"
#'
#'
#' @return
#' @export
#'
#' @examples
nhanes_table <- function(year, variables){

  if(null(year) == T ){
    stop("empty input for year!")
  }else{
    if(grepl("-*",year, ignore.case = T) == T){
      first <- sub("-", "", year) # get the first part of the specified year range
      last  <- sub("-", "", year) # get the last part of the specified year range
      ## determine whether the years fall into the same cycle
      ## if not, grab the two cycles and cbind with all the cycles in between
    }else{
      ## if the user inputted year as a single year
      year = as.numeric(year)
      if(year/2 == 0){
        year = paste(year, "-", year-1, sep = "")
      }
    }

  }


  ## input the cycles into the RNHANES command to retrieve the data of interest
  nhanes_load_data(type, year)

  ## filter the data for the specific variables
}

## output the dataframe into a publication ready format

#' Title
#'
#' @inheritParams nhanes_table
#' @param year
#' @param variables
#'
#' @return
#'
#'
#' @examples
Ngraph_table <- function(year, variables){

}
