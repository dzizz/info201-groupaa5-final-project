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
    
    # range of years
    colnames <- colnames(hdi_data)
    colnames <- colnames[3:27]
    years <- as.character(substr(colnames, 5, nchar(colnames)))
    
    # Produces a summary of descriptive statistics of each year in the 'hdi_data' data frame 
    hdi_summary <- as.data.frame(do.call(cbind, lapply(hdi_data[3:27], summary)))   
    
    # Produces a summary of descriptive statistics of each year in the 'co2_data' data frame
    co2_summary <- as.data.frame(do.call(cbind, lapply(co2_data[3:11], summary)))   
    
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
      mutate(Country.Code = iso.alpha(world$region, n = 3)) %>% 
      left_join(plot_HDI_data)
    
    world_CO2 <- world %>% 
      rename(Country = region) %>% 
      mutate(Country.Code = iso.alpha(world$region, n = 3)) %>% 
      left_join(plot_CO2_data)

# ARAMIS
    
# JULIA
# Data frames and variables to help answer critical question 4 about the percentage of 
# countries whose HDI increased or decreased while their CO2 emissions levels decreased
    
    # Data frame of all countries change in HDI from 1990 to 2014
    
    hdi_1990_to_2014 <- hdi_data %>%
      mutate(change_hdi = HDI_2014 - HDI_1990) %>% 
      select(Country, HDI_1990, HDI_2014, change_hdi)
    
    # Data frame of all the countries whose CO2 emmisions per capita DECREASED from 1990 to 2014
    
    co2_decrease_countries <- co2_data %>% 
      select(rank_2017, Country, co2_1990,co2_2014) %>% 
      filter(co2_2014 < co2_1990)
    
    # Joins the two data frames together - excluding the NA values
    
    co2_decrease_and_hdi_df <- left_join(co2_decrease_countries, hdi_1990_to_2014, by = c("Country")) %>% 
      na.omit(co2_decrease_and_hdi_df$change_hdi)
    
    # Number of countries whose CO2 emissions per capita decreased
    
    num_countries <- nrow(co2_decrease_and_hdi_df)   # 34 -- with the NA vlaues it is 48
    
    # Number of countries whose HDI increased as their CO2 emissions decreased
    
    increased_hdi <- co2_decrease_and_hdi_df %>% 
      filter(change_hdi > 0) %>% 
      nrow()   # 34 -- all of the countries whose CO2 emissions decreased, their quality of life increased
    
    # Number of countries whose HDI decreased as their CO2 emissions decreased
    
    increased_0.1_hdi <- co2_decrease_and_hdi_df %>% 
      filter(change_hdi <= 0.1) %>% 
      nrow()   # 11 
    
    # Percentage of countries whose HDI increased as their CO2 emissions decreased
    
    percent_increased_hdi <- paste0((increased_hdi / num_countries) * 100, "%")   # 100%
    
    # Percentage of countries whose HDI increased above 0.1 as their CO2 emissions decreased
    
    percent_increased_0.1_hdi <- paste0(round((increased_0.1_hdi / num_countries) * 100, digits = 2 ), "%")
    
    # Percentage of countries whose HDI decreased as their CO2 emissions decreased
    
    percent_decreased_hdi <- paste0((0 / num_countries) * 100, "%")
    
    
    
    
    