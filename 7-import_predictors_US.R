# US predictors

install.packages("curl")
install.packages("readxl")
install.packages("tidyverse")
library(curl)
library(readxl)
library(tidyverse)


# Gini index
  # Source: https://profiles.shsu.edu/eco_mwf/inequality.html
  # Mark W. Frank, Sam Houston State University

url <- "https://profiles.shsu.edu/eco_mwf/Frank_Gini_2022.xls"
destfile <- "Frank_Gini_2022.xls"
curl_download(url, destfile)
gini <- read_excel(destfile, sheet = "Measures")

gini <- gini |>
  filter(Year >= 2000 & Year <= 2019,
         State != "United States") |>
  select(Year, st, State, Gini)
  # variable st doesn't match FIPS codes


# ACS data is available from 2006 forward
# IPUMS ACS shows data from 2000 forward, but persons in group quarters are not
#   included in the 2000-2005 ACS data.

# I could use 2000 Census and 2006-2019 ACS and then multiply impute the missing
#   values.