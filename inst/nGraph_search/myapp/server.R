

## server function for nhanes_shiny app

server <- function(input, output, session){

  output$result <- renderTable({
    # data = as.data.frame(nhanes_file_list[which(sapply(nhanes_file_list, grepl, pattern = input$searchme)),])
    data = nhanes_file_list
    as.data.frame(RNHANES::nhanes_search(data, input$component, cycle == input$cycle))
  })

}



