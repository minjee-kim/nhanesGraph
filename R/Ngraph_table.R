

## call data using rnhanes
## outputs the data in a workable dataframe format


## create a function that converts the inputted year into a range of years (in string) that is compatible with the RNHANES format


## accept a year range that is more flexible
## not sensitive to upper/lower case

## year is the range of cycles
#' Title
#'
#' @param year String vector that contains a range of years or a specific year
#' @param variables A list or a specific variable the user is interested in. Search for a specific variable using the "nhanesA::nhanesTableVars('EXAM', 'BMX_D')"
#'
#'
#' @return
#' @export
#'
#' @examples
nhanes_table <- function(year, type, variables){
  if(null(year) == T ){
    stop("empty input for year!")
  }else{
    if(grepl("-",year, ignore.case = T) == T){

    }else{
      year = as.numeric(year)
      if(year/2 == 0){

      }
    }

  }



  nhanes_load_data(type, year)
}

## output the dataframe into a publication ready format
##
# Ngraph_table <- function(){
#
# }
