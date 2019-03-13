#Import the needed libraries
library("shiny")
library("dplyr")
library("ggplot2")
library("tidyr")
library("DT")

source("data.R")

#Create the server
main_server <- function(input, output) {
  
  output$HDI_data <- renderDataTable({
    datatable(hdi_data)
  })
  
  output$CO2_data <- renderDataTable({
    datatable(co2_data)
  })
  
  output$HDI_Summary <- renderDataTable({
    datatable(hdi_summary)
  })
  
  output$CO2_Summary <- renderDataTable({
    datatable(co2_summary)
  })
####################
## Aramis work area:
####################
  output$rico_plot <- renderPlot({
    join_co2_hdi <- na.omit(join_co2_hdi) %>% #omit na values from df
      spread(key = co2_hdi, value = value) %>% #get co2 and HDI in two diff col
      filter(year == input$rico_year) %>% #Look at input year to get specific year in slider
      mutate(Change.point = cut(
        HDI, breaks = c(0, 0.55, 0.70, 0.80, 1),
        labels = c("Low", "Medium", "High", "Very High") #Create break tabs to get plots for HDI ratios
      )) 
    
    ## This function takes in a df and a break point which will then filter for the break that has been picked
    ## in radio buttons. 
    get_group <- function(join_co2_hdi, point) {
      if(point == "Low") {
        filter(join_co2_hdi, Change.point == input$rico_hdi_levels)
      } else if (point == "Medium") {
        filter(join_co2_hdi, Change.point == input$rico_hdi_levels)
      } else if (point == "High") {
        filter(join_co2_hdi, Change.point == input$rico_hdi_levels)
      } else if (point == "Very High") {
        filter(join_co2_hdi, Change.point == input$rico_hdi_levels)
      } else {
        join_co2_hdi #If the break doesn't work then it will show **all** values
      }
    }
    
    join_co2_hdi <- get_group(join_co2_hdi, input$rico_hdi_levels) #gets the group called in radiobuttons
    
    ggplot(data = join_co2_hdi) +
      geom_point(mapping = aes(y = co2, x = HDI, colour = year)) + #Map the plots
      ggtitle("Correlation between HDI and CO2 emmissions per year")
  })
  
  output$kaylaHDIMap <- renderPlot({
    plot_data <- world_HDI
    
    if (input$HDI_countries != "Select country...") {
      plot_data <- plot_data %>% 
        filter(Country == input$HDI_countries)
    }
    
    if (input$yearsHDI != "Select year...") {
      plot_data <- plot_data %>% 
        filter(Year == input$yearsHDI)
    }
    
    # Map visualization 
    ggplot(data = plot_data) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = group, fill = hdi_data),
        color = "white",
        size = .1
      ) +
      coord_map(xlim = c(-180,180), ylim = c(-60, 90)) +
      labs(
        title = "HDI Levels",
        x = "Longitude",
        y = "Latitude",
        fill = "Values"
      ) 
  })
      
  output$kaylaCO2Map <- renderPlot({
    plot_data <- world_CO2
    
    if (input$CO2_countries != "Select country...") {
      plot_data <- plot_data %>% 
        filter(Country == input$CO2_countries)
    }
    
    if (input$yearsCO2 != "Select year...") {
      plot_data <- plot_data %>% 
        filter(Year == input$yearsCO2)
    }
    
    # Map visualization 
    ggplot(data = plot_data) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = group, fill = co2_data),
        color = "white",
        size = .1
      ) +
      coord_map(xlim = c(-180,180), ylim = c(-60, 90)) +
      labs(
        title = "CO2 Levels",
        x = "Longitude",
        y = "Latitude",
        fill = "Values"
      ) 
  })
  
  #Create Dillon Zizza's visualization
  #Generate two plots - One for CO2, one for HDI, using the previously created data frames with the desired countries
  #Use scale_y_continuous to make sure the bounds and breaks for the plots look good and are easily readable
  #Use coord_cartesian to place limits on the Y axis of the CO2 plot
  #Both visualizations change their data depending on the value selected in "dzizza_HDI_category", representing a yearly average from either the entire planet, the 20 lowest HDI countries, the 20 middle HDI countries, or the 20 highest HDI countries
  #Use eval(parse(text = )) to parse a pasted string as the data source
  
  output$dzizza_plot <- renderPlot({
    if(input$dzizza_HDI_CO2 == "HDI") {
      ggplot(data = eval(parse(text = paste0(input$dzizza_HDI_category, "_hdi")))) +
        geom_col(mapping = aes(x = as.factor(Year), y = HDI), fill = "#9d4c6c") +
        scale_y_continuous(name = "Human Development Index", limits = c(0, 1), breaks = c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1)) +
        ggtitle("Human Development Index values over Time")
    } else {
      ggplot(data = eval(parse(text = paste0(input$dzizza_HDI_category, "_co2")))) +
        geom_col(mapping = aes(x = as.factor(Year), y = CO2), fill = "#4c689d") +
        scale_y_continuous(name = "Metric Tons of Carbon Dioxide per Person", trans = "log10") +
        ggtitle("Carbox Dioxide Output values over Time")
    }
  })


  output$julias_map <- renderPlot({
    ggplot(data = world_co2_decrease_and_hdi_df) + 
      geom_polygon(mapping = aes(x = long, y = lat, group = group, fill = bin), color = "black", size = .1) +
      coord_map(xlim = c(-180,180), ylim = c(-60, 90)) +
      labs(fill = "Change In HDI", x = "Longitude", y = "Latitude", title = "Change in HDI from 1990 to 2014 For Countries Whose CO2 Emissions Per Capita have Decreased from 1990 to 2014") +
      scale_fill_brewer(palette = "Greens") +
      theme(
        panel.background = element_rect(fill = "lightblue",
                                        #color = "lightblue",
                                        size = 0.5, linetype = "solid"),
        panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                        colour = "white"), 
        panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                        colour = "white")
      )
  })
  
  output$julias_country_info <- renderDataTable({
    table <- co2_decrease_and_hdi_df
    
    table <- table %>% 
      filter(bin == input$julia_bin) %>% 
      select(-c("bin", "Country.Code"))
    
    datatable(table)
    
  })
  
  output$julias_change_in_hdi <- renderPlot({
    ggplot(data = co2_decrease_and_hdi_plot) + 
      geom_point(mapping = aes(x = year, y = hdi_value, color = bin))
    
  })

}

