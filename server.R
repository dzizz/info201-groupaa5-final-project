#Import the needed libraries
library("shiny")
library("dplyr")
source("data.R")

#Create the server
main_server <- function(input, output) {
  output$kaylaHDIMap <- renderPlot({
    plot_data <- world_HDI
    
    #widget code here
    
    # Map visualization 
    ggplot(data = plot_data) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = group, fill = factor(Year)),
        color = "white",
        size = .1
      ) +
      coord_map() +
      scale_fill_brewer(palette = "OrRd") +
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
        mapping = aes(x = long, y = lat, group = group, fill = factor(Year)),
        color = "white",
        size = .1
      ) +
      coord_map() +
      scale_fill_brewer(palette = "Blues") +
      labs(
        title = "CO2 Levels",
        fill = "Values"
      ) 
  })
}
