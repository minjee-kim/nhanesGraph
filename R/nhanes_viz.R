#' Visualize an NHANES variable
#'
#' @param type Graph type. `"hist"` is a bar chart for coded or categorical
#'   values and a histogram for numeric values. `"density"` draws a density.
#' @param dat Data frame returned by [nhanes_table()].
#' @param var Column name.
#' @return A ggplot.
#' @keywords internal
viz <- function(type, dat, var) {
  type <- tolower(type)
  if (!var %in% names(dat)) {
    stop("Column '", var, "' is not in this file. Columns include: ",
         paste(utils::head(names(dat), 12), collapse = ", "))
  }
  x <- dat[[var]]
  if (inherits(x, "haven_labelled")) {
    x <- as.vector(x)
  }
  if (grepl("dens", type)) {
    return(
      ggplot2::ggplot(data.frame(x = x), ggplot2::aes(x = x)) +
        ggplot2::geom_density(fill = "#6f8faf", alpha = 0.8) +
        ggplot2::labs(x = var, title = var)
    )
  }
  if (!grepl("hist|bar", type)) {
    warning("Only hist and density are implemented. Drawing hist.")
  }
  if (is.numeric(x) && length(unique(x)) > 12) {
    ggplot2::ggplot(data.frame(x = x), ggplot2::aes(x = x)) +
      ggplot2::geom_histogram(bins = 30, color = "black", fill = "#ff80aa") +
      ggplot2::labs(x = var, title = var)
  } else {
    ggplot2::ggplot(data.frame(x = as.factor(x)), ggplot2::aes(x = x)) +
      ggplot2::geom_bar(color = "black", fill = "#ff80aa") +
      ggplot2::labs(x = var, title = var)
  }
}

#' Visualize NHANES variables
#'
#' @param graph_type `"hist"` or `"density"`.
#' @param file_name NHANES file name. A short name is expanded from the cycle
#'   encoded in the suffix when possible (`BPX_D` is 2005-2006).
#' @param variable Column to plot.
#' @param year Optional cycle or year. Inferred from a suffixed file name when omitted.
#' @return A ggplot.
#' @export
#' @examples
#' \dontrun{
#' nhanes_viz(graph_type = "hist", file_name = "BPX_D", variable = "BPXSY1")
#' nhanes_viz("hist", file_name = "DEMO", variable = "RIDAGEYR", year = "2021-2023")
#' }
nhanes_viz <- function(graph_type = "hist", file_name = NULL, variable = NULL, year = NULL) {
  if (is.null(file_name) || is.null(variable)) {
    stop(
      "file_name and variable are both required in non-interactive use. ",
      "Browse files with nGraph_search()."
    )
  }
  if (is.null(year)) {
    year <- .year_from_file(file_name)
  }
  dat <- nhanes_table(year = year, file_name = file_name)
  viz(graph_type, dat, variable)
}

.year_from_file <- function(file_name) {
  file_name <- toupper(file_name)
  if (grepl("^P_", file_name)) {
    return("2017-2020")
  }
  suffix <- sub("^.*_", "_", file_name)
  if (!grepl("^_[B-Z]$", suffix)) {
    stop("Pass year as well as file_name when the file name has no cycle suffix, for example year = \"2021-2023\".")
  }
  cycles <- nhanes_cycles()
  hit <- cycles[cycles$suffix == suffix, ]
  if (nrow(hit) != 1) {
    stop("Could not infer a cycle from ", file_name, ". Pass year.")
  }
  hit$cycle
}
