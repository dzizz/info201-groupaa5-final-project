#Import the needed libraries
library("shiny")
source("server.R")

#Create the main user interface using a fluidPage
main_ui <- fluidPage(
  titlePanel("Title"),
  tabsetPanel(type = "tabs",
              tabPanel("Home",
                       sidebarLayout(
                         sidebarPanel(
                           
                         ),
                         mainPanel(
                           tabsetPanel(type = "tabs",
                                       tabPanel("Summary"),
                                       tabPanel("Data")
                           )
                         )
                       )),
              tabPanel("1",
                       sidebarLayout(
                         sidebarPanel(
                           
                         ),
                         mainPanel(
                           tabsetPanel(type = "tabs",
                                       tabPanel("Summary"),
                                       tabPanel("Plot")
                           )
                         )
                       )),
              tabPanel("2",
                       sidebarLayout(
                         sidebarPanel(
                           
                         ),
                         mainPanel(
                           tabsetPanel(type = "tabs",
                                       tabPanel("Summary"),
                                       tabPanel("Plot")
                           )
                         )
                       )),
              tabPanel("3",
                       sidebarLayout(
                         sidebarPanel(
                           
                         ),
                         mainPanel(
                           tabsetPanel(type = "tabs",
                                       tabPanel("Summary"),
                                       tabPanel("Plot",
                                                 plotOutput("rico_plot"))
                           )
                         )
                       )),
              tabPanel("4",
                       sidebarLayout(
                         sidebarPanel(
                           
                         ),
                         mainPanel(
                           tabsetPanel(type = "tabs",
                                       tabPanel("Summary"),
                                       tabPanel("Plot")
                           )
                         )
                       ))
  )
)

