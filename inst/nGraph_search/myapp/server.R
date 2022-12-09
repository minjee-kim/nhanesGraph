

## server function for nhanes_shiny app

#library(DT)

server <- function(input, output){
  observe({
    if (input$close > 0) stopApp()                             # stop shiny
  })
 # DT::
  output$result <- renderDataTable({
    # query == paste(input$searchme),
    # nhanes_file_list[which(sapply(nhanes_file_list, grepl, pattern = paste(input$searchme)), ignore.case = T),]
    # sear <-  input$searchme

    # nhanes_file_list[nhanes_file_list$cycle == input$cycle,]
    #recode(input$component, "all" = "")

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


