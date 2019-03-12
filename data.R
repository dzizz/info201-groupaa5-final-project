library("dplyr")
library("tidyr")

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
    #First, produce data frames of countries to analyze from both data sets, consisting of the top and bottom of the HDI rankings and a few select additional countries
    dzizza_co2 <- co2_data %>% mutate(rank_2017 = as.numeric(rank_2017)) %>% filter(rank_2017 <= 5 | rank_2017 == 13 | rank_2017 == 86 | rank_2017 >= 184) %>% arrange(-rank_2017)
    dzizza_hdi <- hdi_data %>% filter(rank_2017 <= 5 | rank_2017 == 13 | rank_2017 == 86 | rank_2017 >= 184) %>% arrange(-rank_2017)
# KAYLA

# ARAMIS
    
# JULIA
    
    