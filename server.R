#Import the needed libraries
library("shiny")
library("dplyr")
library("ggplot2")
source("data.R")

#Create the server
main_server <- function(input, output) {
  output$kaylaHDIMap <- renderPlot({
    plot_data <- world_HDI
    
    #widget code here
    
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
    
    #widget code here
    
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
  
  #Create Dillon Zizza's planned visualization
  #Generate two plots - One for CO2, one for HDI, using the previously created data frames with the desired countries
  #These data sets need to be scaled to one another, so that the maximum value of HDI (1) is roughly the same height as the maximum value of CO2 (45.4)
  #scale_y_continuous is used to draw the second axis on the righthand side demonstrating HDI values
  output$dzizza_plot <- renderPlot({
    ggplot(data = dzizza_hdi) +
      geom_point(mapping = aes_string(x = "Year", y = "HDI"), color = "red") +
      scale_y_discrete(name = "HDI", breaks = c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1), labels = c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1))
  })
}