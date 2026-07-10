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


# Mid-year population ##########################################################
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


# Population growth ###########################################################

# Other option
install.packages("curl")
install.packages("readxl")
library(curl)
library(readxl)

url <- "https://www.cihi.ca/sites/default/files/document/nhex-appendices-a-d-2025-en.xlsx"
destfile <- "nhex-appendices-a-d-2025-en.xlsx"
curl_download(url, destfile)
growth <- read_excel(destfile, sheet = "D — Pop", range = "A56:O107")


growth <- growth |>
  filter(Year >= 2000 & Year <= 2019) |>
  select(-c("Y.T.", "N.W.T.", "Nun.", "Canada")) |>
  rename("year" = "Year", "nfl" = "N.L.", "pei" = "P.E.I.", "nsc" = "N.S.",
         "nbr" = "N.B.", "que" = "Que.", "ont" = "Ont.", "man" = "Man.",
         "sas" = "Sask.", "alb" = "Alta.", "bco" = "B.C.")

# Change from wide to long
growth_long <- growth |>
  pivot_longer(cols = c("nfl", "pei", "nsc", "nbr", "que",
                        "ont", "man", "sas", "alb", "bco"),
               names_to = "province",
               values_to = "pop_growth")
growth_long$pop_growth <- as.numeric((growth_long$pop_growth))
summary(growth_long$pop_growth)

# Gini coefficient ############################################################
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


# Educational attainment #######################################################
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


# Log real per capita income #################################################
  # In 2024 constant dollars

income <- get_cansim("11-10-0239-01") |>
  mutate(GeoUID = as.numeric(GeoUID),
         log_income = log10(VALUE)) |>
  filter(REF_DATE >= 2000 & REF_DATE <= 2019,
         `Age group` == "15 years and over",
         Gender == "Total - Gender",
         Statistics == "Average income (excluding zeros)",
         `Income source` == "Total income",
         GeoUID >= 10 & GeoUID <= 59)

# Clean
income <- income |>
  rename(year = REF_DATE,
         province = GEO) |>
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
  select(year, province, log_income)

income$province <- as.character(income$province)
income <- income[order(income$province), ]
summary(income$log_income)


# Violent crime rate ##########################################################

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


# Percentage foreign-born ######################################################
# From Census years 2001, 2006, 2011, 2016, and 2021


# Percentage indigenous ########################################################
  # From Census years 2001, 2006, 2011, 2016, and 2021


# Number of physicians #########################################################
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


# Cigarette sales ##########################################################
  # Visit https://health-infobase.canada.ca/substance-use/tobacco/sales/
  # Download "Data - Tobacco sales.csv"
  # This source combines tobacco sales for PEI with Yukon, Northwest Territories, and Nunavut
#cigs <- read_csv("https://health-infobase.canada.ca/src/data/tobacco-sales/reformatted_data_2024.csv")


# Smoking prevalence
  # Wijesinghe et al. used cigarette sales (packs per capita)

smoke <- read_csv("C:/Users/jlariscy/lifespan var in Canada/predictor variables/predictors_cleaned/table_2_1_smoking_prevalence_by_province_99-20.csv")
names(smoke)[1] <- "province"
smoke <- smoke[-1, ]  # remove Canada

# Vector names are numbers. I add a character to beginning.
colnames(smoke) <- paste0("yr", colnames(smoke))
colnames(smoke)[1] <- "province"
smoke <- subset(smoke, select = -c(yr1999, yr2020))

# Change from wide to long
smoke_long <- smoke |>
  pivot_longer(cols = starts_with("yr"),
               names_to = "year",
               values_to = "smoke")

smoke_long$year <- substring(smoke_long$year, 3)  # remove yr from beginning of years
smoke_long$year <- as.numeric(smoke_long$year)

smoke_long <- smoke_long |>
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

# Add rows for years with missing smoking prevalence values
new_rows <- data.frame(province = rep(c("nfl", "pei", "nsc", "nbr", "que",
                                        "ont", "man", "sas", "alb", "bco"), each = 3),
                       year = rep(c(2014, 2016, 2018), times = 10),
                       smoke = rep(NA, times = 30))

smoke_long <- rbind(smoke_long, new_rows)

smoke_long <- smoke_long[order(smoke_long$province, smoke_long$year), ]


ggplot(smoke_long, aes(x = year, y = smoke, color = province)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  geom_vline(xintercept = c(2014, 2016, 2018), linetype = "dashed")

# Impute missing smoke values in 2014, 2016, and 2018 by province
install.packages("simputation")
library(simputation)

smoke_long$yr0 <- smoke_long$year - 2000

smoke_long_imp <- smoke_long |>
  group_by(province) |>
  impute_lm(smoke ~ yr0)

smoke_long_imp$year <- as.character(smoke_long_imp$year)

smoke_long_imp <- smoke_long_imp |>
  select(year, province, smoke)

summary(smoke_long_imp$smoke)


# CO2 emissions ################################################################
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


# Population density ###########################################################
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



# Total personal health care (% GDP) #########################################
options(scipen = 999)

# GDP data
  # in 2017 or 2012 dollars
gdp <- get_cansim("36-10-0222-01") |>
  mutate(GeoUID = as.numeric(GeoUID)) |>
  filter(REF_DATE >= 2000 & REF_DATE <= 2019,
         GeoUID >= 10 & GeoUID <= 59,
         Estimates == "Final consumption expenditure",
         Prices == "2017 constant prices") |>
  rename(year = REF_DATE,
         province = GEO,
         gdp = val_norm) |>
  select(year, province, gdp)

gdp <- gdp |>
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


# Health expenditure data
url2 <- "https://www.cihi.ca/sites/default/files/document/nhex-open-data-2025-en.xlsx"
destfile2 <- "nhex-open-data-2025-en.xlsx"
curl_download(url2, destfile2)
hlth_spend <- read_excel(destfile2, sheet = "Table O.1", range = "A3:I27849")

hlth_spend <- hlth_spend |>
  filter(`Use of Funds` == "Total",
         Year >= 2000 & Year <= 2019,
         Sector == "Provincial Government",
         Province != "Canada") |>
  rename(year = Year,
         province = Province,
         hlth_spend = `Constant 2010 dollars`) |>
  mutate(hlth_spend = as.numeric(hlth_spend),
         hlth_spend = 1.07 * hlth_spend) |>
  select(year, province, hlth_spend)
  # Multiply hlth_spend by 1.07 to convert 2010 constant dollars to 2017 
  # constant dollars to match gdp

hlth_spend <- hlth_spend |>
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

# Merge
hlth_spend_pct <- merge(gdp, hlth_spend, by = c("province", "year"))

hlth_spend_pct$hlth_spend_pct <- 100 * hlth_spend_pct$hlth_spend / hlth_spend_pct$gdp
summary(hlth_spend_pct$hlth_spend_pct)

hlth_spend_pct <- hlth_spend_pct |>
  mutate(province = as.character(province)) |>
  select(year, province, hlth_spend_pct)


# Unemployment rate ############################################################
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


# Percentage employed in manufacturing #####################################
  # Table begins with over a million observations

manufacture <- get_cansim("14-10-0023-01") |>
  mutate(GeoUID = as.numeric(GeoUID)) |>
  filter(REF_DATE >= 2000 & REF_DATE <= 2019,
         GeoUID >= 10 & GeoUID <= 59,
         Gender == "Total - Gender",
         `Age group` == "15 years and over",
         `North American Industry Classification System (NAICS)` == "Total, all industries" |
         `North American Industry Classification System (NAICS)` == "Manufacturing",
         `Labour force characteristics` == "Employment")



# Merge data sets by year and province ######################################
  # Each data frame is a tibble with 200 rows and 3 columns. year is character, 
  # province is character, and the unique variable is double.


# Place all your data frames into a single list
df_list <- list(e_dagger, ed_med, ed_high, gini, density, growth_long, crime, 
                smoke_long_imp, hlth_spend_pct, co2_per_cap, phys_per_cap, 
                unemp, income)

# Iteratively apply a full join across the entire list by grouping columns
predictors <- df_list |> 
  reduce(full_join, by = c("province", "year"))


# Replicate Table 1. Descriptive Statistics by Wijesinghe et al.
install.packages("gt")
install.packages("gtsummary")
library(gt)
library(gtsummary)

install.packages("flextable")
library(flextable)



predictors |>
  tbl_wide_summary(include = -c(province, year),
              statistic = c("{N_obs}", "{mean}", "{sd}", "{median}", "{min}", "{max}"),
              digits = all_continuous() ~ c(0, 2, 2, 2, 2, 2),
  label = list(edag = "Life disparity at birth (*e*<sup>\u2020</sup>)",
              ed_med = "% postsecondary education",
              ed_high = "% college graduate",
              gini = "Gini coefficient",
              density = "Population density",
              pop_growth = "Population growth (%)",
              crime = "Violent crime rate (per 10,000)",
              smoke = "Smoking prevalence",
              hlth_spend_pct = "Healthcare as % of GDP",
              co2_per_cap = "CO<sub>2</sub> per capita",
              phys_per_cap = "Physicians (per 10,000)",
              unemp = "Unemployment rate (%)",
              log_income = "Log real income per capita"))|>
  modify_header(label = "Variables",
                stat_1 = "N",
                stat_2 = "Mean",
                stat_3 = "Std. Dev.",
                stat_4 = "Median",
                stat_5 = "Min.",
                stat_6 = "Max.") |>
  as_gt() |>
    tab_header(title = md("**Table 1.** Descriptive statistics for regression variables")) |>  
    opt_align_table_header(align = "left") |>
    tab_options(heading.title.font.size = px(16),
                table_body.hlines.style = "none",
                table.font.names = "serif",
                table.border.top.color = "white",
                heading.border.bottom.color = "black",
                column_labels.border.bottom.color = "black",
                table_body.border.bottom.color = "black",
                table.font.color = "black") |>
  opt_vertical_padding(scale = 0.2) |>
  gt::fmt_markdown(columns = c(label))  # This allows sup
  
  # gt::fmt_markdown(columns = c(label)) ... This allows both superscript and 
  #   subscript in row labels.

# If only using subscript or superscript, this option works after as_gt()
#  text_transform(
#    locations = cells_body(),
#    fn = function(x) {
#      str_replace_all(x,
#                      pattern = "@",
#                      replacement = "<sub>") %>% 
#        str_replace_all("~",
#                        "</sub>") }
#  ) 

# source for subscript: https://stackoverflow.com/questions/60534214/how-do-i-add-subscripts-to-labels-in-tables-using-the-gtsummary-package-in-r

#show_header_names(table1)

