
## user interface for shiny app
#install.packages("DT")
#library(DT)
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
  titlePanel("Search NHANES files with nhanesGraph Package"),
  shinyWidgets::setBackgroundColor(
    color = c("#FFF0F5")
  ),

  ## user inputs
  sidebarLayout(
    sidebarPanel(
      helpText("Search NHANES files from 1999-2016"),

      selectInput("cycle", h3("Choose a cycle:"),
                  choices =  RNHANES::nhanes_cycle_years(), selected = 1),

      selectInput("component", h3("Choose a component:"),
                  choices = list("all" , "demographics",
                                 "dietary", "examination",
                                 "laboratory",  "questionnaire" ))),
    # textInput("searchme",
    #           label = "Search Bar",
    #           value = "")),

    mainPanel(
      #DT::dataTableOutput("result")
      dataTableOutput("result")
    )
  )
)
