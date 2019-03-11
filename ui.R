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
                  tabPanel("Summary"),
                  tabPanel("Table"),
                  tabPanel("1"),
                  tabPanel("Kayla", plotOutput("kaylaCO2Map"), plotOutput("kaylaHDIMap")),
                  tabPanel("3"),
                  tabPanel("4")
      )
    )
  )
)