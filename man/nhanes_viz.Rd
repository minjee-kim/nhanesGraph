% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nhanes_viz.R
\name{nhanes_viz}
\alias{nhanes_viz}
\title{Visualize NHANES Variables}
\usage{
nhanes_viz(graph_type = "Hist", file_name = NULL, variable = NULL)
}
\arguments{
\item{graph_type}{type of graph: only Histograms are allowed, currently.}

\item{file_name}{specific file name}

\item{variable}{variable name}
}
\value{
a ggplot with specified inputs for the variable of interest
}
\description{
Visualize NHANES Variables
}
\examples{
nhanes_viz(graph_type = "Hist", file_name = "ENX_E", variable = "ENAATMPT")
}
