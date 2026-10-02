#' Continuous NHANES cycles this package can load
#'
#' Public-use continuous NHANES, including the 2017-March 2020 pre-pandemic
#' files and the August 2021-August 2023 cycle. There is no 2019-2020 cycle:
#' field operations stopped in March 2020, and those months were released with
#' the 2017-2018 sample as the pre-pandemic files (`P_` prefix).
#'
#' @return A data frame with one row per cycle.
#' @export
nhanes_cycles <- function() {
  data.frame(
    cycle = c(
      "1999-2000", "2001-2002", "2003-2004", "2005-2006", "2007-2008",
      "2009-2010", "2011-2012", "2013-2014", "2015-2016", "2017-2018",
      "2017-2020", "2021-2023"
    ),
    begin_year = c(1999, 2001, 2003, 2005, 2007, 2009, 2011, 2013, 2015, 2017, 2017, 2021),
    end_year = c(2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016, 2018, 2020, 2023),
    suffix = c("", "_B", "_C", "_D", "_E", "_F", "_G", "_H", "_I", "_J", "", "_L"),
    prefix = c("", "", "", "", "", "", "", "", "", "", "P_", ""),
    stringsAsFactors = FALSE
  )
}

#' Map a year or cycle string onto a published NHANES cycle
#'
#' @param year Numeric year, a single-year string, or a cycle such as `"2007-2008"`.
#' @return One row of [nhanes_cycles()].
#' @keywords internal
resolve_cycle <- function(year) {
  cycles <- nhanes_cycles()
  if (is.null(year) || length(year) != 1 || is.na(year) || !nzchar(as.character(year))) {
    stop("Provide a year (for example 2008 or 2022) or a cycle (for example \"2007-2008\" or \"2021-2023\").")
  }

  if (is.character(year) && grepl("-", year, fixed = TRUE)) {
    hit <- cycles[cycles$cycle == year, ]
    if (nrow(hit) == 1) {
      return(hit)
    }
    first <- as.numeric(sub("-.*", "", year))
    last <- as.numeric(sub(".*-", "", year))
    if (is.na(first) || is.na(last)) {
      stop("Could not read cycle '", year, "'. Use a published cycle such as \"2017-2018\" or \"2021-2023\".")
    }
    hit <- cycles[cycles$begin_year >= first & cycles$end_year <= last, ]
    if (nrow(hit) == 1) {
      return(hit)
    }
    if (nrow(hit) == 0) {
      stop(
        "No published continuous NHANES cycle matches ", year, ".\n",
        "Available cycles: ", paste(cycles$cycle, collapse = ", ")
      )
    }
    stop(
      "That range covers more than one cycle: ", paste(hit$cycle, collapse = ", "),
      ". Pass one cycle."
    )
  }

  yr <- suppressWarnings(as.numeric(year))
  if (is.na(yr)) {
    stop("Could not read year '", year, "'.")
  }
  yr <- as.integer(yr)
  if (yr < 1999 || yr > 2023) {
    stop(
      "Continuous NHANES public-use files currently run from 1999-2000 through August 2021-August 2023. ",
      "Pass a year from 1999 to 2023, or a cycle such as \"2021-2023\"."
    )
  }
  # 2019-2020 was not released as its own cycle.
  if (yr %in% c(2019, 2020)) {
    message("There is no 2019-2020 cycle. Using the 2017-2020 pre-pandemic files.")
    return(cycles[cycles$cycle == "2017-2020", ])
  }
  if (yr %in% c(2021, 2022, 2023)) {
    return(cycles[cycles$cycle == "2021-2023", ])
  }
  if (yr %in% c(2017, 2018)) {
    return(cycles[cycles$cycle == "2017-2018", ])
  }
  begin <- if (yr %% 2 == 1) yr else yr - 1
  hit <- cycles[cycles$begin_year == begin & cycles$cycle != "2017-2020", ]
  if (nrow(hit) != 1) {
    stop("No cycle found for ", yr, ". Available cycles: ", paste(cycles$cycle, collapse = ", "))
  }
  hit
}

#' Attach the cycle suffix or pre-pandemic prefix to a short file name
#'
#' @param file_name Short name such as `"EPH"` or a full name such as `"DEMO_L"`.
#' @param cycle_row One row from [nhanes_cycles()].
#' @return File stem used by CDC, without `.xpt`.
#' @keywords internal
resolve_file_name <- function(file_name, cycle_row) {
  file_name <- toupper(trimws(file_name))
  if (!nzchar(file_name)) {
    stop("file_name is required. Call nGraph_search() to browse files.")
  }
  catalog <- nhanes_files()
  in_cycle <- catalog[catalog$cycle == cycle_row$cycle, "data_file_name"]
  if (file_name %in% in_cycle) {
    return(file_name)
  }
  built <- paste0(cycle_row$prefix, file_name, cycle_row$suffix)
  if (built %in% in_cycle) {
    return(built)
  }
  # Still try the constructed name: the catalog is a snapshot, not a lock.
  built
}
