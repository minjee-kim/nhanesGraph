

## NHANES search using RNHANES:: search variables
## building a shiny app for interactive search
## search by inputs : cycle, query, variable name

nhanes_file_list = RNHANES::nhanes_data_files()
usethis::use_data(nhanes_file_list, compress = "xz")



myApp <- function(...) {
  ui <- fluidPage(
    fluidRow(
      column(3,
             selectInput("cycle", h3("Choose a cycle:"),
                         choices =  RNHANES::nhanes_cycle_years(), selected = 1)),

      column(3,
             selectInput("component", h3("Choose a component:"),
                         choices = list("all" = 1, "demographics" = 2,
                                        "dietary" = 3), selected = 1)),
      tableOutput("result")

    )
  )
  server <- function(input, output, session) {
    output$result <- renderTable({
      as.data.frame(RNHANES::nhanes_search(nhanes_file_list, input$component, cycle == input$cycle))
    })
  }
  shinyApp(ui, server)
}

