
## user interface for shiny app

ui <- fluidPage(
  titlePanel("Search NHANES files with nhanesGraph Package"),
  shinyWidgets::setBackgroundColor(
    color = c("#FFF0F5")
  ),

  fluidRow(
    column(3,
           selectInput("cycle", h3("Choose a cycle:"),
                       choices =  RNHANES::nhanes_cycle_years(), selected = 1)),

    column(2,
           selectInput("component", h3("Choose a component:"),
                       choices = list("all" = 1, "demographics" = 2,
                                      "dietary" = 3, "examination" = 4,
                                      "laboratory" = 5,  "questionnaire" = 6), selected = 1))
    # column(3,
    #   selecInput(
    #     inputId = "searchme",
    #     label = "Search Bar",
    #     multiple = FALSE,
    #     choices = c("Search Bar" = "", paste0(LETTERS,sample(LETTERS, 26))),
    #   ))

  ),
  tableOutput("result"),
)
