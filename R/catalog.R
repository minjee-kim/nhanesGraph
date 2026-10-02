#' Current NHANES file catalog
#'
#' Public-use data files scraped from the CDC continuous NHANES pages,
#' including cycles through August 2021-August 2023 and the 2017-2020
#' pre-pandemic release. This replaces the 2022 snapshot shipped as
#' `nhanes_file_list`.
#'
#' @return A data frame with cycle, component, description, file name, and URLs.
#' @export
nhanes_files <- function() {
  path <- system.file("extdata", "nhanes_files.csv", package = "nhanesGraph")
  if (!nzchar(path)) {
    stop("Could not find the file catalog. Reinstall nhanesGraph.")
  }
  utils::read.csv(path, stringsAsFactors = FALSE)
}

.nhanes_cache_dir <- function() {
  root <- tryCatch(tools::R_user_dir("nhanesGraph", which = "cache"), error = function(e) "")
  if (!nzchar(root)) {
    root <- file.path(tempdir(), "nhanesGraph")
  }
  dir.create(root, recursive = TRUE, showWarnings = FALSE)
  root
}

.nhanes_xpt_url <- function(begin_year, file_name) {
  paste0(
    "https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/",
    begin_year, "/DataFiles/", file_name, ".xpt"
  )
}

.download_nhanes_xpt <- function(begin_year, file_name) {
  if (!requireNamespace("haven", quietly = TRUE)) {
    stop("Package 'haven' is required to read NHANES XPT files. Install it with install.packages(\"haven\").")
  }
  url <- .nhanes_xpt_url(begin_year, file_name)
  dest <- file.path(.nhanes_cache_dir(), paste0(begin_year, "_", file_name, ".xpt"))
  if (!file.exists(dest) || file.info(dest)$size < 1000) {
    status <- tryCatch(
      utils::download.file(url, dest, mode = "wb", quiet = TRUE),
      error = function(e) e
    )
    if (inherits(status, "error") || !is.null(status) && status != 0) {
      unlink(dest)
      stop(
        "Could not download ", file_name, " for ", begin_year, " from\n  ", url,
        "\nCDC may be busy, or the file name may not exist for that cycle. ",
        "Browse current files with nGraph_search()."
      )
    }
  }
  out <- haven::read_xpt(dest)
  attr(out, "nhanes_url") <- url
  out
}

.demo_file <- function(cycle_row) {
  catalog <- nhanes_files()
  hit <- catalog[catalog$cycle == cycle_row$cycle & catalog$component == "demographics", ]
  if (nrow(hit) == 0) {
    return(paste0(cycle_row$prefix, "DEMO", cycle_row$suffix))
  }
  hit$data_file_name[[1]]
}
