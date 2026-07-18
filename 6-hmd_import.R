# Import life table data for Canada and other HMD countries

# Resources
# MPIDR working paper by Riffe about HMDHFDplus: 
# https://www.demogr.mpg.de/papers/technicalreports/tr-2015-004.pdf

install.packages("ggplot2")
install.packages("HMDHFDplus")
install.packages("remotes")
library(ggplot2)
library(HMDHFDplus)
library(remotes)

install_github("alysonvanraalte/LifeIneq")
library(LifeIneq)

HMDcountries <- getHMDcountries()

# Read in life table data for Canada overall and the provinces/territories
# 1x5 = one-year age interval × five-year year interval

# Read-in life tables for both sexes combined
# 1x5 indicates single year of age and five-year time periods

# Before importing life tables, input username and password 
  # us <- "joseph.lariscy@memphis.edu"
  # pw <- "M...n

# I will only include countries with life tables from 1950-55 to 2015-19

AUS <- readHMDweb(CNTRY = "AUS", item = "bltper_1x5", username=us, password=pw)  # Australia
AUT <- readHMDweb(CNTRY = "AUT", item = "bltper_1x5", username=us, password=pw)  # Austria
#BLR <- readHMDweb(CNTRY = "BLR", item = "bltper_1x5", username=us, password=pw)  # Belarus
BEL <- readHMDweb(CNTRY = "BEL", item = "bltper_1x5", username=us, password=pw)  # Belgium
BGR <- readHMDweb(CNTRY = "BEL", item = "bltper_1x5", username=us, password=pw)  # Bulgaria
CAN <- readHMDweb(CNTRY = "CAN", item = "bltper_1x5", username=us, password=pw)  # Canada
#CHL <- readHMDweb(CNTRY = "CHL", item = "bltper_1x5", username=us, password=pw)  # Chile
#HRV <- readHMDweb(CNTRY = "HRV", item = "bltper_1x5", username=us, password=pw)  # Croatia
CZE <- readHMDweb(CNTRY = "CZE", item = "bltper_1x5", username=us, password=pw)  # Czechia
DNK <- readHMDweb(CNTRY = "DNK", item = "bltper_1x5", username=us, password=pw)  # Denmark
#EST <- readHMDweb(CNTRY = "EST", item = "bltper_1x5", username=us, password=pw)  # Estonia
FIN <- readHMDweb(CNTRY = "FIN", item = "bltper_1x5", username=us, password=pw)  # Finland
FRATNP <- readHMDweb(CNTRY = "FRATNP", item = "bltper_1x5", username=us, password=pw)  # France
#DEUTNP <- readHMDweb(CNTRY = "DEUTNP", item = "bltper_1x5", username=us, password=pw)  # Germany
#GRC <- readHMDweb(CNTRY = "GRC", item = "bltper_1x5", username=us, password=pw)  # Greece
#HKG <- readHMDweb(CNTRY = "HKG", item = "bltper_1x5", username=us, password=pw)  # Hong Kong
HUN <- readHMDweb(CNTRY = "HUN", item = "bltper_1x5", username=us, password=pw)  # Hungary
ISL <- readHMDweb(CNTRY = "ISL", item = "bltper_1x5", username=us, password=pw)  # Iceland
IRL <- readHMDweb(CNTRY = "IRL", item = "bltper_1x5", username=us, password=pw)  # Ireland
#ISR <- readHMDweb(CNTRY = "ISR", item = "bltper_1x5", username=us, password=pw)  # Israel
ITA <- readHMDweb(CNTRY = "ITA", item = "bltper_1x5", username=us, password=pw)  # Italy
JPN <- readHMDweb(CNTRY = "JPN", item = "bltper_1x5", username=us, password=pw)  # Japan
#LVA <- readHMDweb(CNTRY = "LVA", item = "bltper_1x5", username=us, password=pw)  # Latvia
#LTU <- readHMDweb(CNTRY = "LTU", item = "bltper_1x5", username=us, password=pw)  # Lithuania
#LUX <- readHMDweb(CNTRY = "LUX", item = "bltper_1x5", username=us, password=pw)  # Luxembourg
NLD <- readHMDweb(CNTRY = "NLD", item = "bltper_1x5", username=us, password=pw)  # Netherlands
NZL_NP <- readHMDweb(CNTRY = "NZL_NP", item = "bltper_1x5", username=us, password=pw)  # New Zealand
NOR <- readHMDweb(CNTRY = "NOR", item = "bltper_1x5", username=us, password=pw)  # Norway
#POL <- readHMDweb(CNTRY = "POL", item = "bltper_1x5", username=us, password=pw)  # Poland
PRT <- readHMDweb(CNTRY = "PRT", item = "bltper_1x5", username=us, password=pw)  # Portugal
#KOR <- readHMDweb(CNTRY = "KOR", item = "bltper_1x5", username=us, password=pw)  # Republic of Korea
#RUS <- readHMDweb(CNTRY = "RUS", item = "bltper_1x5", username=us, password=pw)  # Russia
SVK <- readHMDweb(CNTRY = "SVK", item = "bltper_1x5", username=us, password=pw)  # Slovakia
#SVN <- readHMDweb(CNTRY = "SVN", item = "bltper_1x5", username=us, password=pw)  # Slovenia
ESP <- readHMDweb(CNTRY = "ESP", item = "bltper_1x5", username=us, password=pw)  # Spain
SWE <- readHMDweb(CNTRY = "SWE", item = "bltper_1x5", username=us, password=pw)  # Sweden
CHE <- readHMDweb(CNTRY = "CHE", item = "bltper_1x5", username=us, password=pw)  # Switzerland
#TWN <- readHMDweb(CNTRY = "TWN", item = "bltper_1x5", username=us, password=pw)  # Taiwan
GBRTENW <- readHMDweb(CNTRY = "GBRTENW", item = "bltper_1x5", username=us, password=pw)  # England and Wales
USA <- readHMDweb(CNTRY = "USA", item = "bltper_1x5", username=us, password=pw)  # United States
#UKR <- readHMDweb(CNTRY = "UKR", item = "bltper_1x5", username=us, password=pw)  # Ukraine


# Limit to five-year intervals 1950-1954 to 2015-2019
# Some countries do not have data for that entire period
AUS <- AUS[AUS$Year >= 1950 & AUS$Year <= 2015, ]
AUT <- AUT[AUT$Year >= 1950 & AUT$Year <= 2015, ]
BLR <- BLR[BLR$Year >= 1950 & BLR$Year <= 2015, ]
BEL <- BEL[BEL$Year >= 1950 & BEL$Year <= 2015, ]
BGR <- BGR[BGR$Year >= 1950 & BGR$Year <= 2015, ]
CAN <- CAN[CAN$Year >= 1950 & CAN$Year <= 2015, ]
CHL <- CHL[CHL$Year >= 1950 & CHL$Year <= 2015, ]
HRV <- HRV[HRV$Year >= 1950 & HRV$Year <= 2015, ]
CZE <- CZE[CZE$Year >= 1950 & CZE$Year <= 2015, ]
DNK <- DNK[DNK$Year >= 1950 & DNK$Year <= 2015, ]
EST <- EST[EST$Year >= 1950 & EST$Year <= 2015, ]
FIN <- FIN[FIN$Year >= 1950 & FIN$Year <= 2015, ]
FRATNP <- FRATNP[FRATNP$Year >= 1950 & FRATNP$Year <= 2015, ]
DEUTNP <- DEUTNP[DEUTNP$Year >= 1950 & DEUTNP$Year <= 2015, ]
GRC <- GRC[GRC$Year >= 1950 & GRC$Year <= 2015, ]
HKG <- HKG[HKG$Year >= 1950 & HKG$Year <= 2015, ]
HUN <- HUN[HUN$Year >= 1950 & HUN$Year <= 2015, ]
ISL <- ISL[ISL$Year >= 1950 & ISL$Year <= 2015, ]
IRL <- IRL[IRL$Year >= 1950 & IRL$Year <= 2015, ]
ISR <- ISR[ISR$Year >= 1950 & ISR$Year <= 2015, ]
ITA <- ITA[ITA$Year >= 1950 & ITA$Year <= 2015, ]
JPN <- JPN[JPN$Year >= 1950 & JPN$Year <= 2015, ]
LVA <- LVA[LVA$Year >= 1950 & LVA$Year <= 2015, ]
LTU <- LTU[LTU$Year >= 1950 & LTU$Year <= 2015, ]
LUX <- LUX[LUX$Year >= 1950 & LUX$Year <= 2015, ]
NLD <- NLD[NLD$Year >= 1950 & NLD$Year <= 2015, ]
NZL_NP <- NZL_NP[NZL_NP$Year >= 1950 & NZL_NP$Year <= 2015, ]
NOR <- NOR[NOR$Year >= 1950 & NOR$Year <= 2015, ]
POL <- POL[POL$Year >= 1950 & POL$Year <= 2015, ]
PRT <- PRT[PRT$Year >= 1950 & PRT$Year <= 2015, ]
KOR <- KOR[KOR$Year >= 1950 & KOR$Year <= 2015, ]
RUS <- RUS[RUS$Year >= 1950 & RUS$Year <= 2015, ]
SVK <- SVK[SVK$Year >= 1950 & SVK$Year <= 2015, ]
SVN <- SVN[SVN$Year >= 1950 & SVN$Year <= 2015, ]
ESP <- ESP[ESP$Year >= 1950 & ESP$Year <= 2015, ]
SWE <- SWE[SWE$Year >= 1950 & SWE$Year <= 2015, ]
CHE <- CHE[CHE$Year >= 1950 & CHE$Year <= 2015, ]
TWN <- TWN[TWN$Year >= 1950 & TWN$Year <= 2015, ]
GBRTENW <- GBRTENW[GBRTENW$Year >= 1950 & GBRTENW$Year <= 2015, ]
USA <- USA[USA$Year >= 1950 & USA$Year <= 2015, ]
UKR <- UKR[UKR$Year >= 1950 & UKR$Year <= 2015, ]



# Add column with province abbreviation
AUS <- cbind(country = "Australia", AUS)
AUT <- cbind(country = "Austria", AUT)
BLR <- cbind(country = "Belarus", BLR)
BEL <- cbind(country = "Belgium", BEL)
BGR <- cbind(country = "Bulgaria", BGR)
BGR <- cbind(country = "Bulgaria", BGR)
CAN <- cbind(country = "Canada", CAN)
CHL <- cbind(country = "Chile", CHL)
HRV <- cbind(country = "Bosnia", HRV)
CZE <- cbind(country = "Czechia", CZE)
DNK <- cbind(country = "Denmark", DNK)
EST <- cbind(country = "Estonia", EST)
FIN <- cbind(country = "Finland", FIN)
FRATNP <- cbind(country = "France", FRATNP)
DEUTNP <- cbind(country = "Germany", DEUTNP)
GRC <- cbind(country = "Greece", GRC)
HKG <- cbind(country = "Hong Kong", HKG)
HUN <- cbind(country = "Hungary", HUN)
ISL <- cbind(country = "Iceland", ISL)
IRL <- cbind(country = "Ireland", IRL)
ISR <- cbind(country = "Israel", ISR)
ITA <- cbind(country = "Italy", ITA)
JPN <- cbind(country = "Japan", JPN)
LVA <- cbind(country = "Latvia", LVA)
LTU <- cbind(country = "Lithuania", LTU)
LUX <- cbind(country = "Luxembourg", LUX)
NLD <- cbind(country = "Netherlands", NLD)
NZL_NP <- cbind(country = "New Zealand", NZL_NP)
NOR <- cbind(country = "Norway", NOR)
POL <- cbind(country = "Poland", POL)
PRT <- cbind(country = "Portugal", PRT)
KOR <- cbind(country = "Republic of Korea", KOR)
RUS <- cbind(country = "Russia", RUS)
SVK <- cbind(country = "Slovakia", SVK)
SVN <- cbind(country = "Slovenia", SVN)
ESP <- cbind(country = "Spain", ESP)
SWE <- cbind(country = "Sweden", SWE)
CHE <- cbind(country = "Switzerland", CHE)
TWN <- cbind(country = "Taiwan", TWN)
GBRTENW <- cbind(country = "England & Wales", GBRTENW)
USA <- cbind(country = "United States", USA)
UKR <- cbind(country = "Ukraine", UKR)


# Calculating e-dagger for each country, using a for loop

# Years to calculate
Year <- seq(from = 1950, to = 2015, by = 5)

# Australia

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- AUS[AUS$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
AUSedag <- do.call(rbind, results)


# Austria

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- AUT[AUT$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
AUTedag <- do.call(rbind, results)


# Belgium

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- BEL[BEL$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
BELedag <- do.call(rbind, results)


# Bulgaria

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- BGR[BGR$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
BGRedag <- do.call(rbind, results)


# Canada

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- CAN[CAN$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
CANedag <- do.call(rbind, results)


# Czechia

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- CZE[CZE$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
CZEedag <- do.call(rbind, results)


# Denmark

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- DNK[DNK$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
DNKedag <- do.call(rbind, results)


# Finland

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- FIN[FIN$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
FINedag <- do.call(rbind, results)


# France

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- FRATNP[FRATNP$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
FRATNPedag <- do.call(rbind, results)


# Hungary

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- HUN[HUN$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
HUNedag <- do.call(rbind, results)


# Iceland

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- ISL[ISL$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
ISLedag <- do.call(rbind, results)


# Ireland

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- IRL[IRL$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
IRLedag <- do.call(rbind, results)


# Italy

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- ITA[ITA$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
ITAedag <- do.call(rbind, results)


# Japan

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- JPN[JPN$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
JPNedag <- do.call(rbind, results)


# Netherlands

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- NLD[NLD$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
NLDedag <- do.call(rbind, results)


# New Zealand

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- NZL_NP[NZL_NP$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
NZL_NPedag <- do.call(rbind, results)


# Norway

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- NOR[NOR$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
NORedag <- do.call(rbind, results)


# Portugal

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- PRT[PRT$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
PRTedag <- do.call(rbind, results)


# Slovakia

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- SVK[SVK$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
SVKedag <- do.call(rbind, results)


# Spain

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- ESP[ESP$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
ESPedag <- do.call(rbind, results)


# Sweden

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- SWE[SWE$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
SWEedag <- do.call(rbind, results)


# Switzerland

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- CHE[CHE$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
CHEedag <- do.call(rbind, results)


# England and Wales

# Error with England and Wales in 2005-09
# Error in check_dx(x, lx) : 
# sum(dx)/lx[1] > 0.9999 & lx[1]/sum(dx) > 0.9999 is not TRUE
GBRTENW2005 <- GBRTENW[GBRTENW$Year == 2005, ]
write.csv(GBRTENW2005, "England and Wales 2005.csv", row.names = FALSE)
  # sum(dx) = 99,990

# I use the difference in lx values to calculate the dx series, and it sums
# to 100,000
GBRTENW2005$dx[1:110] <- GBRTENW2005$lx[1:110] - GBRTENW2005$lx[2:111] # ages 0-109
GBRTENW2005$dx[111] <- GBRTENW2005$lx[111]  # age 110

# Add the corrected 2005-09 life table back in to the E&W life tables
GBRTENW_1950_2000 <- GBRTENW[GBRTENW$Year >= 1950 & GBRTENW$Year <= 2000, ]
GBRTENW_2010_2015 <- GBRTENW[GBRTENW$Year >= 2010 & GBRTENW$Year <= 2015, ]

GBRTENW <- rbind(GBRTENW_1950_2000, GBRTENW2005, pei_reg_2010_2015)


# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- GBRTENW[GBRTENW$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
GBRTENWedag <- do.call(rbind, results)


# United States

# Empty list to store results
results <- vector("list", length(Year))

for (i in seq_along(Year)) {
  yr <- Year[i]
  dat <- USA[USA$Year == yr, ]
  dat$edag <- ineq(age = dat$Age, dx = dat$dx, lx = dat$lx, ex = dat$ex, ax = dat$ax, method = "edag")
  results[[i]] <- dat[dat$Age == 0,
                      c("country", "Year", "edag")]
}

# Combine all years into one data frame
USAedag <- do.call(rbind, results)


# row bind the life tables for all countries
HMD_edag <- rbind(AUSedag, AUTedag, BELedag, BGRedag, CANedag, CZEedag, 
                  DNKedag, FINedag, FRATNPedag, HUNedag, ISLedag, IRLedag, 
                  ITAedag, JPNedag, NLDedag, NZL_NPedag, NORedag, 
                  SVKedag, ESPedag, SWEedag, CHEedag, GBRTENWedag, USAedag)
  # I removed PRTedag (Portugal) because its e-dagger was much higher from
  # 1950 to 1980.

# Calculate average e-dagger by year
avg_edag <- HMD_edag |>
  group_by(Year) |>
  summarise(value = mean(edag)) |>
  mutate(type = "Average") |>
  rename(edag = value, country = type) |>
  relocate(country, Year, edag)

HMD_edag <- rbind(avg_edag, HMD_edag)


# Figure
install.packages("scales")
library(scales)

# Value labels for x-axis
year.lbl <- c("1950\u20131954", "1955\u20131959",
  "1960\u20131964", "1965\u20131969", "1970\u20131974",
              "1975\u20131979", "1980\u20131984", "1985\u20131989",
              "1990\u20131994", "1995\u20131999", "2000\u20132004",
              "2005\u20132009", "2010\u20132014", "2015\u20132019")
# \u2013 makes an endash

ggplot(HMD_edag, aes(x = Year, y = edag, color = country)) +
  geom_line()

ggplot(HMD_edag, aes(x = Year, y = edag, group = country)) +
       geom_line(data = HMD_edag, size = 0.8, color = "grey") +
       geom_line(data = CANedag, size = 1.1, color = "red") +
       geom_line(data = USAedag, size = 1.1, color = "blue") +
       geom_line(data = avg_edag, size = 1.1, color = "black") +
  ylab(expression(bold("Lifespan Disparity (")~bolditalic("e")~bold(""["0"]^"\u2020")~bold(")"))) +
  xlab(expression(bold("Year"))) +
theme_bw() +
  theme(axis.text.x = element_text(color = "black", angle = 45, hjust = 1),
        axis.text.y = element_text(color = "black"),
        text = element_text(family = "serif"),
        strip.text = element_text(face = "bold"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "inside") +
  coord_cartesian(ylim = c(8, 18)) +
  scale_y_continuous(labels = label_number(accuracy = 0.1), n.breaks = 6) +
  scale_x_continuous(breaks = seq(1950, 2015, by = 5), labels = year.lbl)
  

