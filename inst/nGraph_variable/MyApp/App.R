


ui <- fluidPage(

  ## exit button
  tags$button(
    id = 'close',
    type = "button",
    class = "btn action-button",
    onclick = "setTimeout(function(){window.close();},500);",  # close browser
    "Close window"
  ),

  ## title and background
  titlePanel("Visualize NHANES data with nhanesGraph Package"),
  shinyWidgets::setBackgroundColor(
    color = c("#f2f0ff")
  ),

  ## user inputs
  sidebarLayout(
    sidebarPanel(
      helpText("Visualize NHANES files by variables."),

      selectInput("cycle", h3("Choose a cycle:"),
                  choices =  RNHANES::nhanes_cycle_years(), selected = 1),

      selectInput("component", h3("Choose a component:"),
                  choices = list("demographics",
                                 "dietary", "examination",
                                 "laboratory",  "questionnaire" )),
    uiOutput("variable")),
    mainPanel(
      tableOutput("plot")
    )

  )
)


## server function for nhanes_shiny app

server <- function(input, output){
  observe({
    if (input$close > 0) stopApp()                             # stop shiny
  })

  ### creating a selectInput for variable list, depending on the component and cycle inputs
  output$variable <- renderUI({

    ## get the corresponding variable name list by cycle and component inputs
    var_list = nhanes_variable_list[nhanes_variable_list$cycle == input$cycle,]
    var_list = var_list[var_list$component == input$component,]
    variable_des <- as.vector(var_list$variable_description)
    variable_name <- var_list[var_list$variable_description == variable_des,]$variable_name
    variable_list <- paste(paste("(", variable_name, ")", sep = ""), variable_des, sep = " ")
    # render selectizeInput
    variable_list = unique(factor(variable_list))
    selectizeInput("variable", "Variables",
                   choices = c(variable_list))
  })


  output$plot <- renderTable({

    ## filter with the cycle first
    data = nhanes_variable_list[nhanes_variable_list$cycle == input$cycle,]

    var_name = req(input$variable)
    ## getting the variable name from the input
    var = paste(gsub("\\(*", "", (gsub(").*$", "", var_name))))

    ## get the file name using the variable name
    data[data$variable_name == var, ]


  })


}



shinyApp(ui, server)
