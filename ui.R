#Import the needed libraries
library("shiny")

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
              tabPanel("Rico",
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
              tabPanel("Dillon",
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
              tabPanel("Kayla",
                       sidebarLayout(
                         sidebarPanel(
                           selectInput(
                             inputId = "years",
                             label = "Select Year:",
                             choices = c(years, "Select year..."),
                             selected = "Select year..."
                           )
                         ),
                         mainPanel(
                           tabsetPanel(type = "tabs",
                                       tabPanel("Summary"),
                                       tabPanel("Plot",
                                                plotOutput("kaylaCO2Map"), plotOutput("kaylaHDIMap")
                                       )
                           )
                         )
                       )),
              tabPanel("Julia",
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

