
install.packages("HMDHFDplus")
install.packages("remotes")
install.packages("dplyr")

library(HMDHFDplus)
library(remotes)
library(dplyr)

install_github("alysonvanraalte/LifeIneq")
library(LifeIneq)


getCHMDprovinces()

# Read in life table data for Canada overall and the provinces/territories
# 1x1 = one-year age interval × one-year year interval

# Read-in province-specific life tables for both sexes combined
alb_reg <- readCHMDweb("alb", "bltper_1x1")  # both, Alberta
bco_reg <- readCHMDweb("bco", "bltper_1x1")  # both, British Columbia
man_reg <- readCHMDweb("man", "bltper_1x1")  # both, Manitoba
nbr_reg <- readCHMDweb("nbr", "bltper_1x1")  # both, New Brunswick
nfl_reg <- readCHMDweb("nfl", "bltper_1x1")  # both, Newfoundland and Labrador
nsc_reg <- readCHMDweb("nsc", "bltper_1x1")  # both, Nova Scotia
ont_reg <- readCHMDweb("ont", "bltper_1x1")  # both, Ontario
pei_reg <- readCHMDweb("pei", "bltper_1x1")  # both, Prince Edward Island
que_reg <- readCHMDweb("que", "bltper_1x1")  # both, Quebec
sas_reg <- readCHMDweb("sas", "bltper_1x1")  # both, Saskatchewan

# Limit to one-year intervals 2000 to 2019
alb_reg <- alb_reg[alb_reg$Year >= 2000 & alb_reg$Year <= 2019, ]
bco_reg <- bco_reg[bco_reg$Year >= 2000 & bco_reg$Year <= 2019, ]
man_reg <- man_reg[man_reg$Year >= 2000 & man_reg$Year <= 2019, ]
nbr_reg <- nbr_reg[nbr_reg$Year >= 2000 & nbr_reg$Year <= 2019, ]
nfl_reg <- nfl_reg[nfl_reg$Year >= 2000 & nfl_reg$Year <= 2019, ]
nsc_reg <- nsc_reg[nsc_reg$Year >= 2000 & nsc_reg$Year <= 2019, ]
ont_reg <- ont_reg[ont_reg$Year >= 2000 & ont_reg$Year <= 2019, ]
pei_reg <- pei_reg[pei_reg$Year >= 2000 & pei_reg$Year <= 2019, ]
que_reg <- que_reg[que_reg$Year >= 2000 & que_reg$Year <= 2019, ]
sas_reg <- sas_reg[sas_reg$Year >= 2000 & sas_reg$Year <= 2019, ]

# Add column with province abbreviation
alb_reg <- cbind(province = "alb", alb_reg)
bco_reg <- cbind(province = "bco", bco_reg)
man_reg <- cbind(province = "man", man_reg)
nbr_reg <- cbind(province = "nbr", nbr_reg)
nfl_reg <- cbind(province = "nfl", nfl_reg)
nsc_reg <- cbind(province = "nsc", nsc_reg)
ont_reg <- cbind(province = "ont", ont_reg)
pei_reg <- cbind(province = "pei", pei_reg)
que_reg <- cbind(province = "que", que_reg)
sas_reg <- cbind(province = "sas", sas_reg)


# Calculate e-dagger for each year of each province

# Years to calculate
years <- 2000:2019


# Alberta

# Empty list to store results
results <- vector("list", length(years))

for (i in seq_along(years)) {
  yr <- years[i]
  dat <- alb_reg[alb_reg$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("province", "Year", "edag")]
}

# Combine all years into one data frame
alb_reg_edag <- do.call(rbind, results)


# British Columbia

# Empty list to store results
results <- vector("list", length(years))

for (i in seq_along(years)) {
  yr <- years[i]
  dat <- bco_reg[bco_reg$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("province", "Year", "edag")]
}

# Combine all years into one data frame
bco_reg_edag <- do.call(rbind, results)


# Manitoba

# Empty list to store results
results <- vector("list", length(years))

for (i in seq_along(years)) {
  yr <- years[i]
  dat <- man_reg[man_reg$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("province", "Year", "edag")]
}

# Combine all years into one data frame
man_reg_edag <- do.call(rbind, results)


# New Brunswick

# Empty list to store results
results <- vector("list", length(years))

for (i in seq_along(years)) {
  yr <- years[i]
  dat <- nbr_reg[nbr_reg$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("province", "Year", "edag")]
}

# Combine all years into one data frame
nbr_reg_edag <- do.call(rbind, results)


# Newfoundland

# Empty list to store results
results <- vector("list", length(years))

for (i in seq_along(years)) {
  yr <- years[i]
  dat <- nfl_reg[nfl_reg$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("province", "Year", "edag")]
}

# Combine all years into one data frame
nfl_reg_edag <- do.call(rbind, results)


# Nova Scotia

# Empty list to store results
results <- vector("list", length(years))

for (i in seq_along(years)) {
  yr <- years[i]
  dat <- nsc_reg[nsc_reg$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("province", "Year", "edag")]
}

# Combine all years into one data frame
nsc_reg_edag <- do.call(rbind, results)


# Ontario

# Empty list to store results
results <- vector("list", length(years))

for (i in seq_along(years)) {
  yr <- years[i]
  dat <- ont_reg[ont_reg$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("province", "Year", "edag")]
}

# Combine all years into one data frame
ont_reg_edag <- do.call(rbind, results)


# Prince Edward Island
  # Error in check_ex(x, age) : diff(age + ex) >= 0 are not all TRUE.
  # The issue happens in 2009.

pei_reg_2009 <- pei_reg[pei_reg$Year == 2009, ]

# When running ineq() for PEI in 2009, I received the following error message:
# Error in check_ex(x, age) : diff(age + ex) >= 0 are not all TRUE

pei_reg_2009$xplusex <- pei_reg_2009$Age + pei_reg_2009$ex
#diff <- diff(pei_reg_2009$xplusex)

for (x in 1:111) {
  pei_reg_2009$diff[1:111] <- diff(pei_reg_2009$xplusex[1:111])
}
  # The problem happens with the difference between ages 16 and 17.

# Solution
pei_reg_2009$ex[17] <- pei_reg_2009$ex[17] + 0.000000000000015
pei_reg_2009$ex[18] <- pei_reg_2009$ex[18] + 0.000000000000028
pei_reg_2009$ex[19] <- pei_reg_2009$ex[19] + 0.000000000000028

# Drop the two columns I created for 2009 to diagnose the problem.
pei_reg_2009 <- subset(pei_reg_2009, select = -c(xplusex, diff))

# Add the corrected 2009 life table back in to the PEI life tables
pei_reg_2000_2008 <- pei_reg[pei_reg$Year >= 2000 & pei_reg$Year <= 2008, ]
pei_reg_2010_2019 <- pei_reg[pei_reg$Year >= 2010 & pei_reg$Year <= 2019, ]

pei_reg <- rbind(pei_reg_2000_2008, pei_reg_2009, pei_reg_2010_2019)

# Empty list to store results
results <- vector("list", length(years))

for (i in seq_along(years)) {
  yr <- years[i]
  dat <- pei_reg[pei_reg$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("province", "Year", "edag")]
}

# Combine all years into one data frame
pei_reg_edag <- do.call(rbind, results)


# Quebec

# Empty list to store results
results <- vector("list", length(years))

for (i in seq_along(years)) {
  yr <- years[i]
  dat <- que_reg[que_reg$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("province", "Year", "edag")]
}

# Combine all years into one data frame
que_reg_edag <- do.call(rbind, results)


# Saskatchewan

# Empty list to store results
results <- vector("list", length(years))

for (i in seq_along(years)) {
  yr <- years[i]
  dat <- sas_reg[sas_reg$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("province", "Year", "edag")]
}

# Combine all years into one data frame
sas_reg_edag <- do.call(rbind, results)


# Combine e-dagger-0 values for all 10 provinces
e_dagger <- rbind(alb_reg_edag, bco_reg_edag, man_reg_edag, nbr_reg_edag,
                  nfl_reg_edag, nsc_reg_edag, ont_reg_edag, pei_reg_edag,
                  que_reg_edag, sas_reg_edag)

rm(alb_reg, alb_reg_edag, bco_reg, bco_reg_edag, man_reg, man_reg_edag,
   nbr_reg, nbr_reg_edag, nfl_reg, nfl_reg_edag, nsc_reg, nsc_reg_edag,
   ont_reg, ont_reg_edag, pei_reg, pei_reg_edag, que_reg, que_reg_edag,
   sas_reg, sas_reg_edag, pei_reg_2000_2008, pei_reg_2009, pei_reg_2010_2019)

e_dagger <- e_dagger |>
  rename(year = Year) |>
  mutate(year = as.character(year))
