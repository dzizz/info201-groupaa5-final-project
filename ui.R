#Import the needed libraries
library("shiny")
source("server.R")

#Create the main user interface using a fluidPage
main_ui <- fluidPage(
  titlePanel("Title"),
  sidebarLayout(
    sidebarPanel(
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Summary"),
                  tabPanel("Table"),
                  tabPanel("1"),
                  tabPanel("Kayla"
                           ),
                  tabPanel("3"),
                  tabPanel("4")
      )
    )
  )
)
