
## preliminary function that outputs graphs accordingly
#' Visualize variables
#'
#' @param type type of data, inherited from nhanes_viz
#' @param dat data, filtered using file_name and cycle
#' @param var variable name, inherited from nhanes_viz
#' @export
#' @return ggplot graph
#'
viz <- function(type, dat, var){

  ## make sure the type of the graph is flexible
  type = tolower(type)

  if(grepl(type, "hist")){
  graph = ggplot2::ggplot(dat, aes(as.factor(dat[,var]))) + geom_histogram(stat = "count", fill = "#ff80aa") + xlab(paste(var))
  }
  return(graph)
}

viz(type = "hist", dat = data, var = variable)


## function for trend visualization

#' Visualize NHANES Variables
#'
#' @param graph_type type of graph: c("Hist", "pie")
#' @param file_name specific file name
#' @param variable variable name
#'
#' @return a ggplot with specified inputs for the variable of interest
#' @export
#'
#' @examples nhanes_viz(graph_type = "Hist", file_name = "ENX_E", variable = "ENAATMPT")
nhanes_viz <- function(graph_type = "Hist", file_name = NULL, variable = NULL){

  data("nhanes_file_list")
  ## call the nhanes_variable_list file from the package
  data_var_list = nhanes_variable_list
  if(is.null(file_name) == F && is.null(variable) == F){
    year_input = unique(data_var_list[data_var_list$data_file_name == file_name,]$cycle)
    data <- as.data.frame(nhanes_table(year = year_input, file_name = file_name ))
    return(viz(type = graph_type, dat = data, var = variable))
  }else if(is.null(file_name) && is.null(variable) == T){
    ## if both file name and variable are empty, ask whether to display ngraph_variable

    cat("Both file_name and variable inputs are empty.")
    user_ans = readline(prompt = "Would you like to explore the options via nGraph_variable? \n Press a to continue. Press q to exit.")
    if(user_ans == "q"){
      print("safely stoped.")
      stop("")
    }else if(user_ans == "a"){
      nGraph_variable()
      stop()
    }
  }else if(is.null(variable) == F && is.null(file_name) == T){
    print("No file name inputted. Proceeding with caution.")

    ## if file name is null, search for the file name
    # filter variable data using the inputted variable
   # data_filter = data_var_list %>% filter(variable_name == variable) %>% filter(use_constraints == "None")

    data_filter = data_var_list[data_var_list$use_constraints == "None",]
    data_filter = data_filter[data_filter$variable_name == variable,]
    if(nrow(data_filter) == 0){
      ## stop if there is no matching name
      stop("Couldn't find the variable you listed!")
    }else if(nrow(data_filter) == 1){
      ## if there is a unique row with the specified variable name, proceed with the file name
      data = nhanes_table(year = paste(data_filter$cycle), data_filter$data_file_name)
      return(viz(type = graph_type, dat = data, var = paste(variable)))
    }else{
      ## if there are multiple cycles with the same variable name, ask which cycle to work with
      cycles = data_filter$cycle

      cat("It seems like there are multiple cycles corresponding to the variable.")
      cat('\n')
      cat(paste(seq(1:length(cycles)),".", cycles, sep = ""), sep = "\n")
      user_ans = readline(prompt = "Choose a cycle! Press q if you'd like to exit. ")
      if(user_ans == "q"){
        print("safely stoped.")
        stop("")
        }else if(user_ans %in% seq(1:length(cycles))){
          ## check that the user input is one of the options
          user_ans = as.numeric(user_ans)
          ## get the file name from the filtered data
          file_name = data_filter[data_filter$cycle == cycles[user_ans],]$data_file_name
          ## get the data from nhanes table with the corresponding inputs
          data = nhanes_table(year = cycles[user_ans], file_name = file_name)
          return(viz(type = graph_type, dat = data, var = variable))
        }else{
          stop("Please choose one of the options!")}

    }



  }else if(is.null(variable) == T && is.null(file_name) == F){
    print("No variable name inputted. Proceeding with caution.")

    ## if variable is null

    ## check whether there is one cycle corresponding to the file
    cycles = unique(data_var_list[data_var_list$data_file_name == file_name,]$cycle)
    if(length(cycles) == 1){
      ## if the cycle is unique

      ## output a list of variables
      var_list = (data_var_list[data_var_list$data_file_name == file_name,]$variable_name)
      cat("Here are the variables in the file you chose.")
      cat('\n')
      cat(paste(seq(1:length(var_list)),".", var_list, sep = ""), sep = "\n")
      user_ans = readline(prompt = "Please choose one of the options! Press q if you'd like to exit. ")
      if(user_ans == "q"){
        print("safely stoped.")
        stop("")
      }else if(user_ans %in% seq(1:length(var_list))){
        ## check that the user input is one of the options
        user_ans = as.numeric(user_ans)
        ## get the file name from the filtered data

        ## get the data from nhanes table with the corresponding inputs
        data = nhanes_table(year = cycles, file_name = file_name)
        return(viz(type = graph_type, dat = data, var = paste(var_list[user_ans])))
      }else{
        stop("Please choose one of the options!")}
    }else if(length(cycles) > 1){

      cat("It seems like there are multiple cycles corresponding to the variable.")
      cat('\n')
      cat(paste(seq(1:length(cycles)),".", cycles, sep = ""), sep = "\n")
      user_ans = readline(prompt = "Choose a cycle! Press q if you'd like to exit. ")
      if(user_ans == "q"){
        print("safely stoped.")
        stop("")
      }else if(user_ans %in% seq(1:length(cycles))){
        ## check that the user input is one of the options
        user_ans = as.numeric(user_ans)
        year_input = cycles[user_ans]
        var_list = data_var_list[data_var_list$cycle == year_input,]$variable_name

        cat("Here are the variables in the file you chose.")
        cat('\n')
        cat(paste(seq(1:length(var_list)),".", var_list, sep = ""), sep = "\n")
        user_ans = readline(prompt = "Please choose one of the options! Press q if you'd like to exit. ")
        if(user_ans == "q"){
          print("safely stoped.")
          stop("")
        }else if(user_ans %in% seq(1:length(var_list))){
          ## check that the user input is one of the options
          user_ans = as.numeric(user_ans)

          ## get the data from nhanes table with the corresponding inputs
          data = nhanes_table(year = year_input, file_name = file_name)
          return(viz(type = graph_type, dat = data, var = paste(var_list[user_ans])))
        }
      }else{
        stop("Please choose one of the options!")}
    }


  }

}
