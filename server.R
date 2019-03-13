#Import the needed libraries
library("shiny")
library("dplyr")
library("ggplot2")
library("tidyr")
source("data.R")

#Create the server
main_server <- function(input, output) {
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
}
