
## user interface for shiny app

ui <- fluidPage(
  shinyWidgets::setBackgroundColor(
    color = c("#FFF0F5")
  ),

  fluidRow(
    column(3,
           selectInput("cycle", h3("Choose a cycle:"),
                       choices =  RNHANES::nhanes_cycle_years(), selected = 1)),

    column(3,
           selectInput("component", h3("Choose a component:"),
                       choices = list("all" = 1, "demographics" = 2,
                                      "dietary" = 3), selected = 1))

  ),
  tableOutput("result"),
)
