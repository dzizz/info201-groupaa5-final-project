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
                           radioButtons(
                             inputId = "rico_hdi_levels",
                             label = "Select HDI Measurement Ratio:",
                             choices = c(
                               "All" = "all",
                               "Very High" = "Very High",
                               "High" = "High",
                               "Medium" = "Medium",
                               "Low" = "Low"
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
                             inputId = "yearsHDI",
                             label = "Select Year (HDI Levels):",
                             choices = c("Select year...", yearsHDI),
                             selected = "Select year..."
                           ),
                           
                           selectInput(
                             inputId = "HDI_countries",
                             label = "Select Country (HDI Levels):",
                             choices = c("Select country...", as.character(hdi_data$Country)),
                             selected = "Select country..."
                           ),
                           
                           selectInput(
                             inputId = "yearsCO2",
                             label = "Select Year (CO2 Levels):",
                             choices = c("Select year...", yearsCO2),
                             selected = "Select year..."
                           ),
                           
                           selectInput(
                             inputId = "CO2_countries",
                             label = "Select Country (CO2):",
                             choices = c("Select country...", as.character(co2_data$Country)),
                             selected = "Select country..."
                           )
                         ),
                         mainPanel(
                           tabsetPanel(type = "tabs",
                                       tabPanel("Description",
                                                tags$div(
                                                  tags$h4(
                                                    tags$strong("My Question:")),
                                                  tags$p("Which two countries are 
most similar in terms of HDI and CO2 emissions? Which two are most different? Why might this be - 
that is, what factors may influence this?"),
                                                  tags$h4(
                                                    tags$strong("Relavence/Interest:")),
                                                  tags$p("This is a question of interest because we 
can compare and contrast countries and determine why they might be different or similar. 
By arranging the data from highest HDI or highest CO2 or by lowest HDI or lowest CO2 on a map, 
we can view which countries are most alike or unalike. WHO WOULD WANT THIS INFORMATION, WHY, AND
                                                         FOR WHAT"),
                                                  tags$h4(
                                                    tags$strong("Quantitative Analysis:")),
                                                  tags$p("By ordering the joined data with the HDI 
and CO2 emission values from 2014, we can see which countries are the most similar in terms of HDI 
and CO2 emission values. Looking at the data ordered by CO2 emissions from largest to smallest, we 
can see that the top two countries in terms of largest CO2 emissions are Qatar and Trinidad and 
Tobago. Additionally, the most similar countries in terms of largest HDI values are Norway and 
Switzerland. On the flip side, when looking that countries that have the lowest CO2 emission and 
HDI values, we can see that there are multiple countries that have the same values, in addition to 
many other countries having the same values throughout the data."),
                                                  tags$p("Also, by having ordered data, we can 
further compare data by seeing the highest and lowest values for HDI and CO2 emission values. The 
two countries that have the largest difference between them in terms of CO2 emission values are 
Qatar and Burundi. The two countries that have the largest difference between them in terms of HDI 
                                                         values are Norway and Marshall Islands."),
                                                  tags$p("Based on this data, we can further look 
into what other factors may influence two specific countries and why their HDI/CO2 emissions are 
                                                         similar/different."))),
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
                                       tabPanel("Description",
                                                tags$div(
                                                  tags$h4(
                                                    tags$strong("Critical Question :")),
                                                  tags$p("question here"),
                                                  tags$h4(
                                                    tags$strong("Why Ask? :")),
                                                  tags$p("why ask this quesiton"),
                                                  tags$h4(
                                                    tags$strong("Quantitative Analysis :")),
                                                  tags$p("analyze"),
                                                ),
                                       tabPanel("Plot",
                                                plotOutput("julias_map")
                                                )
                           )
                         )
                       ))
  )
)

