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

# JULIA

    
# KAYLA
    
    
# DILLON
    

# ARAMIS
    
    
    