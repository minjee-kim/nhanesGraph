

## server function for nhanes_shiny app

#library(DT)

server <- function(input, output){
  observe({
    if (input$close > 0) stopApp()                             # stop shiny
  })

  output$result <- renderDataTable({
    data("nhanes_file_list")
    if(input$component == "all"){
      data = nhanes_file_list[nhanes_file_list$cycle == input$cycle, ]
    }else{
      data = nhanes_file_list[nhanes_file_list$cycle == input$cycle, ]
      data = data[data$component == input$component, ]
    }

    data


    # as.data.frame(RNHANES::nhanes_search(data,
    # sear, component == input$component, ignore_case = T))
  })

}


