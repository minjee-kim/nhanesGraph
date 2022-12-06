

## NHANES search using RNHANES:: search variables
## building a shiny app for interactive search
## search by inputs : cycle, query, variable name

# nhanes_file_list = RNHANES::nhanes_data_files()
# usethis::use_data(nhanes_file_list, compress = "xz")


#' run shiny app with nhanesGraph package
#'
#' @return shiny app
#' @export
#'
nGraph_search <- function() {
  appDir <- system.file("nGraph_search", "myapp", package = "nhanesGraph")
  if (appDir == "") {
    stop("Could not find the directory. Try re-installing `nhanesGraph`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
