library("dplyr")
library("tidyr")
library("maps")
library("mapproj")
library("ggplot2")

# Carbon dioxide emissions per capita and Human Development Index
# Data is from http://hdr.undp.org/en/data#

    co2_data <- read.csv("data/Carbon dioxide emissions per capita (tonnes).csv", stringsAsFactors = FALSE)
    hdi_data <- read.csv("data/Human Development Index (HDI).csv", stringsAsFactors = FALSE)
    
    hdi_data <- hdi_data[, colSums(is.na(hdi_data)) < nrow(hdi_data)] %>% #delete na values
      rename(rank_2017 = HDI.Rank..2017.)
    names(hdi_data)[3:30] <- gsub("X", "HDI_", names(hdi_data)[3:30]) #change colnames
    
    co2_data <- co2_data[, colSums(is.na(co2_data)) < nrow(co2_data)] %>% #delete na values
      rename(rank_2017 = HDI.Rank..2017.)
    names(co2_data)[3:11] <- gsub("X", "co2_", names(co2_data)[3:11]) #change colnames
    
    
# DILLON
    
# KAYLA
    
    #plot data for HDI
    plot_HDI_data <- hdi_data %>% 
      gather(
        key = Year,
        value = hdi_data,
        HDI_1990:HDI_2017
      ) %>% 
      mutate(
        Year = as.numeric((substr(Year, nchar(Year) - 3, nchar(Year))))
      ) 
    plot_HDI_data$rank_2017 <- NULL
    
    #plot data for CO2
    plot_CO2_data <- co2_data %>% 
      gather(
        key = Year,
        value = co2_data,
        co2_1990:co2_2014
      ) %>% 
      mutate(
        Year = as.numeric((substr(Year, nchar(Year) - 3, nchar(Year))))
      )
    plot_CO2_data$rank_2017 <- NULL
    
    # World map data to visualize
    world <- map_data("world")
    world_HDI <- world %>% 
      rename(Country = region) %>% 
      left_join(plot_HDI_data)
    
    world_CO2 <- world %>% 
      rename(Country = region) %>% 
      left_join(plot_CO2_data)

# ARAMIS
    
# JULIA
    
    