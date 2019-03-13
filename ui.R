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
                                       tabPanel("Introduction"),
                                       tabPanel("HDI Data", dataTableOutput("HDI_data")),
                                       tabPanel("CO2 Data", dataTableOutput("CO2_data")), 
                                       tabPanel("Summary",
                                                dataTableOutput("HDI_Summary"), tags$br(), tags$br(), 
                                                dataTableOutput("CO2_Summary"))
                           )
                         )
                       )),
              tabPanel("Rico",
                       sidebarLayout(
                         sidebarPanel(
                           
                         ),
                         mainPanel(
                           tabsetPanel(type = "tabs",
                                       tabPanel("Description"),
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
                                       tabPanel("Description"),
                                       tabPanel("Plot",
                                                plotOutput("dzizza_hdi"),
                                                plotOutput("dzizza_co2"))
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
                           ),
                           
                           selectInput(
                             inputId = "HDI_countries",
                             label = "Select Country (HDI Levels):",
                             choices = hdi_data$Country,
                             selected = "United States"
                           ),
                           
                           selectInput(
                             inputId = "CO2_countries",
                             label = "Select Country (CO2):",
                             choices = co2_data$Country,
                             selected = "Norway"
                           )
                         ),
                         mainPanel(
                           tabsetPanel(type = "tabs",
                                       tabPanel("Description",
                                                tags$div(
                                                  tags$p("My question is: Which two countries are 
most similar in terms of HDI and CO2 emissions? Which two are most different? Why might this be - 
that is, what factors may influence this?"),
                                                  tags$p("This is a question of interest because we 
can compare and contrast countries and determine why they might be different or similar. 
By arranging the data from highest HDI or highest CO2 or by lowest HDI or lowest CO2 on a map, 
we can view which countries are most alike or unalike. WHO WOULD WANT THIS INFORMATION, WHY, AND
                                                         FOR WHAT"),
                                                  tags$p("QUANTITATIVE ANALYSIS")
                                                )),
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
                                       tabPanel("Description"),
                                       tabPanel("Plot")
                           )
                         )
                       ))
  )
)

