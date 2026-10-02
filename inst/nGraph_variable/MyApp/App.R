ui <- fluidPage(
  tags$button(
    id = "close",
    type = "button",
    class = "btn action-button",
    onclick = "setTimeout(function(){window.close();},500);",
    "Close window"
  ),
  titlePanel("Browse NHANES files with nhanesGraph"),
  shinyWidgets::setBackgroundColor(color = c("#f2f0ff")),
  sidebarLayout(
    sidebarPanel(
      helpText("Files published through August 2021-August 2023. Load a file with nhanes_table() and plot a column with nhanes_viz()."),
      selectInput(
        "cycle", h3("Choose a cycle:"),
        choices = nhanesGraph::nhanes_cycles()$cycle,
        selected = "2021-2023"
      ),
      selectInput(
        "component", h3("Choose a component:"),
        choices = c("demographics", "dietary", "examination", "laboratory", "questionnaire")
      ),
      textInput("searchme", "Search description or file name", value = "")
    ),
    mainPanel(DT::dataTableOutput("plot"))
  )
)

server <- function(input, output) {
  observe({
    if (input$close > 0) stopApp()
  })

  output$plot <- DT::renderDataTable({
    data <- nhanesGraph::nhanes_files()
    data <- data[data$cycle == input$cycle & data$component == input$component, ]
    query <- tolower(trimws(input$searchme))
    if (nzchar(query)) {
      keep <- grepl(query, tolower(data$description), fixed = TRUE) |
        grepl(query, tolower(data$data_file_name), fixed = TRUE)
      data <- data[keep, ]
    }
    data[, c("cycle", "component", "data_file_name", "description", "doc_url")]
  })
}

shinyApp(ui, server)
