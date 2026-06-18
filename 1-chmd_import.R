# R script to import Canadian Human Mortality Database

  # This project calculates lifespan inequality for each Canadian province/
  # territory. I replicate the article by Brown, Lariscy, and Walker (2023) 
  # that calculated state-level trends in lifespan variability but with Canadian
  # provinces/territories.


# Resources
  # MPIDR working paper by Riffe about HMDHFDplus: 
  # https://www.demogr.mpg.de/papers/technicalreports/tr-2015-004.pdf

install.packages("HMDHFDplus")
install.packages("remotes")
library(HMDHFDplus)
library(remotes)

install_github("alysonvanraalte/LifeIneq")
library(LifeIneq)


getCHMDprovinces()
# "alb" "bco" "can" "man" "nbr" "nfl" "nsc" "nwt" "ont" "pei" "que" "sas" "yuk"
  # alb: Alberta
  # bco: British Columbia
  # can: Canada
  # man: Manitoba
  # nbr: New Brunswick
  # nfl: Newfoundland
  # nsc: Nova Scotia
  # nwt: Northwest Territories
  # ont: Ontario
  # pei: Prince Edward Island
  # que: Quebec
  # sas: Saskatchewan
  # yuk: Yukon

    # Nunavut is not separately specified. It was part of Northwest Territory
    # until 1999.

# Read in life table data for Canada overall and the provinces/territories
  # 1x5 = one-year age interval × five-year year interval

# Read-in province-specific life tables for both sexes combined
b_alb <- readCHMDweb("alb", "bltper_1x5")  # both, Alberta
b_bco <- readCHMDweb("bco", "bltper_1x5")  # both, British Columbia
b_man <- readCHMDweb("man", "bltper_1x5")  # both, Manitoba
b_nbr <- readCHMDweb("nbr", "bltper_1x5")  # both, New Brunswick
b_nfl <- readCHMDweb("nfl", "bltper_1x5")  # both, Newfoundland and Labrador
b_nsc <- readCHMDweb("nsc", "bltper_1x5")  # both, Nova Scotia
b_nwt <- readCHMDweb("nwt", "bltper_1x5")  # both, Northwest Territories and Nunavut
b_ont <- readCHMDweb("ont", "bltper_1x5")  # both, Ontario
b_pei <- readCHMDweb("pei", "bltper_1x5")  # both, Prince Edward Island
b_que <- readCHMDweb("que", "bltper_1x5")  # both, Quebec
b_sas <- readCHMDweb("sas", "bltper_1x5")  # both, Saskatchewan
b_yuk <- readCHMDweb("yuk", "bltper_1x5")  # both, Yukon
b_can <- readCHMDweb("can", "bltper_1x5")  # both, Canada

# Read-in sex-specific and province-specific life tables

# Females
f_alb <- readCHMDweb("alb", "fltper_1x5")  # female, Alberta  
f_bco <- readCHMDweb("bco", "fltper_1x5")  # female, British Columbia
f_man <- readCHMDweb("man", "fltper_1x5")  # female, Manitoba
f_nbr <- readCHMDweb("nbr", "fltper_1x5")  # female, New Brunswick
f_nfl <- readCHMDweb("nfl", "fltper_1x5")  # female, Newfoundland and Labrador
f_nsc <- readCHMDweb("nsc", "fltper_1x5")  # female, Nova Scotia
f_nwt <- readCHMDweb("nwt", "fltper_1x5")  # female, Northwest Territories and Nunavut
f_ont <- readCHMDweb("ont", "fltper_1x5")  # female, Ontario
f_pei <- readCHMDweb("pei", "fltper_1x5")  # female, Prince Edward Island
f_que <- readCHMDweb("que", "fltper_1x5")  # female, Quebec
f_sas <- readCHMDweb("sas", "fltper_1x5")  # female, Saskatchewan
f_yuk <- readCHMDweb("yuk", "fltper_1x5")  # female, Yukon
f_can <- readCHMDweb("can", "fltper_1x5")  # female, Canada

# Males
m_alb <- readCHMDweb("alb", "mltper_1x5")  # male, Alberta  
m_bco <- readCHMDweb("bco", "mltper_1x5")  # male, British Columbia
m_man <- readCHMDweb("man", "mltper_1x5")  # male, Manitoba
m_nbr <- readCHMDweb("nbr", "mltper_1x5")  # male, New Brunswick
m_nfl <- readCHMDweb("nfl", "mltper_1x5")  # male, Newfoundland and Labrador
m_nsc <- readCHMDweb("nsc", "mltper_1x5")  # male, Nova Scotia
m_nwt <- readCHMDweb("nwt", "mltper_1x5")  # male, Northwest Territories and Nunavut
m_ont <- readCHMDweb("ont", "mltper_1x5")  # male, Ontario
m_pei <- readCHMDweb("pei", "mltper_1x5")  # male, Prince Edward Island
m_que <- readCHMDweb("que", "mltper_1x5")  # male, Quebec
m_sas <- readCHMDweb("sas", "mltper_1x5")  # male, Saskatchewan
m_yuk <- readCHMDweb("yuk", "mltper_1x5")  # male, Yukon
m_can <- readCHMDweb("can", "mltper_1x5")  # male, Canada

# The earliest year for most life tables is 1921.
# The earliest year for Newfoundland, Northwest Territories, and Yukon is 1950.
# The last interval for most provinces starts at 2020. The exception is Yukon;
# its last interval is 2015-2016.

# Limit to five-year intervals 1950-1954 to 2015-2019
b_alb <- b_alb[b_alb$Year >= 1950 & b_alb$Year <= 2015, ]
b_bco <- b_bco[b_bco$Year >= 1950 & b_bco$Year <= 2015, ]
b_man <- b_man[b_man$Year >= 1950 & b_man$Year <= 2015, ]
b_nbr <- b_nbr[b_nbr$Year >= 1950 & b_nbr$Year <= 2015, ]
b_nfl <- b_nfl[b_nfl$Year >= 1950 & b_nfl$Year <= 2015, ]
b_nsc <- b_nsc[b_nsc$Year >= 1950 & b_nsc$Year <= 2015, ]
b_nwt <- b_nwt[b_nwt$Year >= 1950 & b_nwt$Year <= 2015, ]
b_ont <- b_ont[b_ont$Year >= 1950 & b_ont$Year <= 2015, ]
b_pei <- b_pei[b_pei$Year >= 1950 & b_pei$Year <= 2015, ]
b_que <- b_que[b_que$Year >= 1950 & b_que$Year <= 2015, ]
b_sas <- b_sas[b_sas$Year >= 1950 & b_sas$Year <= 2015, ]
b_yuk <- b_yuk[b_yuk$Year >= 1950 & b_yuk$Year <= 2015, ]
b_can <- b_can[b_can$Year >= 1950 & b_can$Year <= 2015, ]

f_alb <- f_alb[f_alb$Year >= 1950 & f_alb$Year <= 2015, ]
f_bco <- f_bco[f_bco$Year >= 1950 & f_bco$Year <= 2015, ]
f_man <- f_man[f_man$Year >= 1950 & f_man$Year <= 2015, ]
f_nbr <- f_nbr[f_nbr$Year >= 1950 & f_nbr$Year <= 2015, ]
f_nfl <- f_nfl[f_nfl$Year >= 1950 & f_nfl$Year <= 2015, ]
f_nsc <- f_nsc[f_nsc$Year >= 1950 & f_nsc$Year <= 2015, ]
f_nwt <- f_nwt[f_nwt$Year >= 1950 & f_nwt$Year <= 2015, ]
f_ont <- f_ont[f_ont$Year >= 1950 & f_ont$Year <= 2015, ]
f_pei <- f_pei[f_pei$Year >= 1950 & f_pei$Year <= 2015, ]
f_que <- f_que[f_que$Year >= 1950 & f_que$Year <= 2015, ]
f_sas <- f_sas[f_sas$Year >= 1950 & f_sas$Year <= 2015, ]
f_yuk <- f_yuk[f_yuk$Year >= 1950 & f_yuk$Year <= 2015, ]
f_can <- f_can[f_can$Year >= 1950 & f_can$Year <= 2015, ]

m_alb <- m_alb[m_alb$Year >= 1950 & m_alb$Year <= 2015, ]
m_bco <- m_bco[m_bco$Year >= 1950 & m_bco$Year <= 2015, ]
m_man <- m_man[m_man$Year >= 1950 & m_man$Year <= 2015, ]
m_nbr <- m_nbr[m_nbr$Year >= 1950 & m_nbr$Year <= 2015, ]
m_nfl <- m_nfl[m_nfl$Year >= 1950 & m_nfl$Year <= 2015, ]
m_nsc <- m_nsc[m_nsc$Year >= 1950 & m_nsc$Year <= 2015, ]
m_nwt <- m_nwt[m_nwt$Year >= 1950 & m_nwt$Year <= 2015, ]
m_ont <- m_ont[m_ont$Year >= 1950 & m_ont$Year <= 2015, ]
m_pei <- m_pei[m_pei$Year >= 1950 & m_pei$Year <= 2015, ]
m_que <- m_que[m_que$Year >= 1950 & m_que$Year <= 2015, ]
m_sas <- m_sas[m_sas$Year >= 1950 & m_sas$Year <= 2015, ]
m_yuk <- m_yuk[m_yuk$Year >= 1950 & m_yuk$Year <= 2015, ]
m_can <- m_can[m_can$Year >= 1950 & m_can$Year <= 2015, ]


# I  use the LifeIneq package to calculate e-dagger
  # Source: https://rdrr.io/github/alysonvanraalte/LifeIneq/man/ineq_edag.html

# Calculating e-dagger for each five-year interval 1950-1954 to 2015-2019
  # I'm sure this could be done with a loop or lapply, but I could not find the
  # solution.

  # One approach that seemed promising was splitting the life table into 14 year
  # groups

    # f_can_list = split(f_can, f_can$Year)
    # View(f_can_list)
    # head(f_can_list$`1950`)

  # ...but I could not figure out how to then calculate e-dagger for the 
  # individual elements of the list.


# Canada, both sexes combined

b_can_1950 <- b_can[b_can$Year == 1950, ]
b_can_1950$edag <- ineq(age = b_can_1950$Age, 
                        dx = b_can_1950$dx, 
                        lx = b_can_1950$lx, 
                        ex = b_can_1950$ex, 
                        ax = b_can_1950$ax, 
                        method = 'edag')

b_can_1955 <- b_can[b_can$Year == 1955, ]
b_can_1955$edag <- ineq(age = b_can_1955$Age, 
                        dx = b_can_1955$dx, 
                        lx = b_can_1955$lx, 
                        ex = b_can_1955$ex, 
                        ax = b_can_1955$ax, 
                        method = 'edag')

b_can_1960 <- b_can[b_can$Year == 1960, ]
b_can_1960$edag <- ineq(age = b_can_1960$Age, 
                        dx = b_can_1960$dx, 
                        lx = b_can_1960$lx, 
                        ex = b_can_1960$ex, 
                        ax = b_can_1960$ax, 
                        method = 'edag')

b_can_1965 <- b_can[b_can$Year == 1965, ]
b_can_1965$edag <- ineq(age = b_can_1965$Age, 
                        dx = b_can_1965$dx, 
                        lx = b_can_1965$lx, 
                        ex = b_can_1965$ex, 
                        ax = b_can_1965$ax, 
                        method = 'edag')

b_can_1970 <- b_can[b_can$Year == 1970, ]
b_can_1970$edag <- ineq(age = b_can_1970$Age, 
                        dx = b_can_1970$dx, 
                        lx = b_can_1970$lx, 
                        ex = b_can_1970$ex, 
                        ax = b_can_1970$ax, 
                        method = 'edag')

b_can_1975 <- b_can[b_can$Year == 1975, ]
b_can_1975$edag <- ineq(age = b_can_1975$Age, 
                        dx = b_can_1975$dx, 
                        lx = b_can_1975$lx, 
                        ex = b_can_1975$ex, 
                        ax = b_can_1975$ax, 
                        method = 'edag')

b_can_1980 <- b_can[b_can$Year == 1980, ]
b_can_1980$edag <- ineq(age = b_can_1980$Age, 
                        dx = b_can_1980$dx, 
                        lx = b_can_1980$lx, 
                        ex = b_can_1980$ex, 
                        ax = b_can_1980$ax, 
                        method = 'edag')

b_can_1985 <- b_can[b_can$Year == 1985, ]
b_can_1985$edag <- ineq(age = b_can_1985$Age, 
                        dx = b_can_1985$dx, 
                        lx = b_can_1985$lx, 
                        ex = b_can_1985$ex, 
                        ax = b_can_1985$ax, 
                        method = 'edag')

b_can_1990 <- b_can[b_can$Year == 1990, ]
b_can_1990$edag <- ineq(age = b_can_1990$Age, 
                        dx = b_can_1990$dx, 
                        lx = b_can_1990$lx, 
                        ex = b_can_1990$ex, 
                        ax = b_can_1990$ax, 
                        method = 'edag')

b_can_1995 <- b_can[b_can$Year == 1995, ]
b_can_1995$edag <- ineq(age = b_can_1995$Age, 
                        dx = b_can_1995$dx, 
                        lx = b_can_1995$lx, 
                        ex = b_can_1995$ex, 
                        ax = b_can_1995$ax, 
                        method = 'edag')

b_can_2000 <- b_can[b_can$Year == 2000, ]
b_can_2000$edag <- ineq(age = b_can_2000$Age, 
                        dx = b_can_2000$dx, 
                        lx = b_can_2000$lx, 
                        ex = b_can_2000$ex, 
                        ax = b_can_2000$ax, 
                        method = 'edag')

b_can_2005 <- b_can[b_can$Year == 2005, ]
b_can_2005$edag <- ineq(age = b_can_2005$Age, 
                        dx = b_can_2005$dx, 
                        lx = b_can_2005$lx, 
                        ex = b_can_2005$ex, 
                        ax = b_can_2005$ax, 
                        method = 'edag')

b_can_2010 <- b_can[b_can$Year == 2010, ]
b_can_2010$edag <- ineq(age = b_can_2010$Age, 
                        dx = b_can_2010$dx, 
                        lx = b_can_2010$lx, 
                        ex = b_can_2010$ex, 
                        ax = b_can_2010$ax, 
                        method = 'edag')

b_can_2015 <- b_can[b_can$Year == 2015, ]
b_can_2015$edag <- ineq(age = b_can_2015$Age, 
                        dx = b_can_2015$dx, 
                        lx = b_can_2015$lx, 
                        ex = b_can_2015$ex, 
                        ax = b_can_2015$ax, 
                        method = 'edag')

# combine the five-year-specific life tables into one long table
b_can <- rbind(b_can_1950, b_can_1955, b_can_1960, b_can_1965, b_can_1970,
               b_can_1975, b_can_1980, b_can_1985, b_can_1990, b_can_1995,
               b_can_2000, b_can_2005, b_can_2010, b_can_2015)
# remove the five-year-specific life tables
rm(b_can_1950, b_can_1955, b_can_1960, b_can_1965, b_can_1970,
   b_can_1975, b_can_1980, b_can_1985, b_can_1990, b_can_1995,
   b_can_2000, b_can_2005, b_can_2010, b_can_2015)


# Alberta, both sexes combined

b_alb_1950 <- b_alb[b_alb$Year == 1950, ]
b_alb_1950$edag <- ineq(age = b_alb_1950$Age, 
                        dx = b_alb_1950$dx, 
                        lx = b_alb_1950$lx, 
                        ex = b_alb_1950$ex, 
                        ax = b_alb_1950$ax, 
                        method = 'edag')

b_alb_1955 <- b_alb[b_alb$Year == 1955, ]
b_alb_1955$edag <- ineq(age = b_alb_1955$Age, 
                        dx = b_alb_1955$dx, 
                        lx = b_alb_1955$lx, 
                        ex = b_alb_1955$ex, 
                        ax = b_alb_1955$ax, 
                        method = 'edag')

b_alb_1960 <- b_alb[b_alb$Year == 1960, ]
b_alb_1960$edag <- ineq(age = b_alb_1960$Age, 
                        dx = b_alb_1960$dx, 
                        lx = b_alb_1960$lx, 
                        ex = b_alb_1960$ex, 
                        ax = b_alb_1960$ax, 
                        method = 'edag')

b_alb_1965 <- b_alb[b_alb$Year == 1965, ]
b_alb_1965$edag <- ineq(age = b_alb_1965$Age, 
                        dx = b_alb_1965$dx, 
                        lx = b_alb_1965$lx, 
                        ex = b_alb_1965$ex, 
                        ax = b_alb_1965$ax, 
                        method = 'edag')

b_alb_1970 <- b_alb[b_alb$Year == 1970, ]
b_alb_1970$edag <- ineq(age = b_alb_1970$Age, 
                        dx = b_alb_1970$dx, 
                        lx = b_alb_1970$lx, 
                        ex = b_alb_1970$ex, 
                        ax = b_alb_1970$ax, 
                        method = 'edag')

b_alb_1975 <- b_alb[b_alb$Year == 1975, ]
b_alb_1975$edag <- ineq(age = b_alb_1975$Age, 
                        dx = b_alb_1975$dx, 
                        lx = b_alb_1975$lx, 
                        ex = b_alb_1975$ex, 
                        ax = b_alb_1975$ax, 
                        method = 'edag')

b_alb_1980 <- b_alb[b_alb$Year == 1980, ]
b_alb_1980$edag <- ineq(age = b_alb_1980$Age, 
                        dx = b_alb_1980$dx, 
                        lx = b_alb_1980$lx, 
                        ex = b_alb_1980$ex, 
                        ax = b_alb_1980$ax, 
                        method = 'edag')

b_alb_1985 <- b_alb[b_alb$Year == 1985, ]
b_alb_1985$edag <- ineq(age = b_alb_1985$Age, 
                        dx = b_alb_1985$dx, 
                        lx = b_alb_1985$lx, 
                        ex = b_alb_1985$ex, 
                        ax = b_alb_1985$ax, 
                        method = 'edag')

b_alb_1990 <- b_alb[b_alb$Year == 1990, ]
b_alb_1990$edag <- ineq(age = b_alb_1990$Age, 
                        dx = b_alb_1990$dx, 
                        lx = b_alb_1990$lx, 
                        ex = b_alb_1990$ex, 
                        ax = b_alb_1990$ax, 
                        method = 'edag')

b_alb_1995 <- b_alb[b_alb$Year == 1995, ]
b_alb_1995$edag <- ineq(age = b_alb_1995$Age, 
                        dx = b_alb_1995$dx, 
                        lx = b_alb_1995$lx, 
                        ex = b_alb_1995$ex, 
                        ax = b_alb_1995$ax, 
                        method = 'edag')

b_alb_2000 <- b_alb[b_alb$Year == 2000, ]
b_alb_2000$edag <- ineq(age = b_alb_2000$Age, 
                        dx = b_alb_2000$dx, 
                        lx = b_alb_2000$lx, 
                        ex = b_alb_2000$ex, 
                        ax = b_alb_2000$ax, 
                        method = 'edag')

b_alb_2005 <- b_alb[b_alb$Year == 2005, ]
b_alb_2005$edag <- ineq(age = b_alb_2005$Age, 
                        dx = b_alb_2005$dx, 
                        lx = b_alb_2005$lx, 
                        ex = b_alb_2005$ex, 
                        ax = b_alb_2005$ax, 
                        method = 'edag')

b_alb_2010 <- b_alb[b_alb$Year == 2010, ]
b_alb_2010$edag <- ineq(age = b_alb_2010$Age, 
                        dx = b_alb_2010$dx, 
                        lx = b_alb_2010$lx, 
                        ex = b_alb_2010$ex, 
                        ax = b_alb_2010$ax, 
                        method = 'edag')

b_alb_2015 <- b_alb[b_alb$Year == 2015, ]
b_alb_2015$edag <- ineq(age = b_alb_2015$Age, 
                        dx = b_alb_2015$dx, 
                        lx = b_alb_2015$lx, 
                        ex = b_alb_2015$ex, 
                        ax = b_alb_2015$ax, 
                        method = 'edag')

b_alb <- rbind(b_alb_1950, b_alb_1955, b_alb_1960, b_alb_1965, b_alb_1970,
               b_alb_1975, b_alb_1980, b_alb_1985, b_alb_1990, b_alb_1995,
               b_alb_2000, b_alb_2005, b_alb_2010, b_alb_2015)
rm(b_alb_1950, b_alb_1955, b_alb_1960, b_alb_1965, b_alb_1970,
   b_alb_1975, b_alb_1980, b_alb_1985, b_alb_1990, b_alb_1995,
   b_alb_2000, b_alb_2005, b_alb_2010, b_alb_2015)


# British Columbia, both sexes combined

b_bco_1950 <- b_bco[b_bco$Year == 1950, ]
b_bco_1950$edag <- ineq(age = b_bco_1950$Age, 
                        dx = b_bco_1950$dx, 
                        lx = b_bco_1950$lx, 
                        ex = b_bco_1950$ex, 
                        ax = b_bco_1950$ax, 
                        method = 'edag')

b_bco_1955 <- b_bco[b_bco$Year == 1955, ]
b_bco_1955$edag <- ineq(age = b_bco_1955$Age, 
                        dx = b_bco_1955$dx, 
                        lx = b_bco_1955$lx, 
                        ex = b_bco_1955$ex, 
                        ax = b_bco_1955$ax, 
                        method = 'edag')

b_bco_1960 <- b_bco[b_bco$Year == 1960, ]
b_bco_1960$edag <- ineq(age = b_bco_1960$Age, 
                        dx = b_bco_1960$dx, 
                        lx = b_bco_1960$lx, 
                        ex = b_bco_1960$ex, 
                        ax = b_bco_1960$ax, 
                        method = 'edag')

b_bco_1965 <- b_bco[b_bco$Year == 1965, ]
b_bco_1965$edag <- ineq(age = b_bco_1965$Age, 
                        dx = b_bco_1965$dx, 
                        lx = b_bco_1965$lx, 
                        ex = b_bco_1965$ex, 
                        ax = b_bco_1965$ax, 
                        method = 'edag')

b_bco_1970 <- b_bco[b_bco$Year == 1970, ]
b_bco_1970$edag <- ineq(age = b_bco_1970$Age, 
                        dx = b_bco_1970$dx, 
                        lx = b_bco_1970$lx, 
                        ex = b_bco_1970$ex, 
                        ax = b_bco_1970$ax, 
                        method = 'edag')

b_bco_1975 <- b_bco[b_bco$Year == 1975, ]
b_bco_1975$edag <- ineq(age = b_bco_1975$Age, 
                        dx = b_bco_1975$dx, 
                        lx = b_bco_1975$lx, 
                        ex = b_bco_1975$ex, 
                        ax = b_bco_1975$ax, 
                        method = 'edag')

b_bco_1980 <- b_bco[b_bco$Year == 1980, ]
b_bco_1980$edag <- ineq(age = b_bco_1980$Age, 
                        dx = b_bco_1980$dx, 
                        lx = b_bco_1980$lx, 
                        ex = b_bco_1980$ex, 
                        ax = b_bco_1980$ax, 
                        method = 'edag')

b_bco_1985 <- b_bco[b_bco$Year == 1985, ]
b_bco_1985$edag <- ineq(age = b_bco_1985$Age, 
                        dx = b_bco_1985$dx, 
                        lx = b_bco_1985$lx, 
                        ex = b_bco_1985$ex, 
                        ax = b_bco_1985$ax, 
                        method = 'edag')

b_bco_1990 <- b_bco[b_bco$Year == 1990, ]
b_bco_1990$edag <- ineq(age = b_bco_1990$Age, 
                        dx = b_bco_1990$dx, 
                        lx = b_bco_1990$lx, 
                        ex = b_bco_1990$ex, 
                        ax = b_bco_1990$ax, 
                        method = 'edag')

b_bco_1995 <- b_bco[b_bco$Year == 1995, ]
b_bco_1995$edag <- ineq(age = b_bco_1995$Age, 
                        dx = b_bco_1995$dx, 
                        lx = b_bco_1995$lx, 
                        ex = b_bco_1995$ex, 
                        ax = b_bco_1995$ax, 
                        method = 'edag')

b_bco_2000 <- b_bco[b_bco$Year == 2000, ]
b_bco_2000$edag <- ineq(age = b_bco_2000$Age, 
                        dx = b_bco_2000$dx, 
                        lx = b_bco_2000$lx, 
                        ex = b_bco_2000$ex, 
                        ax = b_bco_2000$ax, 
                        method = 'edag')

b_bco_2005 <- b_bco[b_bco$Year == 2005, ]
b_bco_2005$edag <- ineq(age = b_bco_2005$Age, 
                        dx = b_bco_2005$dx, 
                        lx = b_bco_2005$lx, 
                        ex = b_bco_2005$ex, 
                        ax = b_bco_2005$ax, 
                        method = 'edag')

# There's an issue with dx for British Columbia in 2010. The sum of the dx
# column does not equal 100,000; it equals, 99,989. I believe this is due to 
# rounding. The ineq() command does not work if the sum of dx is not 100,000.
# I create a new dx function.

b_bco_2010 <- b_bco[b_bco$Year == 2010, ]

#b_bco_2010$dx2[1:111] <- as.integer(b_bco_2010$lx[1:111] * b_bco_2010$qx[1:111])
  # This code reproduces the dx series that sums to 99,989

# I use the difference in lx values to calculate the dx series, and it sums
# to 100,000
b_bco_2010$dx[1:110] <- b_bco_2010$lx[1:110] - b_bco_2010$lx[2:111] # ages 0-109
b_bco_2010$dx[111] <- b_bco_2010$lx[111]  # age 110

b_bco_2010$edag <- ineq(age = b_bco_2010$Age, 
                        dx = b_bco_2010$dx, 
                        lx = b_bco_2010$lx, 
                        ex = b_bco_2010$ex, 
                        ax = b_bco_2010$ax, 
                        method = 'edag')

b_bco_2015 <- b_bco[b_bco$Year == 2015, ]
b_bco_2015$edag <- ineq(age = b_bco_2015$Age, 
                        dx = b_bco_2015$dx, 
                        lx = b_bco_2015$lx, 
                        ex = b_bco_2015$ex, 
                        ax = b_bco_2015$ax, 
                        method = 'edag')

b_bco <- rbind(b_bco_1950, b_bco_1955, b_bco_1960, b_bco_1965, b_bco_1970,
               b_bco_1975, b_bco_1980, b_bco_1985, b_bco_1990, b_bco_1995,
               b_bco_2000, b_bco_2005, b_bco_2010, b_bco_2015)
rm(b_bco_1950, b_bco_1955, b_bco_1960, b_bco_1965, b_bco_1970,
   b_bco_1975, b_bco_1980, b_bco_1985, b_bco_1990, b_bco_1995,
   b_bco_2000, b_bco_2005, b_bco_2010, b_bco_2015)


# Manitoba, both sexes combined

b_man_1950 <- b_man[b_man$Year == 1950, ]
b_man_1950$edag <- ineq(age = b_man_1950$Age, 
                        dx = b_man_1950$dx, 
                        lx = b_man_1950$lx, 
                        ex = b_man_1950$ex, 
                        ax = b_man_1950$ax, 
                        method = 'edag')

b_man_1955 <- b_man[b_man$Year == 1955, ]
b_man_1955$edag <- ineq(age = b_man_1955$Age, 
                        dx = b_man_1955$dx, 
                        lx = b_man_1955$lx, 
                        ex = b_man_1955$ex, 
                        ax = b_man_1955$ax, 
                        method = 'edag')

b_man_1960 <- b_man[b_man$Year == 1960, ]
b_man_1960$edag <- ineq(age = b_man_1960$Age, 
                        dx = b_man_1960$dx, 
                        lx = b_man_1960$lx, 
                        ex = b_man_1960$ex, 
                        ax = b_man_1960$ax, 
                        method = 'edag')

b_man_1965 <- b_man[b_man$Year == 1965, ]
b_man_1965$edag <- ineq(age = b_man_1965$Age, 
                        dx = b_man_1965$dx, 
                        lx = b_man_1965$lx, 
                        ex = b_man_1965$ex, 
                        ax = b_man_1965$ax, 
                        method = 'edag')

b_man_1970 <- b_man[b_man$Year == 1970, ]
b_man_1970$edag <- ineq(age = b_man_1970$Age, 
                        dx = b_man_1970$dx, 
                        lx = b_man_1970$lx, 
                        ex = b_man_1970$ex, 
                        ax = b_man_1970$ax, 
                        method = 'edag')

b_man_1975 <- b_man[b_man$Year == 1975, ]
b_man_1975$edag <- ineq(age = b_man_1975$Age, 
                        dx = b_man_1975$dx, 
                        lx = b_man_1975$lx, 
                        ex = b_man_1975$ex, 
                        ax = b_man_1975$ax, 
                        method = 'edag')

b_man_1980 <- b_man[b_man$Year == 1980, ]
b_man_1980$edag <- ineq(age = b_man_1980$Age, 
                        dx = b_man_1980$dx, 
                        lx = b_man_1980$lx, 
                        ex = b_man_1980$ex, 
                        ax = b_man_1980$ax, 
                        method = 'edag')

b_man_1985 <- b_man[b_man$Year == 1985, ]
b_man_1985$edag <- ineq(age = b_man_1985$Age, 
                        dx = b_man_1985$dx, 
                        lx = b_man_1985$lx, 
                        ex = b_man_1985$ex, 
                        ax = b_man_1985$ax, 
                        method = 'edag')

b_man_1990 <- b_man[b_man$Year == 1990, ]
b_man_1990$edag <- ineq(age = b_man_1990$Age, 
                        dx = b_man_1990$dx, 
                        lx = b_man_1990$lx, 
                        ex = b_man_1990$ex, 
                        ax = b_man_1990$ax, 
                        method = 'edag')

b_man_1995 <- b_man[b_man$Year == 1995, ]
b_man_1995$edag <- ineq(age = b_man_1995$Age, 
                        dx = b_man_1995$dx, 
                        lx = b_man_1995$lx, 
                        ex = b_man_1995$ex, 
                        ax = b_man_1995$ax, 
                        method = 'edag')

b_man_2000 <- b_man[b_man$Year == 2000, ]
b_man_2000$edag <- ineq(age = b_man_2000$Age, 
                        dx = b_man_2000$dx, 
                        lx = b_man_2000$lx, 
                        ex = b_man_2000$ex, 
                        ax = b_man_2000$ax, 
                        method = 'edag')

b_man_2005 <- b_man[b_man$Year == 2005, ]
b_man_2005$edag <- ineq(age = b_man_2005$Age, 
                        dx = b_man_2005$dx, 
                        lx = b_man_2005$lx, 
                        ex = b_man_2005$ex, 
                        ax = b_man_2005$ax, 
                        method = 'edag')

b_man_2010 <- b_man[b_man$Year == 2010, ]
b_man_2010$edag <- ineq(age = b_man_2010$Age, 
                        dx = b_man_2010$dx, 
                        lx = b_man_2010$lx, 
                        ex = b_man_2010$ex, 
                        ax = b_man_2010$ax, 
                        method = 'edag')

b_man_2015 <- b_man[b_man$Year == 2015, ]
b_man_2015$edag <- ineq(age = b_man_2015$Age, 
                        dx = b_man_2015$dx, 
                        lx = b_man_2015$lx, 
                        ex = b_man_2015$ex, 
                        ax = b_man_2015$ax, 
                        method = 'edag')

b_man <- rbind(b_man_1950, b_man_1955, b_man_1960, b_man_1965, b_man_1970,
               b_man_1975, b_man_1980, b_man_1985, b_man_1990, b_man_1995,
               b_man_2000, b_man_2005, b_man_2010, b_man_2015)
rm(b_man_1950, b_man_1955, b_man_1960, b_man_1965, b_man_1970,
   b_man_1975, b_man_1980, b_man_1985, b_man_1990, b_man_1995,
   b_man_2000, b_man_2005, b_man_2010, b_man_2015)


# New Brunswick, both sexes combined

b_nbr_1950 <- b_nbr[b_nbr$Year == 1950, ]
b_nbr_1950$edag <- ineq(age = b_nbr_1950$Age, 
                        dx = b_nbr_1950$dx, 
                        lx = b_nbr_1950$lx, 
                        ex = b_nbr_1950$ex, 
                        ax = b_nbr_1950$ax, 
                        method = 'edag')

b_nbr_1955 <- b_nbr[b_nbr$Year == 1955, ]
b_nbr_1955$edag <- ineq(age = b_nbr_1955$Age, 
                        dx = b_nbr_1955$dx, 
                        lx = b_nbr_1955$lx, 
                        ex = b_nbr_1955$ex, 
                        ax = b_nbr_1955$ax, 
                        method = 'edag')

b_nbr_1960 <- b_nbr[b_nbr$Year == 1960, ]
b_nbr_1960$edag <- ineq(age = b_nbr_1960$Age, 
                        dx = b_nbr_1960$dx, 
                        lx = b_nbr_1960$lx, 
                        ex = b_nbr_1960$ex, 
                        ax = b_nbr_1960$ax, 
                        method = 'edag')

b_nbr_1965 <- b_nbr[b_nbr$Year == 1965, ]
b_nbr_1965$edag <- ineq(age = b_nbr_1965$Age, 
                        dx = b_nbr_1965$dx, 
                        lx = b_nbr_1965$lx, 
                        ex = b_nbr_1965$ex, 
                        ax = b_nbr_1965$ax, 
                        method = 'edag')

b_nbr_1970 <- b_nbr[b_nbr$Year == 1970, ]
b_nbr_1970$edag <- ineq(age = b_nbr_1970$Age, 
                        dx = b_nbr_1970$dx, 
                        lx = b_nbr_1970$lx, 
                        ex = b_nbr_1970$ex, 
                        ax = b_nbr_1970$ax, 
                        method = 'edag')

b_nbr_1975 <- b_nbr[b_nbr$Year == 1975, ]
b_nbr_1975$edag <- ineq(age = b_nbr_1975$Age, 
                        dx = b_nbr_1975$dx, 
                        lx = b_nbr_1975$lx, 
                        ex = b_nbr_1975$ex, 
                        ax = b_nbr_1975$ax, 
                        method = 'edag')

b_nbr_1980 <- b_nbr[b_nbr$Year == 1980, ]
b_nbr_1980$edag <- ineq(age = b_nbr_1980$Age, 
                        dx = b_nbr_1980$dx, 
                        lx = b_nbr_1980$lx, 
                        ex = b_nbr_1980$ex, 
                        ax = b_nbr_1980$ax, 
                        method = 'edag')

b_nbr_1985 <- b_nbr[b_nbr$Year == 1985, ]
b_nbr_1985$edag <- ineq(age = b_nbr_1985$Age, 
                        dx = b_nbr_1985$dx, 
                        lx = b_nbr_1985$lx, 
                        ex = b_nbr_1985$ex, 
                        ax = b_nbr_1985$ax, 
                        method = 'edag')

b_nbr_1990 <- b_nbr[b_nbr$Year == 1990, ]
b_nbr_1990$edag <- ineq(age = b_nbr_1990$Age, 
                        dx = b_nbr_1990$dx, 
                        lx = b_nbr_1990$lx, 
                        ex = b_nbr_1990$ex, 
                        ax = b_nbr_1990$ax, 
                        method = 'edag')

b_nbr_1995 <- b_nbr[b_nbr$Year == 1995, ]
b_nbr_1995$edag <- ineq(age = b_nbr_1995$Age, 
                        dx = b_nbr_1995$dx, 
                        lx = b_nbr_1995$lx, 
                        ex = b_nbr_1995$ex, 
                        ax = b_nbr_1995$ax, 
                        method = 'edag')

b_nbr_2000 <- b_nbr[b_nbr$Year == 2000, ]
b_nbr_2000$edag <- ineq(age = b_nbr_2000$Age, 
                        dx = b_nbr_2000$dx, 
                        lx = b_nbr_2000$lx, 
                        ex = b_nbr_2000$ex, 
                        ax = b_nbr_2000$ax, 
                        method = 'edag')

b_nbr_2005 <- b_nbr[b_nbr$Year == 2005, ]
b_nbr_2005$edag <- ineq(age = b_nbr_2005$Age, 
                        dx = b_nbr_2005$dx, 
                        lx = b_nbr_2005$lx, 
                        ex = b_nbr_2005$ex, 
                        ax = b_nbr_2005$ax, 
                        method = 'edag')

b_nbr_2010 <- b_nbr[b_nbr$Year == 2010, ]
b_nbr_2010$edag <- ineq(age = b_nbr_2010$Age, 
                        dx = b_nbr_2010$dx, 
                        lx = b_nbr_2010$lx, 
                        ex = b_nbr_2010$ex, 
                        ax = b_nbr_2010$ax, 
                        method = 'edag')

b_nbr_2015 <- b_nbr[b_nbr$Year == 2015, ]
b_nbr_2015$edag <- ineq(age = b_nbr_2015$Age, 
                        dx = b_nbr_2015$dx, 
                        lx = b_nbr_2015$lx, 
                        ex = b_nbr_2015$ex, 
                        ax = b_nbr_2015$ax, 
                        method = 'edag')

b_nbr <- rbind(b_nbr_1950, b_nbr_1955, b_nbr_1960, b_nbr_1965, b_nbr_1970,
               b_nbr_1975, b_nbr_1980, b_nbr_1985, b_nbr_1990, b_nbr_1995,
               b_nbr_2000, b_nbr_2005, b_nbr_2010, b_nbr_2015)
rm(b_nbr_1950, b_nbr_1955, b_nbr_1960, b_nbr_1965, b_nbr_1970,
   b_nbr_1975, b_nbr_1980, b_nbr_1985, b_nbr_1990, b_nbr_1995,
   b_nbr_2000, b_nbr_2005, b_nbr_2010, b_nbr_2015)


# Newfoundland, both sexes combined

b_nfl_1950 <- b_nfl[b_nfl$Year == 1950, ]
b_nfl_1950$edag <- ineq(age = b_nfl_1950$Age, 
                        dx = b_nfl_1950$dx, 
                        lx = b_nfl_1950$lx, 
                        ex = b_nfl_1950$ex, 
                        ax = b_nfl_1950$ax, 
                        method = 'edag')

b_nfl_1955 <- b_nfl[b_nfl$Year == 1955, ]
b_nfl_1955$edag <- ineq(age = b_nfl_1955$Age, 
                        dx = b_nfl_1955$dx, 
                        lx = b_nfl_1955$lx, 
                        ex = b_nfl_1955$ex, 
                        ax = b_nfl_1955$ax, 
                        method = 'edag')

b_nfl_1960 <- b_nfl[b_nfl$Year == 1960, ]
b_nfl_1960$edag <- ineq(age = b_nfl_1960$Age, 
                        dx = b_nfl_1960$dx, 
                        lx = b_nfl_1960$lx, 
                        ex = b_nfl_1960$ex, 
                        ax = b_nfl_1960$ax, 
                        method = 'edag')

b_nfl_1965 <- b_nfl[b_nfl$Year == 1965, ]
b_nfl_1965$edag <- ineq(age = b_nfl_1965$Age, 
                        dx = b_nfl_1965$dx, 
                        lx = b_nfl_1965$lx, 
                        ex = b_nfl_1965$ex, 
                        ax = b_nfl_1965$ax, 
                        method = 'edag')

b_nfl_1970 <- b_nfl[b_nfl$Year == 1970, ]
b_nfl_1970$edag <- ineq(age = b_nfl_1970$Age, 
                        dx = b_nfl_1970$dx, 
                        lx = b_nfl_1970$lx, 
                        ex = b_nfl_1970$ex, 
                        ax = b_nfl_1970$ax, 
                        method = 'edag')

b_nfl_1975 <- b_nfl[b_nfl$Year == 1975, ]
b_nfl_1975$edag <- ineq(age = b_nfl_1975$Age, 
                        dx = b_nfl_1975$dx, 
                        lx = b_nfl_1975$lx, 
                        ex = b_nfl_1975$ex, 
                        ax = b_nfl_1975$ax, 
                        method = 'edag')

b_nfl_1980 <- b_nfl[b_nfl$Year == 1980, ]
b_nfl_1980$edag <- ineq(age = b_nfl_1980$Age, 
                        dx = b_nfl_1980$dx, 
                        lx = b_nfl_1980$lx, 
                        ex = b_nfl_1980$ex, 
                        ax = b_nfl_1980$ax, 
                        method = 'edag')

b_nfl_1985 <- b_nfl[b_nfl$Year == 1985, ]
b_nfl_1985$edag <- ineq(age = b_nfl_1985$Age, 
                        dx = b_nfl_1985$dx, 
                        lx = b_nfl_1985$lx, 
                        ex = b_nfl_1985$ex, 
                        ax = b_nfl_1985$ax, 
                        method = 'edag')

b_nfl_1990 <- b_nfl[b_nfl$Year == 1990, ]
b_nfl_1990$edag <- ineq(age = b_nfl_1990$Age, 
                        dx = b_nfl_1990$dx, 
                        lx = b_nfl_1990$lx, 
                        ex = b_nfl_1990$ex, 
                        ax = b_nfl_1990$ax, 
                        method = 'edag')

b_nfl_1995 <- b_nfl[b_nfl$Year == 1995, ]
b_nfl_1995$edag <- ineq(age = b_nfl_1995$Age, 
                        dx = b_nfl_1995$dx, 
                        lx = b_nfl_1995$lx, 
                        ex = b_nfl_1995$ex, 
                        ax = b_nfl_1995$ax, 
                        method = 'edag')

b_nfl_2000 <- b_nfl[b_nfl$Year == 2000, ]
b_nfl_2000$edag <- ineq(age = b_nfl_2000$Age, 
                        dx = b_nfl_2000$dx, 
                        lx = b_nfl_2000$lx, 
                        ex = b_nfl_2000$ex, 
                        ax = b_nfl_2000$ax, 
                        method = 'edag')

b_nfl_2005 <- b_nfl[b_nfl$Year == 2005, ]
b_nfl_2005$edag <- ineq(age = b_nfl_2005$Age, 
                        dx = b_nfl_2005$dx, 
                        lx = b_nfl_2005$lx, 
                        ex = b_nfl_2005$ex, 
                        ax = b_nfl_2005$ax, 
                        method = 'edag')

b_nfl_2010 <- b_nfl[b_nfl$Year == 2010, ]
b_nfl_2010$edag <- ineq(age = b_nfl_2010$Age, 
                        dx = b_nfl_2010$dx, 
                        lx = b_nfl_2010$lx, 
                        ex = b_nfl_2010$ex, 
                        ax = b_nfl_2010$ax, 
                        method = 'edag')

b_nfl_2015 <- b_nfl[b_nfl$Year == 2015, ]
b_nfl_2015$edag <- ineq(age = b_nfl_2015$Age, 
                        dx = b_nfl_2015$dx, 
                        lx = b_nfl_2015$lx, 
                        ex = b_nfl_2015$ex, 
                        ax = b_nfl_2015$ax, 
                        method = 'edag')

b_nfl <- rbind(b_nfl_1950, b_nfl_1955, b_nfl_1960, b_nfl_1965, b_nfl_1970,
               b_nfl_1975, b_nfl_1980, b_nfl_1985, b_nfl_1990, b_nfl_1995,
               b_nfl_2000, b_nfl_2005, b_nfl_2010, b_nfl_2015)
rm(b_nfl_1950, b_nfl_1955, b_nfl_1960, b_nfl_1965, b_nfl_1970,
   b_nfl_1975, b_nfl_1980, b_nfl_1985, b_nfl_1990, b_nfl_1995,
   b_nfl_2000, b_nfl_2005, b_nfl_2010, b_nfl_2015)


# Nova Scotia, both sexes combined

b_nsc_1950 <- b_nsc[b_nsc$Year == 1950, ]
b_nsc_1950$edag <- ineq(age = b_nsc_1950$Age, 
                        dx = b_nsc_1950$dx, 
                        lx = b_nsc_1950$lx, 
                        ex = b_nsc_1950$ex, 
                        ax = b_nsc_1950$ax, 
                        method = 'edag')

b_nsc_1955 <- b_nsc[b_nsc$Year == 1955, ]
b_nsc_1955$edag <- ineq(age = b_nsc_1955$Age, 
                        dx = b_nsc_1955$dx, 
                        lx = b_nsc_1955$lx, 
                        ex = b_nsc_1955$ex, 
                        ax = b_nsc_1955$ax, 
                        method = 'edag')

b_nsc_1960 <- b_nsc[b_nsc$Year == 1960, ]
b_nsc_1960$edag <- ineq(age = b_nsc_1960$Age, 
                        dx = b_nsc_1960$dx, 
                        lx = b_nsc_1960$lx, 
                        ex = b_nsc_1960$ex, 
                        ax = b_nsc_1960$ax, 
                        method = 'edag')

b_nsc_1965 <- b_nsc[b_nsc$Year == 1965, ]
b_nsc_1965$edag <- ineq(age = b_nsc_1965$Age, 
                        dx = b_nsc_1965$dx, 
                        lx = b_nsc_1965$lx, 
                        ex = b_nsc_1965$ex, 
                        ax = b_nsc_1965$ax, 
                        method = 'edag')

b_nsc_1970 <- b_nsc[b_nsc$Year == 1970, ]
b_nsc_1970$edag <- ineq(age = b_nsc_1970$Age, 
                        dx = b_nsc_1970$dx, 
                        lx = b_nsc_1970$lx, 
                        ex = b_nsc_1970$ex, 
                        ax = b_nsc_1970$ax, 
                        method = 'edag')

b_nsc_1975 <- b_nsc[b_nsc$Year == 1975, ]
b_nsc_1975$edag <- ineq(age = b_nsc_1975$Age, 
                        dx = b_nsc_1975$dx, 
                        lx = b_nsc_1975$lx, 
                        ex = b_nsc_1975$ex, 
                        ax = b_nsc_1975$ax, 
                        method = 'edag')

b_nsc_1980 <- b_nsc[b_nsc$Year == 1980, ]
b_nsc_1980$edag <- ineq(age = b_nsc_1980$Age, 
                        dx = b_nsc_1980$dx, 
                        lx = b_nsc_1980$lx, 
                        ex = b_nsc_1980$ex, 
                        ax = b_nsc_1980$ax, 
                        method = 'edag')

b_nsc_1985 <- b_nsc[b_nsc$Year == 1985, ]
b_nsc_1985$edag <- ineq(age = b_nsc_1985$Age, 
                        dx = b_nsc_1985$dx, 
                        lx = b_nsc_1985$lx, 
                        ex = b_nsc_1985$ex, 
                        ax = b_nsc_1985$ax, 
                        method = 'edag')

b_nsc_1990 <- b_nsc[b_nsc$Year == 1990, ]
b_nsc_1990$edag <- ineq(age = b_nsc_1990$Age, 
                        dx = b_nsc_1990$dx, 
                        lx = b_nsc_1990$lx, 
                        ex = b_nsc_1990$ex, 
                        ax = b_nsc_1990$ax, 
                        method = 'edag')

b_nsc_1995 <- b_nsc[b_nsc$Year == 1995, ]
b_nsc_1995$edag <- ineq(age = b_nsc_1995$Age, 
                        dx = b_nsc_1995$dx, 
                        lx = b_nsc_1995$lx, 
                        ex = b_nsc_1995$ex, 
                        ax = b_nsc_1995$ax, 
                        method = 'edag')

b_nsc_2000 <- b_nsc[b_nsc$Year == 2000, ]
b_nsc_2000$edag <- ineq(age = b_nsc_2000$Age, 
                        dx = b_nsc_2000$dx, 
                        lx = b_nsc_2000$lx, 
                        ex = b_nsc_2000$ex, 
                        ax = b_nsc_2000$ax, 
                        method = 'edag')

b_nsc_2005 <- b_nsc[b_nsc$Year == 2005, ]
b_nsc_2005$edag <- ineq(age = b_nsc_2005$Age, 
                        dx = b_nsc_2005$dx, 
                        lx = b_nsc_2005$lx, 
                        ex = b_nsc_2005$ex, 
                        ax = b_nsc_2005$ax, 
                        method = 'edag')

b_nsc_2010 <- b_nsc[b_nsc$Year == 2010, ]
b_nsc_2010$edag <- ineq(age = b_nsc_2010$Age, 
                        dx = b_nsc_2010$dx, 
                        lx = b_nsc_2010$lx, 
                        ex = b_nsc_2010$ex, 
                        ax = b_nsc_2010$ax, 
                        method = 'edag')

b_nsc_2015 <- b_nsc[b_nsc$Year == 2015, ]
b_nsc_2015$edag <- ineq(age = b_nsc_2015$Age, 
                        dx = b_nsc_2015$dx, 
                        lx = b_nsc_2015$lx, 
                        ex = b_nsc_2015$ex, 
                        ax = b_nsc_2015$ax, 
                        method = 'edag')

b_nsc <- rbind(b_nsc_1950, b_nsc_1955, b_nsc_1960, b_nsc_1965, b_nsc_1970,
               b_nsc_1975, b_nsc_1980, b_nsc_1985, b_nsc_1990, b_nsc_1995,
               b_nsc_2000, b_nsc_2005, b_nsc_2010, b_nsc_2015)
rm(b_nsc_1950, b_nsc_1955, b_nsc_1960, b_nsc_1965, b_nsc_1970,
   b_nsc_1975, b_nsc_1980, b_nsc_1985, b_nsc_1990, b_nsc_1995,
   b_nsc_2000, b_nsc_2005, b_nsc_2010, b_nsc_2015)


# Northwest Territories, both sexes combined

b_nwt_1950 <- b_nwt[b_nwt$Year == 1950, ]
b_nwt_1950$edag <- ineq(age = b_nwt_1950$Age, 
                        dx = b_nwt_1950$dx, 
                        lx = b_nwt_1950$lx, 
                        ex = b_nwt_1950$ex, 
                        ax = b_nwt_1950$ax, 
                        method = 'edag')

b_nwt_1955 <- b_nwt[b_nwt$Year == 1955, ]
b_nwt_1955$edag <- ineq(age = b_nwt_1955$Age, 
                        dx = b_nwt_1955$dx, 
                        lx = b_nwt_1955$lx, 
                        ex = b_nwt_1955$ex, 
                        ax = b_nwt_1955$ax, 
                        method = 'edag')

b_nwt_1960 <- b_nwt[b_nwt$Year == 1960, ]
b_nwt_1960$edag <- ineq(age = b_nwt_1960$Age, 
                        dx = b_nwt_1960$dx, 
                        lx = b_nwt_1960$lx, 
                        ex = b_nwt_1960$ex, 
                        ax = b_nwt_1960$ax, 
                        method = 'edag')

b_nwt_1965 <- b_nwt[b_nwt$Year == 1965, ]
b_nwt_1965$edag <- ineq(age = b_nwt_1965$Age, 
                        dx = b_nwt_1965$dx, 
                        lx = b_nwt_1965$lx, 
                        ex = b_nwt_1965$ex, 
                        ax = b_nwt_1965$ax, 
                        method = 'edag')

b_nwt_1970 <- b_nwt[b_nwt$Year == 1970, ]
b_nwt_1970$edag <- ineq(age = b_nwt_1970$Age, 
                        dx = b_nwt_1970$dx, 
                        lx = b_nwt_1970$lx, 
                        ex = b_nwt_1970$ex, 
                        ax = b_nwt_1970$ax, 
                        method = 'edag')

b_nwt_1975 <- b_nwt[b_nwt$Year == 1975, ]
b_nwt_1975$edag <- ineq(age = b_nwt_1975$Age, 
                        dx = b_nwt_1975$dx, 
                        lx = b_nwt_1975$lx, 
                        ex = b_nwt_1975$ex, 
                        ax = b_nwt_1975$ax, 
                        method = 'edag')

b_nwt_1980 <- b_nwt[b_nwt$Year == 1980, ]
b_nwt_1980$edag <- ineq(age = b_nwt_1980$Age, 
                        dx = b_nwt_1980$dx, 
                        lx = b_nwt_1980$lx, 
                        ex = b_nwt_1980$ex, 
                        ax = b_nwt_1980$ax, 
                        method = 'edag')

b_nwt_1985 <- b_nwt[b_nwt$Year == 1985, ]
b_nwt_1985$edag <- ineq(age = b_nwt_1985$Age, 
                        dx = b_nwt_1985$dx, 
                        lx = b_nwt_1985$lx, 
                        ex = b_nwt_1985$ex, 
                        ax = b_nwt_1985$ax, 
                        method = 'edag')

b_nwt_1990 <- b_nwt[b_nwt$Year == 1990, ]
b_nwt_1990$edag <- ineq(age = b_nwt_1990$Age, 
                        dx = b_nwt_1990$dx, 
                        lx = b_nwt_1990$lx, 
                        ex = b_nwt_1990$ex, 
                        ax = b_nwt_1990$ax, 
                        method = 'edag')

b_nwt_1995 <- b_nwt[b_nwt$Year == 1995, ]
b_nwt_1995$edag <- ineq(age = b_nwt_1995$Age, 
                        dx = b_nwt_1995$dx, 
                        lx = b_nwt_1995$lx, 
                        ex = b_nwt_1995$ex, 
                        ax = b_nwt_1995$ax, 
                        method = 'edag')

b_nwt_2000 <- b_nwt[b_nwt$Year == 2000, ]
b_nwt_2000$edag <- ineq(age = b_nwt_2000$Age, 
                        dx = b_nwt_2000$dx, 
                        lx = b_nwt_2000$lx, 
                        ex = b_nwt_2000$ex, 
                        ax = b_nwt_2000$ax, 
                        method = 'edag')

b_nwt_2005 <- b_nwt[b_nwt$Year == 2005, ]
b_nwt_2005$edag <- ineq(age = b_nwt_2005$Age, 
                        dx = b_nwt_2005$dx, 
                        lx = b_nwt_2005$lx, 
                        ex = b_nwt_2005$ex, 
                        ax = b_nwt_2005$ax, 
                        method = 'edag')

b_nwt_2010 <- b_nwt[b_nwt$Year == 2010, ]
b_nwt_2010$edag <- ineq(age = b_nwt_2010$Age, 
                        dx = b_nwt_2010$dx, 
                        lx = b_nwt_2010$lx, 
                        ex = b_nwt_2010$ex, 
                        ax = b_nwt_2010$ax, 
                        method = 'edag')

b_nwt_2015 <- b_nwt[b_nwt$Year == 2015, ]
b_nwt_2015$edag <- ineq(age = b_nwt_2015$Age, 
                        dx = b_nwt_2015$dx, 
                        lx = b_nwt_2015$lx, 
                        ex = b_nwt_2015$ex, 
                        ax = b_nwt_2015$ax, 
                        method = 'edag')

b_nwt <- rbind(b_nwt_1950, b_nwt_1955, b_nwt_1960, b_nwt_1965, b_nwt_1970,
               b_nwt_1975, b_nwt_1980, b_nwt_1985, b_nwt_1990, b_nwt_1995,
               b_nwt_2000, b_nwt_2005, b_nwt_2010, b_nwt_2015)
rm(b_nwt_1950, b_nwt_1955, b_nwt_1960, b_nwt_1965, b_nwt_1970,
   b_nwt_1975, b_nwt_1980, b_nwt_1985, b_nwt_1990, b_nwt_1995,
   b_nwt_2000, b_nwt_2005, b_nwt_2010, b_nwt_2015)


# Ontario, both sexes combined

b_ont_1950 <- b_ont[b_ont$Year == 1950, ]
b_ont_1950$edag <- ineq(age = b_ont_1950$Age, 
                        dx = b_ont_1950$dx, 
                        lx = b_ont_1950$lx, 
                        ex = b_ont_1950$ex, 
                        ax = b_ont_1950$ax, 
                        method = 'edag')

b_ont_1955 <- b_ont[b_ont$Year == 1955, ]
b_ont_1955$edag <- ineq(age = b_ont_1955$Age, 
                        dx = b_ont_1955$dx, 
                        lx = b_ont_1955$lx, 
                        ex = b_ont_1955$ex, 
                        ax = b_ont_1955$ax, 
                        method = 'edag')

b_ont_1960 <- b_ont[b_ont$Year == 1960, ]
b_ont_1960$edag <- ineq(age = b_ont_1960$Age, 
                        dx = b_ont_1960$dx, 
                        lx = b_ont_1960$lx, 
                        ex = b_ont_1960$ex, 
                        ax = b_ont_1960$ax, 
                        method = 'edag')

b_ont_1965 <- b_ont[b_ont$Year == 1965, ]
b_ont_1965$edag <- ineq(age = b_ont_1965$Age, 
                        dx = b_ont_1965$dx, 
                        lx = b_ont_1965$lx, 
                        ex = b_ont_1965$ex, 
                        ax = b_ont_1965$ax, 
                        method = 'edag')

b_ont_1970 <- b_ont[b_ont$Year == 1970, ]
b_ont_1970$edag <- ineq(age = b_ont_1970$Age, 
                        dx = b_ont_1970$dx, 
                        lx = b_ont_1970$lx, 
                        ex = b_ont_1970$ex, 
                        ax = b_ont_1970$ax, 
                        method = 'edag')

b_ont_1975 <- b_ont[b_ont$Year == 1975, ]
b_ont_1975$edag <- ineq(age = b_ont_1975$Age, 
                        dx = b_ont_1975$dx, 
                        lx = b_ont_1975$lx, 
                        ex = b_ont_1975$ex, 
                        ax = b_ont_1975$ax, 
                        method = 'edag')

b_ont_1980 <- b_ont[b_ont$Year == 1980, ]
b_ont_1980$edag <- ineq(age = b_ont_1980$Age, 
                        dx = b_ont_1980$dx, 
                        lx = b_ont_1980$lx, 
                        ex = b_ont_1980$ex, 
                        ax = b_ont_1980$ax, 
                        method = 'edag')

b_ont_1985 <- b_ont[b_ont$Year == 1985, ]
b_ont_1985$edag <- ineq(age = b_ont_1985$Age, 
                        dx = b_ont_1985$dx, 
                        lx = b_ont_1985$lx, 
                        ex = b_ont_1985$ex, 
                        ax = b_ont_1985$ax, 
                        method = 'edag')

b_ont_1990 <- b_ont[b_ont$Year == 1990, ]
b_ont_1990$edag <- ineq(age = b_ont_1990$Age, 
                        dx = b_ont_1990$dx, 
                        lx = b_ont_1990$lx, 
                        ex = b_ont_1990$ex, 
                        ax = b_ont_1990$ax, 
                        method = 'edag')

b_ont_1995 <- b_ont[b_ont$Year == 1995, ]
b_ont_1995$edag <- ineq(age = b_ont_1995$Age, 
                        dx = b_ont_1995$dx, 
                        lx = b_ont_1995$lx, 
                        ex = b_ont_1995$ex, 
                        ax = b_ont_1995$ax, 
                        method = 'edag')

b_ont_2000 <- b_ont[b_ont$Year == 2000, ]
b_ont_2000$edag <- ineq(age = b_ont_2000$Age, 
                        dx = b_ont_2000$dx, 
                        lx = b_ont_2000$lx, 
                        ex = b_ont_2000$ex, 
                        ax = b_ont_2000$ax, 
                        method = 'edag')

b_ont_2005 <- b_ont[b_ont$Year == 2005, ]
b_ont_2005$edag <- ineq(age = b_ont_2005$Age, 
                        dx = b_ont_2005$dx, 
                        lx = b_ont_2005$lx, 
                        ex = b_ont_2005$ex, 
                        ax = b_ont_2005$ax, 
                        method = 'edag')

b_ont_2010 <- b_ont[b_ont$Year == 2010, ]
b_ont_2010$edag <- ineq(age = b_ont_2010$Age, 
                        dx = b_ont_2010$dx, 
                        lx = b_ont_2010$lx, 
                        ex = b_ont_2010$ex, 
                        ax = b_ont_2010$ax, 
                        method = 'edag')

b_ont_2015 <- b_ont[b_ont$Year == 2015, ]
b_ont_2015$edag <- ineq(age = b_ont_2015$Age, 
                        dx = b_ont_2015$dx, 
                        lx = b_ont_2015$lx, 
                        ex = b_ont_2015$ex, 
                        ax = b_ont_2015$ax, 
                        method = 'edag')

b_ont <- rbind(b_ont_1950, b_ont_1955, b_ont_1960, b_ont_1965, b_ont_1970,
               b_ont_1975, b_ont_1980, b_ont_1985, b_ont_1990, b_ont_1995,
               b_ont_2000, b_ont_2005, b_ont_2010, b_ont_2015)
rm(b_ont_1950, b_ont_1955, b_ont_1960, b_ont_1965, b_ont_1970,
   b_ont_1975, b_ont_1980, b_ont_1985, b_ont_1990, b_ont_1995,
   b_ont_2000, b_ont_2005, b_ont_2010, b_ont_2015)


# Prince Edward Island, both sexes combined

b_pei_1950 <- b_pei[b_pei$Year == 1950, ]
b_pei_1950$edag <- ineq(age = b_pei_1950$Age, 
                        dx = b_pei_1950$dx, 
                        lx = b_pei_1950$lx, 
                        ex = b_pei_1950$ex, 
                        ax = b_pei_1950$ax, 
                        method = 'edag')

b_pei_1955 <- b_pei[b_pei$Year == 1955, ]
b_pei_1955$edag <- ineq(age = b_pei_1955$Age, 
                        dx = b_pei_1955$dx, 
                        lx = b_pei_1955$lx, 
                        ex = b_pei_1955$ex, 
                        ax = b_pei_1955$ax, 
                        method = 'edag')

b_pei_1960 <- b_pei[b_pei$Year == 1960, ]
b_pei_1960$edag <- ineq(age = b_pei_1960$Age, 
                        dx = b_pei_1960$dx, 
                        lx = b_pei_1960$lx, 
                        ex = b_pei_1960$ex, 
                        ax = b_pei_1960$ax, 
                        method = 'edag')

b_pei_1965 <- b_pei[b_pei$Year == 1965, ]
b_pei_1965$edag <- ineq(age = b_pei_1965$Age, 
                        dx = b_pei_1965$dx, 
                        lx = b_pei_1965$lx, 
                        ex = b_pei_1965$ex, 
                        ax = b_pei_1965$ax, 
                        method = 'edag')

b_pei_1970 <- b_pei[b_pei$Year == 1970, ]
b_pei_1970$edag <- ineq(age = b_pei_1970$Age, 
                        dx = b_pei_1970$dx, 
                        lx = b_pei_1970$lx, 
                        ex = b_pei_1970$ex, 
                        ax = b_pei_1970$ax, 
                        method = 'edag')

b_pei_1975 <- b_pei[b_pei$Year == 1975, ]
b_pei_1975$edag <- ineq(age = b_pei_1975$Age, 
                        dx = b_pei_1975$dx, 
                        lx = b_pei_1975$lx, 
                        ex = b_pei_1975$ex, 
                        ax = b_pei_1975$ax, 
                        method = 'edag')

b_pei_1980 <- b_pei[b_pei$Year == 1980, ]
b_pei_1980$edag <- ineq(age = b_pei_1980$Age, 
                        dx = b_pei_1980$dx, 
                        lx = b_pei_1980$lx, 
                        ex = b_pei_1980$ex, 
                        ax = b_pei_1980$ax, 
                        method = 'edag')

b_pei_1985 <- b_pei[b_pei$Year == 1985, ]
b_pei_1985$edag <- ineq(age = b_pei_1985$Age, 
                        dx = b_pei_1985$dx, 
                        lx = b_pei_1985$lx, 
                        ex = b_pei_1985$ex, 
                        ax = b_pei_1985$ax, 
                        method = 'edag')

b_pei_1990 <- b_pei[b_pei$Year == 1990, ]
b_pei_1990$edag <- ineq(age = b_pei_1990$Age, 
                        dx = b_pei_1990$dx, 
                        lx = b_pei_1990$lx, 
                        ex = b_pei_1990$ex, 
                        ax = b_pei_1990$ax, 
                        method = 'edag')

b_pei_1995 <- b_pei[b_pei$Year == 1995, ]
b_pei_1995$edag <- ineq(age = b_pei_1995$Age, 
                        dx = b_pei_1995$dx, 
                        lx = b_pei_1995$lx, 
                        ex = b_pei_1995$ex, 
                        ax = b_pei_1995$ax, 
                        method = 'edag')

b_pei_2000 <- b_pei[b_pei$Year == 2000, ]
b_pei_2000$edag <- ineq(age = b_pei_2000$Age, 
                        dx = b_pei_2000$dx, 
                        lx = b_pei_2000$lx, 
                        ex = b_pei_2000$ex, 
                        ax = b_pei_2000$ax, 
                        method = 'edag')

b_pei_2005 <- b_pei[b_pei$Year == 2005, ]
b_pei_2005$edag <- ineq(age = b_pei_2005$Age, 
                        dx = b_pei_2005$dx, 
                        lx = b_pei_2005$lx, 
                        ex = b_pei_2005$ex, 
                        ax = b_pei_2005$ax, 
                        method = 'edag')

b_pei_2010 <- b_pei[b_pei$Year == 2010, ]
b_pei_2010$edag <- ineq(age = b_pei_2010$Age, 
                        dx = b_pei_2010$dx, 
                        lx = b_pei_2010$lx, 
                        ex = b_pei_2010$ex, 
                        ax = b_pei_2010$ax, 
                        method = 'edag')

b_pei_2015 <- b_pei[b_pei$Year == 2015, ]
b_pei_2015$edag <- ineq(age = b_pei_2015$Age, 
                        dx = b_pei_2015$dx, 
                        lx = b_pei_2015$lx, 
                        ex = b_pei_2015$ex, 
                        ax = b_pei_2015$ax, 
                        method = 'edag')

b_pei <- rbind(b_pei_1950, b_pei_1955, b_pei_1960, b_pei_1965, b_pei_1970,
               b_pei_1975, b_pei_1980, b_pei_1985, b_pei_1990, b_pei_1995,
               b_pei_2000, b_pei_2005, b_pei_2010, b_pei_2015)
rm(b_pei_1950, b_pei_1955, b_pei_1960, b_pei_1965, b_pei_1970,
   b_pei_1975, b_pei_1980, b_pei_1985, b_pei_1990, b_pei_1995,
   b_pei_2000, b_pei_2005, b_pei_2010, b_pei_2015)


# Quebec, both sexes combined

b_que_1950 <- b_que[b_que$Year == 1950, ]
b_que_1950$edag <- ineq(age = b_que_1950$Age, 
                        dx = b_que_1950$dx, 
                        lx = b_que_1950$lx, 
                        ex = b_que_1950$ex, 
                        ax = b_que_1950$ax, 
                        method = 'edag')

b_que_1955 <- b_que[b_que$Year == 1955, ]
b_que_1955$edag <- ineq(age = b_que_1955$Age, 
                        dx = b_que_1955$dx, 
                        lx = b_que_1955$lx, 
                        ex = b_que_1955$ex, 
                        ax = b_que_1955$ax, 
                        method = 'edag')

b_que_1960 <- b_que[b_que$Year == 1960, ]
b_que_1960$edag <- ineq(age = b_que_1960$Age, 
                        dx = b_que_1960$dx, 
                        lx = b_que_1960$lx, 
                        ex = b_que_1960$ex, 
                        ax = b_que_1960$ax, 
                        method = 'edag')

b_que_1965 <- b_que[b_que$Year == 1965, ]
b_que_1965$edag <- ineq(age = b_que_1965$Age, 
                        dx = b_que_1965$dx, 
                        lx = b_que_1965$lx, 
                        ex = b_que_1965$ex, 
                        ax = b_que_1965$ax, 
                        method = 'edag')

b_que_1970 <- b_que[b_que$Year == 1970, ]
b_que_1970$edag <- ineq(age = b_que_1970$Age, 
                        dx = b_que_1970$dx, 
                        lx = b_que_1970$lx, 
                        ex = b_que_1970$ex, 
                        ax = b_que_1970$ax, 
                        method = 'edag')

b_que_1975 <- b_que[b_que$Year == 1975, ]
b_que_1975$edag <- ineq(age = b_que_1975$Age, 
                        dx = b_que_1975$dx, 
                        lx = b_que_1975$lx, 
                        ex = b_que_1975$ex, 
                        ax = b_que_1975$ax, 
                        method = 'edag')

b_que_1980 <- b_que[b_que$Year == 1980, ]
b_que_1980$edag <- ineq(age = b_que_1980$Age, 
                        dx = b_que_1980$dx, 
                        lx = b_que_1980$lx, 
                        ex = b_que_1980$ex, 
                        ax = b_que_1980$ax, 
                        method = 'edag')

b_que_1985 <- b_que[b_que$Year == 1985, ]
b_que_1985$edag <- ineq(age = b_que_1985$Age, 
                        dx = b_que_1985$dx, 
                        lx = b_que_1985$lx, 
                        ex = b_que_1985$ex, 
                        ax = b_que_1985$ax, 
                        method = 'edag')

b_que_1990 <- b_que[b_que$Year == 1990, ]
b_que_1990$edag <- ineq(age = b_que_1990$Age, 
                        dx = b_que_1990$dx, 
                        lx = b_que_1990$lx, 
                        ex = b_que_1990$ex, 
                        ax = b_que_1990$ax, 
                        method = 'edag')

b_que_1995 <- b_que[b_que$Year == 1995, ]
b_que_1995$edag <- ineq(age = b_que_1995$Age, 
                        dx = b_que_1995$dx, 
                        lx = b_que_1995$lx, 
                        ex = b_que_1995$ex, 
                        ax = b_que_1995$ax, 
                        method = 'edag')

b_que_2000 <- b_que[b_que$Year == 2000, ]
b_que_2000$edag <- ineq(age = b_que_2000$Age, 
                        dx = b_que_2000$dx, 
                        lx = b_que_2000$lx, 
                        ex = b_que_2000$ex, 
                        ax = b_que_2000$ax, 
                        method = 'edag')

b_que_2005 <- b_que[b_que$Year == 2005, ]
b_que_2005$edag <- ineq(age = b_que_2005$Age, 
                        dx = b_que_2005$dx, 
                        lx = b_que_2005$lx, 
                        ex = b_que_2005$ex, 
                        ax = b_que_2005$ax, 
                        method = 'edag')

b_que_2010 <- b_que[b_que$Year == 2010, ]
b_que_2010$edag <- ineq(age = b_que_2010$Age, 
                        dx = b_que_2010$dx, 
                        lx = b_que_2010$lx, 
                        ex = b_que_2010$ex, 
                        ax = b_que_2010$ax, 
                        method = 'edag')

b_que_2015 <- b_que[b_que$Year == 2015, ]
b_que_2015$edag <- ineq(age = b_que_2015$Age, 
                        dx = b_que_2015$dx, 
                        lx = b_que_2015$lx, 
                        ex = b_que_2015$ex, 
                        ax = b_que_2015$ax, 
                        method = 'edag')

b_que <- rbind(b_que_1950, b_que_1955, b_que_1960, b_que_1965, b_que_1970,
               b_que_1975, b_que_1980, b_que_1985, b_que_1990, b_que_1995,
               b_que_2000, b_que_2005, b_que_2010, b_que_2015)
rm(b_que_1950, b_que_1955, b_que_1960, b_que_1965, b_que_1970,
   b_que_1975, b_que_1980, b_que_1985, b_que_1990, b_que_1995,
   b_que_2000, b_que_2005, b_que_2010, b_que_2015)


# Saskatchewan, both sexes combined

b_sas_1950 <- b_sas[b_sas$Year == 1950, ]
b_sas_1950$edag <- ineq(age = b_sas_1950$Age, 
                        dx = b_sas_1950$dx, 
                        lx = b_sas_1950$lx, 
                        ex = b_sas_1950$ex, 
                        ax = b_sas_1950$ax, 
                        method = 'edag')

b_sas_1955 <- b_sas[b_sas$Year == 1955, ]
b_sas_1955$edag <- ineq(age = b_sas_1955$Age, 
                        dx = b_sas_1955$dx, 
                        lx = b_sas_1955$lx, 
                        ex = b_sas_1955$ex, 
                        ax = b_sas_1955$ax, 
                        method = 'edag')

b_sas_1960 <- b_sas[b_sas$Year == 1960, ]
b_sas_1960$edag <- ineq(age = b_sas_1960$Age, 
                        dx = b_sas_1960$dx, 
                        lx = b_sas_1960$lx, 
                        ex = b_sas_1960$ex, 
                        ax = b_sas_1960$ax, 
                        method = 'edag')

b_sas_1965 <- b_sas[b_sas$Year == 1965, ]
b_sas_1965$edag <- ineq(age = b_sas_1965$Age, 
                        dx = b_sas_1965$dx, 
                        lx = b_sas_1965$lx, 
                        ex = b_sas_1965$ex, 
                        ax = b_sas_1965$ax, 
                        method = 'edag')

b_sas_1970 <- b_sas[b_sas$Year == 1970, ]
b_sas_1970$edag <- ineq(age = b_sas_1970$Age, 
                        dx = b_sas_1970$dx, 
                        lx = b_sas_1970$lx, 
                        ex = b_sas_1970$ex, 
                        ax = b_sas_1970$ax, 
                        method = 'edag')

b_sas_1975 <- b_sas[b_sas$Year == 1975, ]
b_sas_1975$edag <- ineq(age = b_sas_1975$Age, 
                        dx = b_sas_1975$dx, 
                        lx = b_sas_1975$lx, 
                        ex = b_sas_1975$ex, 
                        ax = b_sas_1975$ax, 
                        method = 'edag')

b_sas_1980 <- b_sas[b_sas$Year == 1980, ]
b_sas_1980$edag <- ineq(age = b_sas_1980$Age, 
                        dx = b_sas_1980$dx, 
                        lx = b_sas_1980$lx, 
                        ex = b_sas_1980$ex, 
                        ax = b_sas_1980$ax, 
                        method = 'edag')

b_sas_1985 <- b_sas[b_sas$Year == 1985, ]
b_sas_1985$edag <- ineq(age = b_sas_1985$Age, 
                        dx = b_sas_1985$dx, 
                        lx = b_sas_1985$lx, 
                        ex = b_sas_1985$ex, 
                        ax = b_sas_1985$ax, 
                        method = 'edag')

b_sas_1990 <- b_sas[b_sas$Year == 1990, ]
b_sas_1990$edag <- ineq(age = b_sas_1990$Age, 
                        dx = b_sas_1990$dx, 
                        lx = b_sas_1990$lx, 
                        ex = b_sas_1990$ex, 
                        ax = b_sas_1990$ax, 
                        method = 'edag')

b_sas_1995 <- b_sas[b_sas$Year == 1995, ]
b_sas_1995$edag <- ineq(age = b_sas_1995$Age, 
                        dx = b_sas_1995$dx, 
                        lx = b_sas_1995$lx, 
                        ex = b_sas_1995$ex, 
                        ax = b_sas_1995$ax, 
                        method = 'edag')

b_sas_2000 <- b_sas[b_sas$Year == 2000, ]
b_sas_2000$edag <- ineq(age = b_sas_2000$Age, 
                        dx = b_sas_2000$dx, 
                        lx = b_sas_2000$lx, 
                        ex = b_sas_2000$ex, 
                        ax = b_sas_2000$ax, 
                        method = 'edag')

b_sas_2005 <- b_sas[b_sas$Year == 2005, ]
b_sas_2005$edag <- ineq(age = b_sas_2005$Age, 
                        dx = b_sas_2005$dx, 
                        lx = b_sas_2005$lx, 
                        ex = b_sas_2005$ex, 
                        ax = b_sas_2005$ax, 
                        method = 'edag')

b_sas_2010 <- b_sas[b_sas$Year == 2010, ]
b_sas_2010$edag <- ineq(age = b_sas_2010$Age, 
                        dx = b_sas_2010$dx, 
                        lx = b_sas_2010$lx, 
                        ex = b_sas_2010$ex, 
                        ax = b_sas_2010$ax, 
                        method = 'edag')

b_sas_2015 <- b_sas[b_sas$Year == 2015, ]
b_sas_2015$edag <- ineq(age = b_sas_2015$Age, 
                        dx = b_sas_2015$dx, 
                        lx = b_sas_2015$lx, 
                        ex = b_sas_2015$ex, 
                        ax = b_sas_2015$ax, 
                        method = 'edag')

b_sas <- rbind(b_sas_1950, b_sas_1955, b_sas_1960, b_sas_1965, b_sas_1970,
               b_sas_1975, b_sas_1980, b_sas_1985, b_sas_1990, b_sas_1995,
               b_sas_2000, b_sas_2005, b_sas_2010, b_sas_2015)
rm(b_sas_1950, b_sas_1955, b_sas_1960, b_sas_1965, b_sas_1970,
   b_sas_1975, b_sas_1980, b_sas_1985, b_sas_1990, b_sas_1995,
   b_sas_2000, b_sas_2005, b_sas_2010, b_sas_2015)


# Yukon, both sexes combined

b_yuk_1950 <- b_yuk[b_yuk$Year == 1950, ]
b_yuk_1950$edag <- ineq(age = b_yuk_1950$Age, 
                        dx = b_yuk_1950$dx, 
                        lx = b_yuk_1950$lx, 
                        ex = b_yuk_1950$ex, 
                        ax = b_yuk_1950$ax, 
                        method = 'edag')

b_yuk_1955 <- b_yuk[b_yuk$Year == 1955, ]
b_yuk_1955$edag <- ineq(age = b_yuk_1955$Age, 
                        dx = b_yuk_1955$dx, 
                        lx = b_yuk_1955$lx, 
                        ex = b_yuk_1955$ex, 
                        ax = b_yuk_1955$ax, 
                        method = 'edag')

b_yuk_1960 <- b_yuk[b_yuk$Year == 1960, ]
b_yuk_1960$edag <- ineq(age = b_yuk_1960$Age, 
                        dx = b_yuk_1960$dx, 
                        lx = b_yuk_1960$lx, 
                        ex = b_yuk_1960$ex, 
                        ax = b_yuk_1960$ax, 
                        method = 'edag')

b_yuk_1965 <- b_yuk[b_yuk$Year == 1965, ]
b_yuk_1965$edag <- ineq(age = b_yuk_1965$Age, 
                        dx = b_yuk_1965$dx, 
                        lx = b_yuk_1965$lx, 
                        ex = b_yuk_1965$ex, 
                        ax = b_yuk_1965$ax, 
                        method = 'edag')

b_yuk_1970 <- b_yuk[b_yuk$Year == 1970, ]
b_yuk_1970$edag <- ineq(age = b_yuk_1970$Age, 
                        dx = b_yuk_1970$dx, 
                        lx = b_yuk_1970$lx, 
                        ex = b_yuk_1970$ex, 
                        ax = b_yuk_1970$ax, 
                        method = 'edag')

b_yuk_1975 <- b_yuk[b_yuk$Year == 1975, ]
b_yuk_1975$edag <- ineq(age = b_yuk_1975$Age, 
                        dx = b_yuk_1975$dx, 
                        lx = b_yuk_1975$lx, 
                        ex = b_yuk_1975$ex, 
                        ax = b_yuk_1975$ax, 
                        method = 'edag')

b_yuk_1980 <- b_yuk[b_yuk$Year == 1980, ]
b_yuk_1980$edag <- ineq(age = b_yuk_1980$Age, 
                        dx = b_yuk_1980$dx, 
                        lx = b_yuk_1980$lx, 
                        ex = b_yuk_1980$ex, 
                        ax = b_yuk_1980$ax, 
                        method = 'edag')

b_yuk_1985 <- b_yuk[b_yuk$Year == 1985, ]
b_yuk_1985$edag <- ineq(age = b_yuk_1985$Age, 
                        dx = b_yuk_1985$dx, 
                        lx = b_yuk_1985$lx, 
                        ex = b_yuk_1985$ex, 
                        ax = b_yuk_1985$ax, 
                        method = 'edag')

b_yuk_1990 <- b_yuk[b_yuk$Year == 1990, ]
b_yuk_1990$edag <- ineq(age = b_yuk_1990$Age, 
                        dx = b_yuk_1990$dx, 
                        lx = b_yuk_1990$lx, 
                        ex = b_yuk_1990$ex, 
                        ax = b_yuk_1990$ax, 
                        method = 'edag')

b_yuk_1995 <- b_yuk[b_yuk$Year == 1995, ]
b_yuk_1995$edag <- ineq(age = b_yuk_1995$Age, 
                        dx = b_yuk_1995$dx, 
                        lx = b_yuk_1995$lx, 
                        ex = b_yuk_1995$ex, 
                        ax = b_yuk_1995$ax, 
                        method = 'edag')

b_yuk_2000 <- b_yuk[b_yuk$Year == 2000, ]
b_yuk_2000$edag <- ineq(age = b_yuk_2000$Age, 
                        dx = b_yuk_2000$dx, 
                        lx = b_yuk_2000$lx, 
                        ex = b_yuk_2000$ex, 
                        ax = b_yuk_2000$ax, 
                        method = 'edag')

b_yuk_2005 <- b_yuk[b_yuk$Year == 2005, ]
b_yuk_2005$edag <- ineq(age = b_yuk_2005$Age, 
                        dx = b_yuk_2005$dx, 
                        lx = b_yuk_2005$lx, 
                        ex = b_yuk_2005$ex, 
                        ax = b_yuk_2005$ax, 
                        method = 'edag')

b_yuk_2010 <- b_yuk[b_yuk$Year == 2010, ]
b_yuk_2010$edag <- ineq(age = b_yuk_2010$Age, 
                        dx = b_yuk_2010$dx, 
                        lx = b_yuk_2010$lx, 
                        ex = b_yuk_2010$ex, 
                        ax = b_yuk_2010$ax, 
                        method = 'edag')

b_yuk_2015 <- b_yuk[b_yuk$Year == 2015, ]
b_yuk_2015$edag <- ineq(age = b_yuk_2015$Age, 
                        dx = b_yuk_2015$dx, 
                        lx = b_yuk_2015$lx, 
                        ex = b_yuk_2015$ex, 
                        ax = b_yuk_2015$ax, 
                        method = 'edag')

b_yuk <- rbind(b_yuk_1950, b_yuk_1955, b_yuk_1960, b_yuk_1965, b_yuk_1970,
               b_yuk_1975, b_yuk_1980, b_yuk_1985, b_yuk_1990, b_yuk_1995,
               b_yuk_2000, b_yuk_2005, b_yuk_2010, b_yuk_2015)
rm(b_yuk_1950, b_yuk_1955, b_yuk_1960, b_yuk_1965, b_yuk_1970,
   b_yuk_1975, b_yuk_1980, b_yuk_1985, b_yuk_1990, b_yuk_1995,
   b_yuk_2000, b_yuk_2005, b_yuk_2010, b_yuk_2015)



# Canada, female

f_can_1950 <- f_can[f_can$Year == 1950, ]
f_can_1950$edag <- ineq(age = f_can_1950$Age, 
                        dx = f_can_1950$dx, 
                        lx = f_can_1950$lx, 
                        ex = f_can_1950$ex, 
                        ax = f_can_1950$ax, 
                        method = 'edag')

f_can_1955 <- f_can[f_can$Year == 1955, ]
f_can_1955$edag <- ineq(age = f_can_1955$Age, 
                        dx = f_can_1955$dx, 
                        lx = f_can_1955$lx, 
                        ex = f_can_1955$ex, 
                        ax = f_can_1955$ax, 
                        method = 'edag')

f_can_1960 <- f_can[f_can$Year == 1960, ]
f_can_1960$edag <- ineq(age = f_can_1960$Age, 
                        dx = f_can_1960$dx, 
                        lx = f_can_1960$lx, 
                        ex = f_can_1960$ex, 
                        ax = f_can_1960$ax, 
                        method = 'edag')

f_can_1965 <- f_can[f_can$Year == 1965, ]
f_can_1965$edag <- ineq(age = f_can_1965$Age, 
                        dx = f_can_1965$dx, 
                        lx = f_can_1965$lx, 
                        ex = f_can_1965$ex, 
                        ax = f_can_1965$ax, 
                        method = 'edag')

f_can_1970 <- f_can[f_can$Year == 1970, ]
f_can_1970$edag <- ineq(age = f_can_1970$Age, 
                        dx = f_can_1970$dx, 
                        lx = f_can_1970$lx, 
                        ex = f_can_1970$ex, 
                        ax = f_can_1970$ax, 
                        method = 'edag')

f_can_1975 <- f_can[f_can$Year == 1975, ]
f_can_1975$edag <- ineq(age = f_can_1975$Age, 
                        dx = f_can_1975$dx, 
                        lx = f_can_1975$lx, 
                        ex = f_can_1975$ex, 
                        ax = f_can_1975$ax, 
                        method = 'edag')

f_can_1980 <- f_can[f_can$Year == 1980, ]
f_can_1980$edag <- ineq(age = f_can_1980$Age, 
                        dx = f_can_1980$dx, 
                        lx = f_can_1980$lx, 
                        ex = f_can_1980$ex, 
                        ax = f_can_1980$ax, 
                        method = 'edag')

f_can_1985 <- f_can[f_can$Year == 1985, ]
f_can_1985$edag <- ineq(age = f_can_1985$Age, 
                        dx = f_can_1985$dx, 
                        lx = f_can_1985$lx, 
                        ex = f_can_1985$ex, 
                        ax = f_can_1985$ax, 
                        method = 'edag')

f_can_1990 <- f_can[f_can$Year == 1990, ]
f_can_1990$edag <- ineq(age = f_can_1990$Age, 
                        dx = f_can_1990$dx, 
                        lx = f_can_1990$lx, 
                        ex = f_can_1990$ex, 
                        ax = f_can_1990$ax, 
                        method = 'edag')

f_can_1995 <- f_can[f_can$Year == 1995, ]
f_can_1995$edag <- ineq(age = f_can_1995$Age, 
                        dx = f_can_1995$dx, 
                        lx = f_can_1995$lx, 
                        ex = f_can_1995$ex, 
                        ax = f_can_1995$ax, 
                        method = 'edag')

f_can_2000 <- f_can[f_can$Year == 2000, ]
f_can_2000$edag <- ineq(age = f_can_2000$Age, 
                        dx = f_can_2000$dx, 
                        lx = f_can_2000$lx, 
                        ex = f_can_2000$ex, 
                        ax = f_can_2000$ax, 
                        method = 'edag')

f_can_2005 <- f_can[f_can$Year == 2005, ]
f_can_2005$edag <- ineq(age = f_can_2005$Age, 
                        dx = f_can_2005$dx, 
                        lx = f_can_2005$lx, 
                        ex = f_can_2005$ex, 
                        ax = f_can_2005$ax, 
                        method = 'edag')

f_can_2010 <- f_can[f_can$Year == 2010, ]
f_can_2010$edag <- ineq(age = f_can_2010$Age, 
                        dx = f_can_2010$dx, 
                        lx = f_can_2010$lx, 
                        ex = f_can_2010$ex, 
                        ax = f_can_2010$ax, 
                        method = 'edag')

f_can_2015 <- f_can[f_can$Year == 2015, ]
f_can_2015$edag <- ineq(age = f_can_2015$Age, 
                        dx = f_can_2015$dx, 
                        lx = f_can_2015$lx, 
                        ex = f_can_2015$ex, 
                        ax = f_can_2015$ax, 
                        method = 'edag')

f_can <- rbind(f_can_1950, f_can_1955, f_can_1960, f_can_1965, f_can_1970,
               f_can_1975, f_can_1980, f_can_1985, f_can_1990, f_can_1995,
               f_can_2000, f_can_2005, f_can_2010, f_can_2015)
rm(f_can_1950, f_can_1955, f_can_1960, f_can_1965, f_can_1970,
   f_can_1975, f_can_1980, f_can_1985, f_can_1990, f_can_1995,
   f_can_2000, f_can_2005, f_can_2010, f_can_2015)


#Canada, male

m_can_1950 <- m_can[m_can$Year == 1950, ]
m_can_1950$edag <- ineq(age = m_can_1950$Age, 
                        dx = m_can_1950$dx, 
                        lx = m_can_1950$lx, 
                        ex = m_can_1950$ex, 
                        ax = m_can_1950$ax, 
                        method = 'edag')

m_can_1955 <- m_can[m_can$Year == 1955, ]
m_can_1955$edag <- ineq(age = m_can_1955$Age, 
                        dx = m_can_1955$dx, 
                        lx = m_can_1955$lx, 
                        ex = m_can_1955$ex, 
                        ax = m_can_1955$ax, 
                        method = 'edag')

m_can_1960 <- m_can[m_can$Year == 1960, ]
m_can_1960$edag <- ineq(age = m_can_1960$Age, 
                        dx = m_can_1960$dx, 
                        lx = m_can_1960$lx, 
                        ex = m_can_1960$ex, 
                        ax = m_can_1960$ax, 
                        method = 'edag')

m_can_1965 <- m_can[m_can$Year == 1965, ]
m_can_1965$edag <- ineq(age = m_can_1965$Age, 
                        dx = m_can_1965$dx, 
                        lx = m_can_1965$lx, 
                        ex = m_can_1965$ex, 
                        ax = m_can_1965$ax, 
                        method = 'edag')

m_can_1970 <- m_can[m_can$Year == 1970, ]
m_can_1970$edag <- ineq(age = m_can_1970$Age, 
                        dx = m_can_1970$dx, 
                        lx = m_can_1970$lx, 
                        ex = m_can_1970$ex, 
                        ax = m_can_1970$ax, 
                        method = 'edag')

m_can_1975 <- m_can[m_can$Year == 1975, ]
m_can_1975$edag <- ineq(age = m_can_1975$Age, 
                        dx = m_can_1975$dx, 
                        lx = m_can_1975$lx, 
                        ex = m_can_1975$ex, 
                        ax = m_can_1975$ax, 
                        method = 'edag')

m_can_1980 <- m_can[m_can$Year == 1980, ]
m_can_1980$edag <- ineq(age = m_can_1980$Age, 
                        dx = m_can_1980$dx, 
                        lx = m_can_1980$lx, 
                        ex = m_can_1980$ex, 
                        ax = m_can_1980$ax, 
                        method = 'edag')

m_can_1985 <- m_can[m_can$Year == 1985, ]
m_can_1985$edag <- ineq(age = m_can_1985$Age, 
                        dx = m_can_1985$dx, 
                        lx = m_can_1985$lx, 
                        ex = m_can_1985$ex, 
                        ax = m_can_1985$ax, 
                        method = 'edag')

m_can_1990 <- m_can[m_can$Year == 1990, ]
m_can_1990$edag <- ineq(age = m_can_1990$Age, 
                        dx = m_can_1990$dx, 
                        lx = m_can_1990$lx, 
                        ex = m_can_1990$ex, 
                        ax = m_can_1990$ax, 
                        method = 'edag')

m_can_1995 <- m_can[m_can$Year == 1995, ]
m_can_1995$edag <- ineq(age = m_can_1995$Age, 
                        dx = m_can_1995$dx, 
                        lx = m_can_1995$lx, 
                        ex = m_can_1995$ex, 
                        ax = m_can_1995$ax, 
                        method = 'edag')

m_can_2000 <- m_can[m_can$Year == 2000, ]
m_can_2000$edag <- ineq(age = m_can_2000$Age, 
                        dx = m_can_2000$dx, 
                        lx = m_can_2000$lx, 
                        ex = m_can_2000$ex, 
                        ax = m_can_2000$ax, 
                        method = 'edag')

m_can_2005 <- m_can[m_can$Year == 2005, ]
m_can_2005$edag <- ineq(age = m_can_2005$Age, 
                        dx = m_can_2005$dx, 
                        lx = m_can_2005$lx, 
                        ex = m_can_2005$ex, 
                        ax = m_can_2005$ax, 
                        method = 'edag')

m_can_2010 <- m_can[m_can$Year == 2010, ]
m_can_2010$edag <- ineq(age = m_can_2010$Age, 
                        dx = m_can_2010$dx, 
                        lx = m_can_2010$lx, 
                        ex = m_can_2010$ex, 
                        ax = m_can_2010$ax, 
                        method = 'edag')

m_can_2015 <- m_can[m_can$Year == 2015, ]
m_can_2015$edag <- ineq(age = m_can_2015$Age, 
                     dx = m_can_2015$dx, 
                     lx = m_can_2015$lx, 
                     ex = m_can_2015$ex, 
                     ax = m_can_2015$ax, 
                     method = 'edag')

m_can <- rbind(m_can_1950, m_can_1955, m_can_1960, m_can_1965, m_can_1970,
               m_can_1975, m_can_1980, m_can_1985, m_can_1990, m_can_1995,
               m_can_2000, m_can_2005, m_can_2010, m_can_2015)
rm(m_can_1950, m_can_1955, m_can_1960, m_can_1965, m_can_1970,
   m_can_1975, m_can_1980, m_can_1985, m_can_1990, m_can_1995,
   m_can_2000, m_can_2005, m_can_2010, m_can_2015)


# Add columns to indicate sex and province/territory

b_alb <- cbind(sex = rep("b", 111), prov = rep("alb", 111), b_alb)
b_bco <- cbind(sex = rep("b", 111), prov = rep("bco", 111), b_bco)
b_can <- cbind(sex = rep("b", 111), prov = rep("can", 111), b_can)
b_man <- cbind(sex = rep("b", 111), prov = rep("man", 111), b_man)
b_nbr <- cbind(sex = rep("b", 111), prov = rep("nbr", 111), b_nbr)
b_nfl <- cbind(sex = rep("b", 111), prov = rep("nfl", 111), b_nfl)
b_nsc <- cbind(sex = rep("b", 111), prov = rep("nsc", 111), b_nsc)
b_nwt <- cbind(sex = rep("b", 111), prov = rep("nwt", 111), b_nwt)
b_ont <- cbind(sex = rep("b", 111), prov = rep("ont", 111), b_ont)
b_pei <- cbind(sex = rep("b", 111), prov = rep("pei", 111), b_pei)
b_que <- cbind(sex = rep("b", 111), prov = rep("que", 111), b_que)
b_sas <- cbind(sex = rep("b", 111), prov = rep("sas", 111), b_sas)
b_yuk <- cbind(sex = rep("b", 111), prov = rep("yuk", 111), b_yuk)

f_can <- cbind(sex = rep("f", 111), prov = rep("can", 111), f_can)
m_can <- cbind(sex = rep("m", 111), prov = rep("can", 111), m_can)
