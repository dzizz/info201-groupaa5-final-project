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
    
    # Produces a summary of descriptive statistics of each year in the 'hdi_data' data frame 
    hdi_summary <- as.data.frame(do.call(cbind, lapply(hdi_data[3:27], summary)))   
    
    # Produces a summary of descriptive statistics of each year in the 'co2_data' data frame
    co2_summary <- as.data.frame(do.call(cbind, lapply(co2_data[3:11], summary)))   
    
    # Removes space in 'Country' column
    hdi_data$Country <- substr(hdi_data$Country, 2, nchar(hdi_data$Country))
    co2_data$Country <- substr(co2_data$Country, 2, nchar(co2_data$Country))
    
    # World Map
    world <- map_data("world")
    
    
    
# DILLON
    
# KAYLA
    
    # range of years for HDI data
    colnames <- colnames(hdi_data)
    colnames <- colnames[3:27]
    yearsHDI <- as.character(substr(colnames, 5, nchar(colnames)))
    
    # range of years for CO2 data
    colnames <- colnames(co2_data)
    colnames <- colnames[3:11]
    yearsCO2 <- as.character(substr(colnames, 5, nchar(colnames)))
    
    plot_HDI_data <- hdi_data %>% 
      mutate(Country.Code = iso.alpha(hdi_data$Country, n = 3))
    plot_CO2_data <- co2_data %>% 
      mutate(Country.Code = iso.alpha(co2_data$Country, n = 3))
    
    #plot data for HDI
    plot_HDI_data <- plot_HDI_data %>% 
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
    plot_CO2_data <- plot_CO2_data %>% 
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

    world_HDI <- world %>% 
      rename(Country = region) %>% 
      mutate(Country.Code = iso.alpha(world$region, n = 3)) %>% 
      left_join(plot_HDI_data)
    
    world_CO2 <- world %>% 
      rename(Country = region) %>% 
      mutate(Country.Code = iso.alpha(world$region, n = 3)) %>% 
      left_join(plot_CO2_data)

# ARAMIS
    
# JULIA
# QUESTION 4
    
    # Data frame of all countries change in HDI from 1990 to 2014
    
    hdi_1990_to_2014 <- hdi_data %>%
      mutate(change_in_hdi = HDI_2014 - HDI_1990) %>% 
      select(Country, HDI_1990, HDI_2014, change_in_hdi)
    
    # Data frame of all the countries whose CO2 emmisions per capita DECREASED from 1990 to 2014
    
    co2_decrease_countries <- co2_data %>% 
      select(rank_2017, Country, co2_1990, co2_2014) %>% 
      filter(co2_2014 <= co2_1990) %>% 
      mutate(change_in_co2 = co2_2014 - co2_1990)
    
    # Joins the two data frames together - excluding the NA values
    
    co2_decrease_and_hdi_df <- left_join(co2_decrease_countries, hdi_1990_to_2014, by = c("Country")) %>% 
      na.omit(co2_decrease_and_hdi_df$change_hdi)
    
   ###########
    
    co2_decrease_and_hdi_df <- co2_decrease_and_hdi_df %>% 
      mutate(Country.Code = iso.alpha(co2_decrease_and_hdi_df$Country[1:43], n = 3))
    
    world_map <- world %>% 
      mutate(Country.Code = iso.alpha(world$region, n = 3))
    
    