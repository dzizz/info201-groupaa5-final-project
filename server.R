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
  
  output$rico_plot <- renderPlot({
    join_co2_hdi <- left_join(co2_data, hdi_data, by = "Country") %>%
      select(-rank_2017.x, -rank_2017.y) %>%
      gather(key = co2_hdi, value = value, -Country) %>%
      mutate(
        year = as.numeric(substr(co2_hdi, nchar(co2_hdi) - 3, nchar(co2_hdi))),
        co2_hdi = substr(co2_hdi, 1, nchar(co2_hdi) - 5)
      ) 
    join_co2_hdi <- na.omit(join_co2_hdi) %>%
      spread(key = co2_hdi, value = value) %>%
      filter(year == input$rico_year) %>%
      mutate(Change.point = cut(
        HDI, breaks = c(0, 0.55, 0.70, 0.80, 1),
        labels = c("Low", "Medium", "High", "Very High")
      )) 
    
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
        join_co2_hdi
      }
    }
    
    join_co2_hdi <- get_group(join_co2_hdi, input$rico_hdi_levels)
    
    ggplot(data = join_co2_hdi) +
      geom_point(mapping = aes(y = co2, x = HDI, colour = year)) 
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
      coord_map() +
      labs(
        title = "HDI Levels",
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
      coord_map() +
      labs(
        title = "CO2 Levels",
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
        geom_col(mapping = aes(x = as.factor(Year), y = HDI)) +
        scale_y_continuous(name = "Human Development Index", limits = c(0, 1), breaks = c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1)) +
        labs(Title = "Human Development Index values over Time")
    } else {
      ggplot(data = eval(parse(text = paste0(input$dzizza_HDI_category, "_co2")))) +
        geom_col(mapping = aes(x = as.factor(Year), y = CO2)) +
        #coord_cartesian(ylim = c(3.9, 5.0)) +
        scale_y_continuous(name = "Metric Tons of Carbon Dioxide per Person", trans = "log10")
      #, breaks = c(4.0, 4.2, 4.4, 4.6, 4.8, 5.0)) 
    }
  })
}