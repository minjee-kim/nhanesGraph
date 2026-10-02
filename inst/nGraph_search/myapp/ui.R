ui <- fluidPage(
  tags$button(
    id = "close",
    type = "button",
    class = "btn action-button",
    onclick = "setTimeout(function(){window.close();},500);",
    "Close window"
  ),
  titlePanel("Search NHANES files with nhanesGraph"),
  shinyWidgets::setBackgroundColor(color = c("#FFF0F5")),
  sidebarLayout(
    sidebarPanel(
      helpText("Public-use continuous NHANES files, 1999-2000 through August 2021-August 2023."),
      selectInput(
        "cycle", h3("Choose a cycle:"),
        choices = nhanesGraph::nhanes_cycles()$cycle,
        selected = "2017-2018"
      ),
      selectInput(
        "component", h3("Choose a component:"),
        choices = c("all", "demographics", "dietary", "examination", "laboratory", "questionnaire")
      ),
      textInput("searchme", "Search description or file name", value = "")
    ),
    mainPanel(DT::dataTableOutput("result"))
  )
)
