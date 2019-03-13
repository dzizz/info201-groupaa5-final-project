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
                           radioButtons(
                             inputId = "rico_hdi_levels",
                             label = "Select HDI Measurement Ratio:",
                             choices = c(
                               "All" = "all",
                               "Very High" = "0.8 - 1",
                               "High" = "0.7 - 0.8",
                               "Medium" = "0.55 - 0.7",
                               "Low" = "< 0.55"
                             )
                           ),
                           sliderInput(
                             inputId = "rico_year",
                             label = "Select Year:",
                             min = 1990,
                             max = 2014,
                             value = 2014,
                             step = 5
                           )
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

