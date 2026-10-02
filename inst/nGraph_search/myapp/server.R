server <- function(input, output) {
  observe({
    if (input$close > 0) stopApp()
  })

  output$result <- DT::renderDataTable({
    data <- nhanesGraph::nhanes_files()
    data <- data[data$cycle == input$cycle, ]
    if (!is.null(input$component) && input$component != "all") {
      data <- data[data$component == input$component, ]
    }
    query <- tolower(trimws(input$searchme))
    if (nzchar(query)) {
      keep <- grepl(query, tolower(data$description), fixed = TRUE) |
        grepl(query, tolower(data$data_file_name), fixed = TRUE)
      data <- data[keep, ]
    }
    data[, c("cycle", "component", "data_file_name", "description", "data_url")]
  })
}
