

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


#' Loading NHANES data with a flexible year input
#'
#' @param year a numeric value of a year or string objective of a range year
#' @param file_name name of the file that the user wishes to load (required)
#' @param demographics logical value - whether to include a demographic information (inherited from RNHANES::nhanes_search())
#' @param recode logical value - whether to recode the categorical variables into integers (inherited from RNHANES::nhanes_search())
#'
#' @return an NHANES data table with user specified parameters
#' @export
#'
#' @examples nhanes_table("2009","EPH")
nhanes_table <- function(year = NULL, file_name = NULL, demographics = F, recode = F){

  ## if the file name input is empty, the function displays nGraph_search Shiny app to help the user explore the options.
  if(is.null(file_name)){
    cat("File name is required! Please explore the NHANES files with nhanesGraph::nGraph_search().")
    ## ask the user to choose from two options
    user_ans = readline(prompt = "Press a if you'd like to see the nGraph_search Shiny app to explore the file options or q if you'd like to exit. \n Please exit nGraph_search by clicking the close window button on the top left to avoid conflict.")
    if(user_ans == "q"){
      print("exited from nhanes_table.")
      stop("")
    }else if(user_ans == "a"){
      nGraph_search()
      stop()
    }else{
        stop("Please choose from one of the options!")
      }

  }else{
    ## if the file_name is present
    ## making sure the year input isn't empty
    if(is.null(year) == T ){
      stop("Try again with a year input!")
    }else{
      ## if there is a single value for the year, output a message that indicates the cycle

      ## for numeric inputs, make it into a cycle (string) to input into RNHANES
      if(is.numeric(year)){
        if(year < 1999 || year > 2021){
          stop("The continuous NHANES starts from 1999 and is only available up to 2020. Please input a valid year or a valid cycle.")
        }else{
          if(year %% 2 == 1){
            input_year = paste(year, year + 1 , sep = "-")
          }else{input_year = paste(year - 1, year, sep = "-")}
        }
        ## end of numeric year input
      }else{
        if(is.character(year)){
          ## for string inputs, check whether the input is a cycle or a specific year

          ## check for single year input
          if(grepl("-",year) == F){
            temp = as.numeric(year)
            ## check whether the inputted year is valid
            if(temp > 1999 && temp < 2020){
              ## make the single input into a cycle
              ## if the inputted year is odd, add one and make it into a cycle
              if(temp %% 2 == 1){
                input_year = paste(temp, temp + 1, sep = "-")
              }else{
                input_year = paste(temp - 1, temp, sep = "-")
              }
            }
            ## end of string single year input
          }else{
            if(grepl("-",year) == T){
              ## check for cycle input
              first <- as.numeric(sub("\\-.*", "", year)) # get the first part of the specified year range
              last  <- as.numeric(sub(".*-", "", year)) # get the last part of the specified year range

              #### check whether this is a valid cycle
              ## check if first is greater than 1999 and less than 2020
              if(first < 1999 || first > 2020 || last > 2020){
                stop("The continuous NHANES starts from 1999 and is only available up to 2020. Please input a valid year or a valid cycle.")
              }else{
                ## check if first is one less than second

                if(first > last){
                  print("The first part of your year input is larger than the second part. Please input a valid cycle or a specific year you would like to see.")
                  stop()
                }else{
                  ## the inputted string cycle is correct
                  if(first == last - 1){
                    input_year = year
                  }else{
                    ## ask which cycle they want to see
                    cat("It seems like your year input contains multiple cycles. Which cycle would you like to see?", sep = '\n')
                    cat('\n')
                    cycles = year_check(first, last)
                    cat(cycles, sep = '\n')

                    ## ask the user to choose from the possible cycles
                    user_ans = readline(prompt = "Choose a cycle! Press q if you'd like to exit. ")
                    if(user_ans == "q"){
                      print("safely stoped.")
                      stop("")
                    }else{
                      user_ans = as.numeric(user_ans)
                      if(is.numeric(user_ans) == F || user_ans > length(cycles) || user_ans < 1){
                        print("Please provide an integer from the given options.")
                        stop("")
                      }else{
                        ## get the user chosen cycle
                        input_year = paste(sub('.*\\.', "", cycles[user_ans]))
                      }
                    }
                  }
                }

              }
            }

          } ## end of string part of year checking
        } ## end of string part of year checking

      } ## end of non-numeric year input


    } ## end of non-null year inputs


    ## input the cycles into the RNHANES command to retrieve the data of interest
    RNHANES::nhanes_load_data(file_name = file_name, year = input_year, demographics = demographics, recode = recode)
  }
}

## output the dataframe into a publication ready format







