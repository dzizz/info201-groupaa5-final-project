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
    ggplot(data = dzizza_data) +
      geom_col(mapping = aes_string(x = "Country", y = paste0("HDI_", input$years)), fill = "red", position = "dodge") +
      scale_y_continuous(name = paste("CO2 per capita in", input$years),  sec.axis = sec_axis(~. / max(dzizza_co2$HDI_2014, na.rm=TRUE), name = paste("HDI in", input$years))) +
      geom_col(mapping = aes_string(x = "Country", y = paste0("co2_", input$years)), fill = "blue", position = "dodge")
  })
}