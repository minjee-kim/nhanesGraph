

### interactive plots using the Shiny package

## data: data frame constructed via ngraph_table
## this function creates: histogram, line graph, or scatter plot, specified by plot
## user can input a long range of years to create graph over time
## if the specified time cycle is only one cycle, it degenerates to a basic graph (histogram, line graph, etc... )

#' Title
#'
#' @return nGraph_shiny Shiny app
#' @export
#'
nGraph_variable <- function() {
  appDir <- system.file("nGraph_variable", "MyApp", package = "nhanesGraph")
  if (appDir == "") {
    stop("Could not find the directory. Try re-installing `nhanesGraph`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
