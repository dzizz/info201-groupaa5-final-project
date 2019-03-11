#Import the needed libraries
library("shiny")

#Create the main user interface using a fluidPage
main_ui <- fluidPage(
  titlePanel("Title"),
  sidebarLayout(
    sidebarPanel(
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Table"),
                  tabPanel("1"),
                  tabPanel("2"),
                  tabPanel("Dillon"),
                  tabPanel("4")
      )
    )
  )
)