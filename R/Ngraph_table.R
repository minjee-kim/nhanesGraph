

## call data using rnhanes
## outputs the data in a workable dataframe format


##### purpose: create a function that converts the inputted year into a range of years (in string) that is compatible with the RNHANES format

## RNHANES only accepts year inputs that are in the correct cycle
## ex) year = 2008, year = "2008", year = "2008-2009" do not work
## accept a year range that is more flexible
## not sensitive to upper/lower case

#' Year check
#'
#' @param first beginning of the range
#' @param second end of the range
#'
#' @return all cycles between the inputted range of years
#'
year_check <- function(first, second){

  ## find all years between first and second input years
  if(first %% 2 == 1){
    if(second %% 2 == 0){
      range = seq(from = first, to = second, by = 1)
    }else{
      range = seq(from = first, to = second + 1, by = 1)
    }
  }else{
    if(second %% 2 == 0){
      range = seq(from = first - 1, to = second, by = 1)
    }else{
      range = seq(from = first - 1, to = second + 1, by = 1)
    }
  }

  ## want to find the number of odd years within the range of cycles to find how many cycles there are in between
  odd_range = range[which(range %% 2 == 1)]
  range_obj = rep(NA, length(odd_range))

  ## loop over the number of odd years and separate them into appropriate cycles
  for(i in 1:length(odd_range)){
    temp = paste(odd_range[i], odd_range[i]+1, sep = "-")
    range_obj[i] = paste(i, ".", temp, sep = "")
  }
  ## return the object that contains all cycles
  return(range_obj)
}

## year is the range of cycles
#' Loading NHANES data with a flexible year input
#'
#' @param year a numeric value of a year or string objective of a range year
#' @param variables A list or a specific variable the user is interested in. Search for a specific variable using the "nhanesA::nhanesTableVars('EXAM', 'BMX_D')"
#'
#'
#' @return
#' @export
#'
#' @examples
nhanes_table <- function(year, type = NULL, variables = NULL, demographics = F){

  ## making sure the year input isn't empty
  if(is.null(year) == T ){
    stop("empty input for year!") # stopping the code if year is empty
  }else{
    ## if there is a single value for the year, output a message that indicates the cycle

    ## for numeric inputs, make it into a cycle (string) to input into RNHANES
    if(is.numeric(year)){
      if(year < 1999 || year > 2021){ stop("The continuous NHANES starts from 1999 and is only available up to 2020. Please input a valid year or a valid cycle.") }
      if(year %% 2 == 1){
        input_year = paste(year, year + 1 , sep = "-")
      }else{input_year = paste(year - 1, year, sep = "-")}

    }else{ if(is.character(year)){
      ## for string inputs, check whether the input is a cycle or a specific year

      ## check for cycle input
      if(grepl("-*",year) == T){
        first <- as.numeric(sub("\\-.*", "", year)) # get the first part of the specified year range
        last  <- as.numeric(sub(".*-", "", year)) # get the last part of the specified year range

        #### check whether this is a valid cycle
        ## check if first is greater than 1999 and less than 2020
        if(first < 1999 || first > 2020){
          stop("The continuous NHANES starts from 1999 and is only available up to 2020. Please input a valid year or a valid cycle.")
        }else{
          ## check if first is one less than second

          if(first > last){
            stop("The first part of your year input is larger than the second part. Please input a valid cycle or a specific year you would like to see.")
          }else{
            ## the inputted string cycle is correct
            if(first == last - 1){
              input_year = paste(first, last, sep = "-")
            }else{
              ## ask which cycle they want to see
              cat("It seems like your year input contains multiple cycles. Which cycle would you like to see?", sep = '\n')
              cat('\n')
              cat(year_check(first, last), sep = '\n')


              cycle = readline(prompt = "Choose a cycle! Press q if you'd like to exit. ")
              if(cycle == "q"){
                stop("safely exited.")
              }else{
                if(){
                }else{

                }
              }
            }
          }
        }





        ## determine whether the years fall into the same cycle
        ## if not, grab the two cycles and cbind with all the cycles in between



        ## end of string cycle input
        }else{ ## string input non-cycle

          }



    } ## end of string part of year checking
    } ## end of non-null inputs

  } ## end of function


  ## input the cycles into the RNHANES command to retrieve the data of interest
  nhanes_load_data(type = type, year = input_year, demographics = demographics)

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
