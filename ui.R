#Import the needed libraries
library("shiny")

#Create the main user interface using a fluidPage
main_ui <- fluidPage(
  titlePanel("Title"),
  sidebarLayout(
    sidebarPanel(
      
      # drop down for years
      selectInput(
        inputId = "years",
        label = "Select Year:",
        choices = c("years", "Select year..."),
        selected = "Select year..."
      )
      
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Summary"),
                  tabPanel("Table"),
                  tabPanel("1"),
                  tabPanel("Dillon", plotOutput(outputId = "dzizza_plot")),
                  tabPanel("Kayla", plotOutput("kaylaCO2Map"), plotOutput("kaylaHDIMap")),
                  tabPanel("4")
      )
    )
  )
)