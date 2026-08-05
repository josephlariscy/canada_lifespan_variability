# US predictors

install.packages("curl")
install.packages("readxl")
library(curl)
library(readxl)

url <- "https://profiles.shsu.edu/eco_mwf/Frank_Gini_2022.xls"
destfile <- "Frank_Gini_2022.xls"
curl_download(url, destfile)
gini <- read_excel(destfile, sheet = "Measures")
