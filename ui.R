#Import the needed libraries
library("shiny")

#Create the main user interface using a fluidPage
main_ui <- navbarPage("HDI vs CO2",
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
          step = 5
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
              tags$p("analyze")     
            )
          ),
          
          tabPanel("Plot",
            plotOutput("julias_map")
          )
        )
      )
    ))
)


