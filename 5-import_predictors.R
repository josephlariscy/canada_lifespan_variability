# Import predictor variables using the R package cansim
  # We limit to the ten provinces; we don't include the territories
  # We limit to years 2000-2019
  # Many variables are available yearly. % foreign-born and % indigenous are
  #   only available in Census years 2001, 2006, 2011, 2016, and 2021.


install.packages("cansim")
install.packages("readxl")
install.packages("reshape2")
install.packages("tidyverse")
library(cansim)
library(readxl)
library(reshape2)
library(tidyverse)


# Gini coefficient ############################################################
  # Three different measures: adjusted market income, adjusted total income, and
  # adjusted after-tax income. I picked "Adjusted total income."
  # Data from 1976 to 2024.
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


# Percentage foreign-born ######################################################
# From Census years 2001, 2006, 2011, 2016, and 2021

immigrant <- read_excel("C:/Users/jlariscy/lifespan var in Canada/predictor variables/predictors_cleaned/immigrant percentage.xlsx", sheet = "immigrants")

immigrant_long <- immigrant |>
  pivot_longer(cols = starts_with("20"),
               names_to = "year",
               values_to = "immigrant")

immigrant_long$year <- as.numeric(immigrant_long$year)
# convert year from character to numeric for lm lines in geom_smooth()

ggplot(immigrant_long, aes(x = year, y = immigrant, color = province)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

immigrant_long <- immigrant_long |>
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


# Add rows with missing values for immigrant % for intercensal years
new_rows_imm <- data.frame(province = rep(c("nfl", "pei", "nsc", "nbr", "que",
                                            "ont", "man", "sas", "alb", "bco"), each = 17),
                           year = rep(c(2000, 2002:2005, 2007:2010, 2012:2015, 2017:2020), times = 10),
                           immigrant = rep(NA, times = 170))

immigrant_long <- rbind(immigrant_long, new_rows_imm)
immigrant_long <- immigrant_long[order(immigrant_long$province, immigrant_long$year), ]


# Impute missing immigration percentages in intercensal years by province
install.packages("simputation")
library(simputation)

immigrant_long$yr0 <- immigrant_long$year - 2000

immigrant_long_imp <- immigrant_long |>
  group_by(province) |>
  impute_lm(immigrant ~ yr0)

# Convert year from numeric to character
immigrant_long_imp$year <- as.character(immigrant_long_imp$year)

immigrant_long_imp <- immigrant_long_imp |>
  filter(year >= 2000 & year <= 2019) |>
  select(year, province, immigrant)

summary(immigrant_long_imp$immigrant)


# Percentage indigenous ########################################################
# From Census years 2001, 2006, 2011, 2016, and 2021

indig <- read_excel("C:/Users/jlariscy/lifespan var in Canada/predictor variables/predictors_cleaned/aboriginal percentage.xlsx", sheet = "indigenous")

indig_long <- indig |>
  pivot_longer(cols = starts_with("20"),
               names_to = "year",
               values_to = "indigenous")

indig_long$year <- as.numeric(indig_long$year)
# convert year from character to numeric for lm lines in geom_smooth()

ggplot(indig_long, aes(x = year, y = indigenous, color = province)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

indig_long <- indig_long |>
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

# Add rows with missing values for indigenous % for intercensal years
new_rows_ind <- data.frame(province = rep(c("nfl", "pei", "nsc", "nbr", "que",
                                            "ont", "man", "sas", "alb", "bco"), each = 17),
                           year = rep(c(2000, 2002:2005, 2007:2010, 2012:2015, 2017:2020), times = 10),
                           indigenous = rep(NA, times = 170))

indig_long <- rbind(indig_long, new_rows_ind)
indig_long <- indig_long[order(indig_long$province, indig_long$year), ]

# Impute missing indigenous values in 2intercensal years by province

indig_long$yr0 <- indig_long$year - 2000

indig_long_imp <- indig_long |>
  group_by(province) |>
  impute_lm(indigenous ~ yr0)

# Convert year from numeric to character
indig_long_imp$year <- as.character(indig_long_imp$year)

indig_long_imp <- indig_long_imp |>
  filter(year >= 2000 & year <= 2019) |>
  select(year, province, indigenous)

summary(indig_long_imp$indigenous)



# Merge data sets by year and province ######################################
  # Each data frame is a tibble with 200 rows and 3 columns. year is character, 
  # province is character, and the unique variable is double.


# Place all your data frames into a single list
df_list <- list(e_dagger, indig_long_imp, immigrant_long_imp, ed_med, ed_high, 
                income, gini)

# Iteratively apply a full join across the entire list by grouping columns
predictors <- df_list |> 
  reduce(full_join, by = c("province", "year"))


# Save predictors dataset to share with Dustin and Ben
install.packages("haven")
library(haven)

write_dta(predictors, "predictors.dta")
write.csv(predictors, "predictors.csv", row.names = F)


# Replicate Table 1. Descriptive Statistics by Wijesinghe et al.
install.packages("flextable")
install.packages("gt")
install.packages("gtsummary")
install.packages("webshot2")  # needed for gt_save()
library(flextable)
library(gt)
library(gtsummary)
library(webshot2)


# Create table of descriptive statistics
descr_stats <- predictors |>
  tbl_wide_summary(include = -c(province, year),
              statistic = c("{mean}", "{sd}", "{median}", "{min}", "{max}"),
              digits = all_continuous() ~ c(2, 2, 2, 2, 2),
  label = list(edag = "Life disparity at birth (*e*<sup>\u2020</sup>)",
               indigenous = "% indigenous identity",
               immigrant = "% foreign-born",
               ed_med = "% postsecondary education",
               ed_high = "% college graduate",
               log_income = "Log real per capita income",
               gini = "Gini coefficient")) |>
  add_variable_group_header(header = "*Dependent variable*",
                            variables = edag) |>
  add_variable_group_header(header = "*Demographic predictors*",
                            variables = c(indigenous, immigrant)) |>
  add_variable_group_header(header = "*Socioeconomic predictors*",
                            variables = c(ed_med, ed_high, log_income, gini)) |>
  modify_header(label = "Variables",
                stat_1 = "Mean",
                stat_2 = "Std. Dev.",
                stat_3 = "Median",
                stat_4 = "Min.",
                stat_5 = "Max.") |>
  #modify_footer("Note: N = 200") |>
  as_gt() |>
    tab_header(title = md("**Table 2.** Descriptive statistics for regression variables")) |>  
    tab_source_note(source_note = md("Note: *N* = 200.")) |>
    opt_align_table_header(align = "left") |>
    tab_options(heading.title.font.size = px(16),
                source_notes.font.size = px(16),
                table_body.hlines.style = "none",
                table.font.names = "serif",
                table.border.top.color = "white",
                table.border.bottom.color = "white",
                heading.border.bottom.color = "black",
                column_labels.border.bottom.color = "black",
                table_body.border.bottom.color = "black",
                table.font.color = "black") |>
  opt_vertical_padding(scale = 0.2) |>
  gt::fmt_markdown(columns = c(label))  

descr_stats

# Save table of descriptive statistics

descr_stats |> 
  gtsave("C:/Users/jlariscy/lifespan var in Canada/canada_lifespan_variability/tables and figures/table2 - descr_stats.png")


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


# Correlation matrix
predictors_cor <- predictors |> select(-c(province, year))
cor(predictors_cor)
