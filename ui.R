#Import the needed libraries
library("shiny")

#Create the main user interface using a fluidPage
main_ui <- fluidPage(
  titlePanel("Title"),
  tabsetPanel(type = "tabs",
              tabPanel("Home",
                tabsetPanel(type = "tabs",
                  tabPanel("Introduction", 
                    tags$h3("Country Level HDI and CO2 Emission Data Analysis"),
                    tags$div(
                      tags$p("This is an analysis of country-level data Human Development Index (HDI) 
and carbon dioxide emissions per capita provided by the United Nations Development Program's Human 
Development Reports."),
                      tags$p(paste0("The Human Development Index is a numerical ranking of countries 
on the basis of overall quality of life produced by the United Nations. It operates on a scale from 0 to 1, 
                                    with 0 being the worst and 1 being the best. As detailed on the "), 
                             tags$a(href="http://hdr.undp.org/en/content/human-development-index-hdi", "UN Website"), 
", this evaluation is done on a broad basis of the three dimensions: \"long and healthy life\", \"knowledge\", 
and \"a decent standard of living\", comprised of life expectancy, average years of schooling, and gross 
national income per capita respectively. Gross national income per capita is itself a complex measure, but 
in effect indicates the overall wealth generated in that country, divided by the number of people in the country 
                                    to get the amount of wealth available per person."),
                      tags$p("Carbon dioxide emissions per capita is more straightforward, representing the total 
carbon dioxide emitted by that country divded by the total population of the country. This is a valuable statistic 
because it shows which countries are polluting more on the whole while removing the overwhelming statistical weight 
                             that countries with very large populations like China, India, and the United States add."),
                      tags$p("This data is valuable to analyze together because it shows some of the less explored 
elements of the developed versus developing world. If a country like Norway, with the highest HDI in the world, 
shows a corresponding increase or decrease in carbon dioxide emissions per capita, it represents a meaningful 
environmental impact of increading human development. If Norway is good, then it gives all the more reason to encourage 
poorer countries to increase their quality of life. If Norway is bad, it may give pause to the pursuit of modernization,
perhaps prompting questions reevaluating what we value as a society and how we go about achieving a high 
                             quality of life.")
                  )),
                    tabPanel("HDI Data", dataTableOutput("HDI_data")),
                    tabPanel("CO2 Data", dataTableOutput("CO2_data")), 
                    tabPanel("Summary",
                    dataTableOutput("HDI_Summary"), tags$br(), tags$br(), 
                    dataTableOutput("CO2_Summary"))
                )
              ),
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
                             step = 5,
                             sep = ""
                           )
                         ),
                         mainPanel(
                           tabsetPanel(type = "tabs",
                                       tabPanel("Description",
                                                tags$div(
                                                  tags$h4(
                                                    tags$strong("The Question:")),
                                                  tags$p("What is the relationship between a highly 
developed nation and their CO2 emissions? Does CO2 emissions increase or decrease when a nation is 
more developed? For instance, compare the CO2 emissions of a country with a high HDI with one of low HDI."),
                                                  tags$h4(
                                                    tags$strong("Relavence/Interest:")),
                                                  tags$p("This is a question of interest because it 
can tell us if there is a positive or negative correlation between the quality of life of a country 
and the amount of co2 it releases per capita. The data set can allow us to join our data sets together 
and compare these values for a particular year next to each other."),
                                                  tags$h4(
                                                    tags$strong("Quantitative Analysis:")),
                                                  tags$p("When comparing the very high HDI values with 
their CO2 emission values, you can automatically notice that the many of these countries have a higher
rate of CO2 emissions. When looking at all countries, you can a curve in the scatter plot, you see an 
increase in CO2 emissions as HDI values go up."),
                                                  tags$p("However, when looking at all the countries, 
it is easy to notice that there are many outliers in some of the countries with the highest Human
Devlopment Index. Some reasoning for this could be how much later they began modernizing their nation
and their overall population."),
                                                  tags$p("When looking at the medium and high HDI
plots you can also see some countries with very high CO2 emissions, meaning that a high HDI value does
not mean a high CO2 emissions in all cases. The question to be asked with this data are: is there also 
a correlation with population, hdi and co2 emissions? How can one fix the industralization and 
modernization of one country to lower their CO2 emissions?"),
                                                  tags$p("One last thing to pay attention is to the minor
drop in CO2 emissions you can see from 2010 to 2014 when looking at all the nations with eaither high or 
very high HDI values. Will this drop continue as major nations slowly progress to decrease their CO2
emissions? Will this pave a way for other nations modernizing to follow in their footsteps?"))
                                       ),
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
                                       tabPanel("Description"),
                                       tabPanel("Plot")
                           )
                         )
                       ))
  )
)

