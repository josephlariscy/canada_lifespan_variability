# Import predictor variables using the R package cansim
  # We limit to the ten provinces; we don't include the territories
  # We limit to years 2000-2019
  # Many variables are available yearly. % foreign-born and % indigenous are
  #   only available in Census years 2001, 2006, 2011, 2016, and 2021.


install.packages("cansim")
install.packages("reshape2")
install.packages("tidyverse")
library(cansim)
library(reshape2)
library(tidyverse)


# Mid-year population
  # Data from 1971 to 2025
pop <- get_cansim("17-10-0005-01") |>
                  mutate(GeoUID = as.numeric(GeoUID)) |>
                  filter(REF_DATE >= 2000 & REF_DATE <= 2019,
                         GeoUID >= 10 & GeoUID <= 59,
                         `Age group` == "All ages",
                         Gender == "Total - gender") |>
                  rename(year = REF_DATE,
                         province = GEO,
                         pop = VALUE) |>
                  select(year, province, pop)
  # I mutate GeoUID from character to numeric so I can remove geographies
  # outside of range of 10 provinces

  # province is a factor variable
pop <- pop |>
       mutate(province = fct_recode(province,
                                    "nfl" = "Newfoundland and Labrador",
                                    "pei" = "Prince Edward Island",
                                    "nsc" = "Nova Scotia",
                                    "nbr" = "New Brunswick",
                                    "que" = "Quebec",
                                    "ont" = "Ontario",
                                    "man" = "Manitoba",
                                    "sas" = "Saskatchewan",
                                    "alb" = "Alberta",
                                    "bco" = "British Columbia"))

# Change province from factor to character so it can be sorted into 
# alphabetical order
pop$province <- as.character(pop$province)

# Arrange by province
pop <- pop[order(pop$province), ]


# Gini coefficient
  # Three different measures: adjusted market income, adjusted total income, and
  # adjusted after-tax income. I picked "Adjusted total income."
gini <- get_cansim("11-10-0134-01") |>
                   mutate(GeoUID = as.numeric(GeoUID)) |>
                   filter(REF_DATE >= 2000 & REF_DATE <= 2019,
                          GeoUID >= 10 & GeoUID <= 59,
                          `Income concept` == "Adjusted total income") |>
                   rename(year = REF_DATE,
                          province = GEO,
                          gini = VALUE) |>
                   select(year, province, gini)

gini <- gini |>
  mutate(province = fct_recode(province,
                               "nfl" = "Newfoundland and Labrador",
                               "pei" = "Prince Edward Island",
                               "nsc" = "Nova Scotia",
                               "nbr" = "New Brunswick",
                               "que" = "Quebec",
                               "ont" = "Ontario",
                               "man" = "Manitoba",
                               "sas" = "Saskatchewan",
                               "alb" = "Alberta",
                               "bco" = "British Columbia"))

gini$province <- as.character(gini$province)
gini <- gini[order(gini$province), ]
summary(gini$gini)


# Educational attainment
educ <- get_cansim("37-10-0130-01") |>
        mutate(GeoUID = as.numeric(GeoUID)) |>
               filter(REF_DATE >= 2000 & REF_DATE <= 2019,
               GeoUID >= 10 & GeoUID <= 59,
               `Age group` == "Total, 25 to 64 years" & 
               Gender == "Total - Gender")


# Medium education
ed_med <- educ |>
  filter(`Education attainment level` == "Upper secondary or above") |>
  rename(year = REF_DATE,
         province = GEO,
         ed_med = val_norm) |>
  mutate(province = fct_recode(province,
                               "nfl" = "Newfoundland and Labrador",
                               "pei" = "Prince Edward Island",
                               "nsc" = "Nova Scotia",
                               "nbr" = "New Brunswick",
                               "que" = "Quebec",
                               "ont" = "Ontario",
                               "man" = "Manitoba",
                               "sas" = "Saskatchewan",
                               "alb" = "Alberta",
                               "bco" = "British Columbia")) |>
  select(year, province, ed_med)

# Change province from factor to character so it can be sorted into 
# alphabetical order
ed_med$province <- as.character(ed_med$province)
ed_med <- ed_med[order(ed_med$province), ]
summary(ed_med$ed_med)


# High education
  # Restrict the education table to just BA and Master's/PhD rows
ed_high_2cats <- educ |>
  filter(`Education attainment level` == "Bachelor's level" |
         `Education attainment level` == "Master's or Doctoral level")

# Add the proportions with BA and Master's/PhD
ed_high <- ed_high_2cats |>
  group_by(REF_DATE, GEO) |>
  reframe(
    # Create and add the summary row
    data.frame(`Education attainment level` = "ed_high",
               val_norm = sum(val_norm[`Education attainment level` %in% c("Bachelor's level",
                                                       "Master's or Doctoral level")])))

# Clean
ed_high <- ed_high |>
  rename(year = REF_DATE,
         province = GEO,
         ed_high = val_norm) |>
  mutate(province = fct_recode(province,
                               "nfl" = "Newfoundland and Labrador",
                               "pei" = "Prince Edward Island",
                               "nsc" = "Nova Scotia",
                               "nbr" = "New Brunswick",
                               "que" = "Quebec",
                               "ont" = "Ontario",
                               "man" = "Manitoba",
                               "sas" = "Saskatchewan",
                               "alb" = "Alberta",
                               "bco" = "British Columbia")) |>
  select(year, province, ed_high)

# Change province from factor to character so it can be sorted into 
# alphabetical order
ed_high$province <- as.character(ed_high$province)
ed_high <- ed_high[order(ed_high$province), ]
summary(ed_high$ed_high)


# Violent crime rate

crime <- get_cansim("35-10-0177-01")|>
  mutate(GeoUID = as.numeric(GeoUID),
         GEO = str_remove(GEO, "\\s*\\[\\d+\\]"),
         VALUE = VALUE / 10) |>
  filter(Statistics == "Rate per 100,000 population",
         Violations == "Total violent Criminal Code violations",
         REF_DATE >= 2000 & REF_DATE <= 2019,
         GeoUID >= 10 & GeoUID <= 59) |>
  rename(year = REF_DATE,
         province = GEO,
         crime = VALUE) |>
  select(year, province, crime)
  # str_remove(GEO, "\\s*\\[\\d+\\]" removes a space and number in brackets from
  #   the end of province names.
  # Divide VALUE by 10 so that the statistic is by 10,000 instead of 100,000

crime <- crime |>
  mutate(province = recode(province, 
                           "Newfoundland and Labrador" = "nfl",
                           "Prince Edward Island" = "pei",
                           "Nova Scotia" = "nsc",
                           "New Brunswick" = "nbr",
                           "Quebec" = "que",
                           "Ontario" = "ont",
                           "Manitoba" = "man",
                           "Saskatchewan" = "sas",
                           "Alberta" = "alb",
                           "British Columbia" = "bco"))

crime <- crime[order(crime$province), ]

summary(crime$crime)


# Percentage foreign-born
# From Census years 2001, 2006, 2011, 2016, and 2021


# Percentage indigenous
  # From Census years 2001, 2006, 2011, 2016, and 2021


# Number of physicians
  # Source: Canadian Medical Association Masterfile
  # Canadian Physician Demographics and Supply Archive, Number of physicians by 
  # province/territory and specialty
  # URL: https://www.cma.ca/canadian-physician-demographics-and-supply-archive

physicians <- read.table("C:/Users/jlariscy/lifespan var in Canada/predictor variables/predictors_cleaned/number of physicians.txt", header = T)
physicians <- subset(physicians, select = -TERR)

colnames(physicians)<- c("year", "nfl", "pei", "nsc", "nbr", "que", "ont",
                         "man", "sas", "alb", "bco")

physicians_long <- reshape(data = physicians,
                           idvar = "year",
                           varying = list(names(physicians)[2:11]),
                           v.names = "physicians",
                           timevar = "province",
                           direction = "long",
                           times = c("nfl", "pei", "nsc", "nbr", "que",
                                     "ont", "man", "sas", "alb", "bco"))
physicians_long <- physicians_long[order(physicians_long$province), ]

# Merge number of physicians data and population data to calculate number of
#   physicians per capita
phys_per_cap <- merge(physicians_long, pop, by = c("province", "year"))

# Change number of physicians from character to numeric and remove commas
phys_per_cap$physicians <- as.numeric(gsub(",", "", phys_per_cap$physicians))

# Calculate physicians per 10,000 population
phys_per_cap$phys_per_cap = 10000*phys_per_cap$physicians / phys_per_cap$pop

# Remove columns for number of physicians and population
phys_per_cap <- phys_per_cap[c("year", "province", "phys_per_cap")]
phys_per_cap <- as.tibble(phys_per_cap)
phys_per_cap$year <- as.character(phys_per_cap$year)

rm(physicians, physicians_long)


# co2 emissions
  # Visit https://data-donnees.az.ec.gc.ca/data/substances/monitor/canada-s-official-greenhouse-gas-inventory/B-Economic-Sector?lang=en/
  # Download GHG_Econ_Can_Prov_Terr.csv

co2 <- read_csv("C:/Users/jlariscy/lifespan var in Canada/predictor variables/predictors_cleaned/GHG_Econ_Can_Prov_Terr.csv")

co2 <- co2 |>
       mutate(Year = as.character(Year)) |>
       filter(Source == "Provincial Inventory Total",
              Year >= 2000 & Year <= 2019) |>
       rename(year = Year,
              province = Region,
              co2 = `CO2 (kt)`) |>
       select(year, province, co2) |>
       arrange(province) |>
       mutate(province = recode(province, 
                                "Newfoundland and Labrador" = "nfl",
                                "Prince Edward Island" = "pei",
                                "Nova Scotia" = "nsc",
                                "New Brunswick" = "nbr",
                                "Quebec" = "que",
                                "Ontario" = "ont",
                                "Manitoba" = "man",
                                "Saskatchewan" = "sas",
                                "Alberta" = "alb",
                                "British Columbia" = "bco"))

# Merge co2 and population files          
co2_per_cap <- merge(co2, pop, by = c("province", "year"))

# Change co2 from character to numeric
co2_per_cap$co2 <- as.numeric(co2_per_cap$co2)

# Calculate co2 per 10,000 population
  # co2 is character
co2_per_cap$co2_per_cap = 1000*co2_per_cap$co2 / co2_per_cap$pop
summary(co2_per_cap$co2_per_cap)

# Remove columns for co2 and population
co2_per_cap <- co2_per_cap[c("year", "province", "co2_per_cap")]

co2_per_cap <- as.tibble(co2_per_cap)

# Population density
  # land mass in km^2
  # Source: https://www150.statcan.gc.ca/n1/pub/11-402-x/2010000/chap/geo/tbl/tbl07-eng.htm

density <- pop

density$land_mass <- NA
density$land_mass[density$province == "alb"] = 642317
density$land_mass[density$province == "bco"] = 925186
density$land_mass[density$province == "man"] = 553556
density$land_mass[density$province == "nbr"] = 71450
density$land_mass[density$province == "nfl"] = 373872
density$land_mass[density$province == "nsc"] = 53338
density$land_mass[density$province == "ont"] = 917741
density$land_mass[density$province == "pei"] = 5660
density$land_mass[density$province == "que"] = 1365128
density$land_mass[density$province == "sas"] = 591670

density$density <- density$pop / density$land_mass

density <- density |>
  select(year, province, density)

summary(density$density)


# Unemployment rate
  # Data from 1976-2025

unemp <- get_cansim("14-10-0327-02") |>
  mutate(GeoUID = as.numeric(GeoUID)) |>
  filter(REF_DATE >= 2000 & REF_DATE <= 2019,
         GeoUID >= 10 & GeoUID <= 59,
         `Labour force characteristics` == "Unemployment rate",
         `Age group` == "25 years and over",
         Gender == "Total - Gender") |>
  rename(year = REF_DATE,
         province = GEO,
         unemp = VALUE) |>
  select(year, province, unemp)

unemp <- unemp |>
  mutate(province = fct_recode(province,
                               "nfl" = "Newfoundland and Labrador",
                               "pei" = "Prince Edward Island",
                               "nsc" = "Nova Scotia",
                               "nbr" = "New Brunswick",
                               "que" = "Quebec",
                               "ont" = "Ontario",
                               "man" = "Manitoba",
                               "sas" = "Saskatchewan",
                               "alb" = "Alberta",
                               "bco" = "British Columbia"))

# Change province from factor to character so it can be sorted into 
# alphabetical order
unemp$province <- as.character(unemp$province)
unemp <- unemp[order(unemp$province), ]
summary(unemp$unemp)



# Merge data sets by year and province
  # Each data frame is a tibble with 200 rows and 3 columns. year is character, 
  # province is character, and the unique variable is double.



# Place all your data frames into a single list
df_list <- list(e_dagger, ed_med, ed_high, gini, density, crime, co2_per_cap, 
                phys_per_cap, unemp)

# Iteratively apply a full join across the entire list by grouping columns
predictors <- df_list |> 
  reduce(full_join, by = c("province", "year"))


# Replace Table 1. Descriptive Statistics by Wijesinghe et al.
install.packages("gtsummary")
library(gtsummary)

tbl_summary(predictors, include = -c(province, year),
            statistic = list(all_continuous() ~ "{N_obs} {mean} {sd} {median} {min} {max}"))

predictors |>
  tbl_summary(include = -c(province, year),
  statistic = list(all_continuous() ~ "{mean} {sd} {median} {min} {max}"),
  digits = all_continuous() ~ 2) |>
  add_n() |>
  modify_header(label = "Variable", "N", "Mean", "SD", "Median", "Min.", "Max.")
