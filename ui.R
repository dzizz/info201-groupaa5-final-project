#Import the needed libraries
library("shiny")
library("shinythemes")

#Create the main user interface using a fluidPage
main_ui <- navbarPage("HDI vs CO2",
  tabPanel("Home",
      fluidPage(theme = shinytheme("flatly"),
        titlePanel("Introduction"), 
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
    tags$br(),


    column(12, 
      tabsetPanel(type = "tabs",
        tabPanel("HDI Data", dataTableOutput("HDI_data")),
        tabPanel("CO2 Data", dataTableOutput("CO2_data")), 
        tabPanel("Summary",
          dataTableOutput("HDI_Summary"), tags$br(), tags$br(), 
          dataTableOutput("CO2_Summary")
        )
      )
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
                tags$strong("Critical Question:")),
              
                tags$p("What is the relationship between a highly developed nation and their CO2 emissions? Does CO2 emissions increase or decrease when a nation is 
more developed? For instance, compare the CO2 emissions of a country with a high HDI with one of low HDI."),
              
                tags$h4(
                  tags$strong("Why Ask? :")),
              
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
        radioButtons(
          inputId = "dzizza_HDI_CO2",
          label = "Select Data:",
          choices = c("Human Development Index" = "HDI", "Carbon Dioxide" = "CO2"),
          selected = "HDI"
        ),
        selectInput(
          inputId = "dzizza_HDI_category",
          label = "Select HDI level:",
          choices = c("All" = "dzizza_global", "High" = "dzizza_high", "Low" = "dzizza_low"),
          selected = "All")
        ),
    mainPanel(
      tabsetPanel(type = "tabs",
        tabPanel("Description",
          tags$div(
            tags$h4(
              tags$strong("Critical Question:")),
              tags$p("What trends can be observed in Human Development Index and carbon dioxide emissions per capita over the years included in this data set? Can correlations be drawn between the rates of Human Development Index and carbon dioxide emissions per capita increase or decrease? Are countries in the low or high ends of the Human Development Index scale changing in different ways?"),
            tags$h4(
              tags$strong("Why Ask?:")),
              tags$p("These questions are of interest because they can demonstrate the direction that the world as a whole is heading in. If Human Development Index is showing an upward trend globally between 1990 and 2014 that is good, but if that corresponds to a much higher increase in carbon dioxide emissions per capita over the same time frame then it may point to some worrying signs for environmentalism."),
            tags$h4(
              tags$strong("Quantitative Analysis:")),
              tags$p("The data shows a consistant increase in Human Development Index across the board, both in terms of the global average, and in terms of the top and bottom of the Human Development Index rankings. This demonstrates that the world on the whole is improving, likely along most if not all of the metrics that make up the Human Development Index such as wealth, safety, life expectancy, and education rates."),
              tags$p("The data is less consistent when it comes to carbon dioxide emissions per capita. While the global average has begun to decline slightly between 2005 and 2014 and the top ranked countries in terms of HDI have made significant cuts to their carbon emissions dating all the way back to 2000, the countries on the other end of the Human Development Index spectrum posted less positive results, with average rates of CO2 emissions per capita roughly stabilizing between 1995 and 2011, but then getting steadily higher after that.")
            )),
        tabPanel("Plot",
          plotOutput("dzizza_plot")
        )
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
                tags$strong("Critical Question:")),
              
              tags$p("Which two countries are 
most similar in terms of HDI and CO2 emissions? Which two are most different? Why might this be - 
that is, what factors may influence this?"),
              
              tags$h4(
                tags$strong("Why Ask? :")),
              
              tags$p("This is a question of interest because we 
can compare and contrast countries and determine why they might be different or similar. 
By arranging the data from highest HDI or highest CO2 or by lowest HDI or lowest CO2 on a map, 
we can view which countries are most alike or unalike. Then, we can wonder what sorts of factors 
cause certain countries to be similar or different. Some factors may include, wealth, population,
number of cities, industries, laws, culture, etc."),
              
              tags$p("Scientists could potentially want this
information to determine what factors cause high CO2 emission levels in certain countries. 
They could potentially see the similarities between certain countries high/low HDI values and CO2 
emission values. This would allow scientists to dive 
deeper into this relationships and find even more specific factors, for example, high HDI is an
indication of happiness levels among the population, which can mean there are large industries and 
cities within the country. This could potentially mean that due to the large amount of human activity
and machinery, the CO2 emissions are very high. By determining information like this, 
scientists would be able to tell the public what sorts of factors are causing/aiding in 
high CO2 emission values and what we can do to reduce it."),
              
              tags$h4(
                tags$strong("Quantitative Analysis:")),
              
              tags$p("By comparing the HDI 
and CO2 emission values in each country, we can see which countries are the most similar in terms of HDI 
and CO2 emission values. Looking at the map data, we can see that there does appear to 
be a slight correlation in HDI and CO2 levels. For example, looking at Adorra's CO2 and HDI levels 
in 2014 for example, the HDI and CO2 values are both quite high, as seen by the hue on the map. Also,
by selecting the country and year specifically, we can see the values. This could potentially suggest that
the happier people are the more CO2 emissions are produced. On the other hand, looking at 
Afghanistan's CO2 and HDI levels in 2014, we see that the values are very low. We could speculate
that this might be due to the War in Afghanistan, which caused many people to lose their homes and
loved ones - which is why the HDI value is so low. In relation to CO2 emissions, the HDI 
levels could also suggest that industries slowed down or that there is less civilization."),
              
              tags$p("From the map alone, we cannot see any
outstanding outliers. Outliers are more clearly seen through scatter plots or bar graphs, 
as seen on the other visualizations within this report."),
              
              tags$p("Based on this data, we can further look 
into what other factors may influence specific countries and why their HDI/CO2 emissions are 
                                                         similar/different."))),
          tabPanel("Maps",
            plotOutput("kaylaHDIMap"), plotOutput("kaylaCO2Map")
          )
        )
      )
   )),
      tabPanel("Julia",
         sidebarLayout(
            sidebarPanel(
              tags$div(
                tags$h4(
                  tags$strong( "For Table:")
                )
              ),
              
              selectInput(
                inputId = "julia_bin",
                label = "Select a change in HDI...",
                choices = c("Change in HDI...", as.character(co2_decrease_and_hdi_df$bin)),
                selected = "Change in HDI..."
              ),
              
              tags$div(
                tags$h4(
                  tags$strong( "For Plot:")
                )
              ),
              selectInput(
                inputId = "julias_country_name",
                label = "Select a country:",
                choices = c("Select country...", as.character(co2_decrease_and_hdi_plot$Country)),
                selected = "Select country..."
              )
      ),
      mainPanel(
        tabsetPanel(type = "tabs",
          tabPanel("Description",
            tags$div(
              tags$h4(
                tags$strong("Critical Question :")),
                  tags$p("Of the countries whose CO2 emissions dropped from 1990 to 2014, what
                         countries experienced an increase in HDI? What countries experienced a 
                         decrease in HDI? How did their HDI values change? How did their CO2 values change?
                         What connections can be made between the decrease in amount of co2 emissions per 
                         capita and the increase in HDI value?"),
              
                tags$h4(
                  tags$strong("Why Ask? :")),
                    tags$p("This is a question of interest because it can give us an idea of how many
                           countries follow the same correlation. Being able to visualize the change
                           in HDI value on a map or plot will makes it easier to view and make connections. 
                           We can look to see if there are specific relationships between the changes in CO2
                           values and the changes in HDI values. We can use this information to ask more 
                           questions about specific countries and other external explanations for the change
                           in their values."),
              
              tags$h4(
                tags$strong("Quantitative Analysis :")),
                  tags$p("When filtering the data sets for countries whose CO2 emissions per capita have
                         decreased from 1990 to 2014, only 43 countries remain out of a total of 195 countries. 
                         This means that about 22% of countries decreased their CO2 emissions per capita from
                         1990 to 2014. Some leading and well known countries in this subset include the United 
                         States, Canada the United Kingdom, and Australia. Also included in this subset is #2 ranked in
                         Human Development Index(HDI), Switzerland"),
              
                  tags$p("Furthermore, when we look at the countries whose CO2 emissions per capita have decreased, 
                         we conclude that 100% of these countries experience an increase in HDI. Meaning that none of these countries 
                         experience a lower quality of life when their CO2 emissions decreased. This information can
                         be surprising as we naturally would think that a higher quality of life would include 
                         more materialistic things that emit CO2 such as modes of transportation which would therefore
                         increase the amount of CO2 per capita being released. However, this is not the case."),
              
                  tags$p("When viewing the map that displays the location of all the countries within this subset,
                         you see there is a range of where this decrease in CO2 and increase in HDI occurs. As you
                         may see there are big chunks of Africa and Europe that all follow this trend."),
                  
                  tags$p("When you input a specific range of change in HDI values, a table is displayed of all the 
                         countries that are in that category. When you see these countries information you can notice 
                         that there is a bit of wide difference in the change in CO2 although their change in HDI value
                         is very similar. For example when you view the countries whose HDI value increased more than 0.200,
                         only two countries return. These countries include Rwanda and Singapore. Rwanda experienced no change
                         in CO2 emissions per capita while Singapore experienced decrease of 2.0 in CO2 emissions per capita. 
                         This difference may be due to the locations of the countries or it may be due to HOW the country 
                         experienced an increase in the quality of their life.")
            )
          ),
          
          tabPanel("Plot",
            tags$div(
              tags$h4(
                tags$strong("Map")
              ),
              tags$p(em("To view the locations of the countries."))
            ),
            plotOutput("julias_map"), 
            tags$div(
              tags$h4(
                tags$strong("Table")
              ),
              tags$p(em("To view and compare countries that coincide with specific ranged changes in HDI values.
                     Can also view more information about each country, its rank in 2017, its co2 values, and the values
                     for the 1990 and 2014 years. The 'rank 2017' represents the countries rank in HDI value."))
              
            ),
            dataTableOutput("julias_country_info"),
            tags$div(
              tags$h4(
                tags$strong("Plot")
              ),
              tags$p(em("To visualize and view a country's HDI progression from 1990 to 2014."))
            ),
            plotOutput("julias_change_in_hdi")
          )
        )
      )
    ))
)


