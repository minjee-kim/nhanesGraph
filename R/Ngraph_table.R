#' Loading NHANES data with a flexible year input
#'
#' Downloads a public-use continuous NHANES file from the current CDC URL
#' (`https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/`). A short file name such as
#' `"EPH"` is expanded to the cycle-specific name (`EPH_E` for 2007-2008,
#' `P_DEMO` for the 2017-2020 pre-pandemic demographics file, `DEMO_L` for
#' August 2021-August 2023).
#'
#' Years 2019 and 2020 map to the 2017-2020 pre-pandemic release. Years 2021,
#' 2022, and 2023 map to the August 2021-August 2023 cycle. The old RNHANES
#' download path is no longer used: those URLs now return an HTML page instead
#' of the XPT file.
#'
#' @param year A numeric year or a cycle string such as `"2007-2008"` or `"2021-2023"`.
#' @param file_name Short or full NHANES file name, for example `"EPH"` or `"DEMO_L"`.
#' @param demographics If `TRUE`, merge the cycle demographics file on `SEQN`.
#' @param recode Retained for compatibility. Published codes are returned as CDC
#'   released them; the codebook URL is attached as `attr(data, "nhanes_doc")`
#'   when the file is in the catalog.
#' @return A data frame.
#' @export
#' @examples
#' \dontrun{
#' nhanes_table(2008, "EPH")
#' nhanes_table("2021-2023", "DEMO")
#' }
nhanes_table <- function(year = NULL, file_name = NULL, demographics = FALSE, recode = FALSE) {
  if (is.null(file_name) || !nzchar(file_name)) {
    stop("file_name is required. Browse files with nGraph_search().")
  }
  cycle_row <- resolve_cycle(year)
  resolved <- resolve_file_name(file_name, cycle_row)
  if (!identical(resolved, toupper(file_name))) {
    message("Loading ", resolved, " from the ", cycle_row$cycle, " cycle.")
  }
  dat <- .download_nhanes_xpt(cycle_row$begin_year, resolved)
  if (isTRUE(demographics) && !grepl("DEMO", resolved)) {
    demo_name <- .demo_file(cycle_row)
    demo <- .download_nhanes_xpt(cycle_row$begin_year, demo_name)
    if (!"SEQN" %in% names(dat) || !"SEQN" %in% names(demo)) {
      warning("Could not merge demographics: SEQN is missing.")
    } else {
      overlap <- setdiff(intersect(names(dat), names(demo)), "SEQN")
      if (length(overlap)) {
        demo <- demo[, !names(demo) %in% overlap, drop = FALSE]
      }
      dat <- merge(dat, demo, by = "SEQN", all.x = TRUE)
    }
  }
  catalog <- nhanes_files()
  hit <- catalog[catalog$cycle == cycle_row$cycle & catalog$data_file_name == resolved, ]
  if (nrow(hit) == 1) {
    attr(dat, "nhanes_doc") <- hit$doc_url
    attr(dat, "nhanes_description") <- hit$description
  }
  attr(dat, "nhanes_cycle") <- cycle_row$cycle
  attr(dat, "nhanes_file") <- resolved
  if (isTRUE(recode)) {
    message(
      "recode = TRUE keeps the published CDC codes. ",
      "Value labels are in the codebook: ",
      if (nrow(hit) == 1) hit$doc_url else "see the file documentation on wwwn.cdc.gov."
    )
  }
  dat
}
