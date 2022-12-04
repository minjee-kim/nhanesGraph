

## server function for nhanes_shiny app

server <- function(input, output, session) {
  output$result <- renderTable({
    as.data.frame(RNHANES::nhanes_search(nhanes_file_list, input$component, cycle == input$cycle))
  })
}
