knitr::opts_chunk$set(echo = FALSE)
library(gt)
library(tidyverse)
library(highcharter)
library(readxl)
library(sf)
library(ggtext)
library(janitor)
library(ggforce)
library(mapboxapi)
library(leaflet)
library(tidycensus)
options(tigris_use_cache = TRUE)

demvars <-  c(White = "B03002_003",
              Black = "B03002_004",
              Asian = "B03002_006",
              Hispanic = "B03002_012",
              Other = "B03002_005", #AIAN
              Other = "B03002_007", #NHPI
              Other = "B03002_008", #Some Other Race
              Other = "B03002_009") #Two Races

dem_zcta_data <- get_acs(geography = "zcta",
                       variables = demvars,
                       state="TX",
                       survey = "acs5",
                       show_call = TRUE,
                       summary_var = "B01003_001") %>%
  # group_by(variable) %>% 
  # summarise(across(where(is.numeric), sum)) %>% 
  mutate(measure = "Area Population",
         data="ACS 2019",
         pct = round(estimate/summary_est, digits=4)) #%>% 
  select(data, measure, dem_group = variable, value = estimate, pct)
