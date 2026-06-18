# The usa.mortality.org website is down.
# I accessed the .zipped US state life tables at:
# https://dataverse.harvard.edu/file.xhtml?fileId=11378078&version=1.2
# on July 5, 2025.
# If I cite this data source, I will use the citation:
# Barbieri, Magali; Winant, Celeste, 2025, "U.S State Life Tables CSV + TXT 
# 1941-2022", https://doi.org/10.7910/DVN/19WYUX, Harvard Dataverse, V1.2; 
# USStateLifetables2022.zip [fileName]


setwd("C:/Users/jlariscy/lifespan var in Canada/canada_lifespan_variability/USStateLifetables2022/States")

# A for loop could replace lines 19-375.

# Alaska
AK <- read.csv("AK/AK_bltper_1x5.csv")
AK <- AK[AK$Year == "2015-2019", -4]  
  # I remove the fourth column (Age) because it is a character variable.
AK$Age <- 0:110
AK$edag <- ineq(age = AK$Age, dx = AK$dx, lx = AK$lx, ex = AK$ex, ax = AK$ax, method = 'edag')
AK <- AK[AK$Age == 0, c("PopName", "ex", "edag")]

# Alabama
AL <- read.csv("AL/AL_bltper_1x5.csv")
AL <- AL[AL$Year == "2015-2019", -4]
AL$Age <- 0:110
AL$edag <- ineq(age = AL$Age, dx = AL$dx, lx = AL$lx, ex = AL$ex, ax = AL$ax, method = 'edag')
AL <- AL[AL$Age == 0, c("PopName", "ex", "edag")]

# Arkansas
AR <- read.csv("AR/AR_bltper_1x5.csv")
AR <- AR[AR$Year == "2015-2019", -4]
AR$Age <- 0:110
AR$edag <- ineq(age = AR$Age, dx = AR$dx, lx = AR$lx, ex = AR$ex, ax = AR$ax, method = 'edag')
AR <- AR[AR$Age == 0, c("PopName", "ex", "edag")]

# Arizona
AZ <- read.csv("AZ/AZ_bltper_1x5.csv")
AZ <- AZ[AZ$Year == "2015-2019", -4]
AZ$Age <- 0:110
AZ$edag <- ineq(age = AZ$Age, dx = AZ$dx, lx = AZ$lx, ex = AZ$ex, ax = AZ$ax, method = 'edag')
AZ <- AZ[AZ$Age == 0, c("PopName", "ex", "edag")]

# California
CA <- read.csv("CA/CA_bltper_1x5.csv")
CA <- CA[CA$Year == "2015-2019", -4]
CA$Age <- 0:110
CA$edag <- ineq(age = CA$Age, dx = CA$dx, lx = CA$lx, ex = CA$ex, ax = CA$ax, method = 'edag')
CA <- CA[CA$Age == 0, c("PopName", "ex", "edag")]

# Colorado
CO <- read.csv("CO/CO_bltper_1x5.csv")
CO <- CO[CO$Year == "2015-2019", -4]
CO$Age <- 0:110
CO$edag <- ineq(age = CO$Age, dx = CO$dx, lx = CO$lx, ex = CO$ex, ax = CO$ax, method = 'edag')
CO <- CO[CO$Age == 0, c("PopName", "ex", "edag")]

# Connecticut
CT <- read.csv("CT/CT_bltper_1x5.csv")
CT <- CT[CT$Year == "2015-2019", -4]
CT$Age <- 0:110
CT$edag <- ineq(age = CT$Age, dx = CT$dx, lx = CT$lx, ex = CT$ex, ax = CT$ax, method = 'edag')
CT <- CT[CT$Age == 0, c("PopName", "ex", "edag")]

# District of Columbia
DC <- read.csv("DC/DC_bltper_1x5.csv")
DC <- DC[DC$Year == "2015-2019", -4]
DC$Age <- 0:110
DC$edag <- ineq(age = DC$Age, dx = DC$dx, lx = DC$lx, ex = DC$ex, ax = DC$ax, method = 'edag')
DC <- DC[DC$Age == 0, c("PopName", "ex", "edag")]

# Delaware
DE <- read.csv("DE/DE_bltper_1x5.csv")
DE <- DE[DE$Year == "2015-2019", -4]
DE$Age <- 0:110
DE$edag <- ineq(age = DE$Age, dx = DE$dx, lx = DE$lx, ex = DE$ex, ax = DE$ax, method = 'edag')
DE <- DE[DE$Age == 0, c("PopName", "ex", "edag")]

# Florida
FL <- read.csv("FL/FL_bltper_1x5.csv")
FL <- FL[FL$Year == "2015-2019", -4]
FL$Age <- 0:110
FL$edag <- ineq(age = FL$Age, dx = FL$dx, lx = FL$lx, ex = FL$ex, ax = FL$ax, method = 'edag')
FL <- FL[FL$Age == 0, c("PopName", "ex", "edag")]

# Georgia
GA <- read.csv("GA/GA_bltper_1x5.csv")
GA <- GA[GA$Year == "2015-2019", -4]
GA$Age <- 0:110
GA$edag <- ineq(age = GA$Age, dx = GA$dx, lx = GA$lx, ex = GA$ex, ax = GA$ax, method = 'edag')
GA <- GA[GA$Age == 0, c("PopName", "ex", "edag")]

# Hawaii
HI <- read.csv("HI/HI_bltper_1x5.csv")
HI <- HI[HI$Year == "2015-2019", -4]
HI$Age <- 0:110
HI$edag <- ineq(age = HI$Age, dx = HI$dx, lx = HI$lx, ex = HI$ex, ax = HI$ax, method = 'edag')
HI <- HI[HI$Age == 0, c("PopName", "ex", "edag")]

# Iowa
IA <- read.csv("IA/IA_bltper_1x5.csv")
IA <- IA[IA$Year == "2015-2019", -4]
IA$Age <- 0:110
IA$edag <- ineq(age = IA$Age, dx = IA$dx, lx = IA$lx, ex = IA$ex, ax = IA$ax, method = 'edag')
IA <- IA[IA$Age == 0, c("PopName", "ex", "edag")]

# Idaho
ID <- read.csv("ID/ID_bltper_1x5.csv")
ID <- ID[ID$Year == "2015-2019", -4]
ID$Age <- 0:110
ID$edag <- ineq(age = ID$Age, dx = ID$dx, lx = ID$lx, ex = ID$ex, ax = ID$ax, method = 'edag')
ID <- ID[ID$Age == 0, c("PopName", "ex", "edag")]

# Illinois
IL <- read.csv("IL/IL_bltper_1x5.csv")
IL <- IL[IL$Year == "2015-2019", -4]
IL$Age <- 0:110
IL$edag <- ineq(age = IL$Age, dx = IL$dx, lx = IL$lx, ex = IL$ex, ax = IL$ax, method = 'edag')
IL <- IL[IL$Age == 0, c("PopName", "ex", "edag")]

# Indiana
IN <- read.csv("IN/IN_bltper_1x5.csv")
IN <- IN[IN$Year == "2015-2019", -4]
IN$Age <- 0:110
IN$edag <- ineq(age = IN$Age, dx = IN$dx, lx = IN$lx, ex = IN$ex, ax = IN$ax, method = 'edag')
IN <- IN[IN$Age == 0, c("PopName", "ex", "edag")]

# Kansas
KS <- read.csv("KS/KS_bltper_1x5.csv")
KS <- KS[KS$Year == "2015-2019", -4]
KS$Age <- 0:110
KS$edag <- ineq(age = KS$Age, dx = KS$dx, lx = KS$lx, ex = KS$ex, ax = KS$ax, method = 'edag')
KS <- KS[KS$Age == 0, c("PopName", "ex", "edag")]

# Kentucky
KY <- read.csv("KY/KY_bltper_1x5.csv")
KY <- KY[KY$Year == "2015-2019", -4]
KY$Age <- 0:110
KY$edag <- ineq(age = KY$Age, dx = KY$dx, lx = KY$lx, ex = KY$ex, ax = KY$ax, method = 'edag')
KY <- KY[KY$Age == 0, c("PopName", "ex", "edag")]

# Louisiana
LA <- read.csv("LA/LA_bltper_1x5.csv")
LA <- LA[LA$Year == "2015-2019", -4]
LA$Age <- 0:110
LA$edag <- ineq(age = LA$Age, dx = LA$dx, lx = LA$lx, ex = LA$ex, ax = LA$ax, method = 'edag')
LA <- LA[LA$Age == 0, c("PopName", "ex", "edag")]

# Massachusetts
MA <- read.csv("MA/MA_bltper_1x5.csv")
MA <- MA[MA$Year == "2015-2019", -4]
MA$Age <- 0:110
MA$edag <- ineq(age = MA$Age, dx = MA$dx, lx = MA$lx, ex = MA$ex, ax = MA$ax, method = 'edag')
MA <- MA[MA$Age == 0, c("PopName", "ex", "edag")]

# Maryland
MD <- read.csv("MD/MD_bltper_1x5.csv")
MD <- MD[MD$Year == "2015-2019", -4]
MD$Age <- 0:110
MD$edag <- ineq(age = MD$Age, dx = MD$dx, lx = MD$lx, ex = MD$ex, ax = MD$ax, method = 'edag')
MD <- MD[MD$Age == 0, c("PopName", "ex", "edag")]

# Maine
ME <- read.csv("ME/ME_bltper_1x5.csv")
ME <- ME[ME$Year == "2015-2019", -4]
ME$Age <- 0:110
ME$edag <- ineq(age = ME$Age, dx = ME$dx, lx = ME$lx, ex = ME$ex, ax = ME$ax, method = 'edag')
ME <- ME[ME$Age == 0, c("PopName", "ex", "edag")]

# Michigan
MI <- read.csv("MI/MI_bltper_1x5.csv")
MI <- MI[MI$Year == "2015-2019", -4]
MI$Age <- 0:110
MI$edag <- ineq(age = MI$Age, dx = MI$dx, lx = MI$lx, ex = MI$ex, ax = MI$ax, method = 'edag')
MI <- MI[MI$Age == 0, c("PopName", "ex", "edag")]

# Minnesota
MN <- read.csv("MN/MN_bltper_1x5.csv")
MN <- MN[MN$Year == "2015-2019", -4]
MN$Age <- 0:110
MN$edag <- ineq(age = MN$Age, dx = MN$dx, lx = MN$lx, ex = MN$ex, ax = MN$ax, method = 'edag')
MN <- MN[MN$Age == 0, c("PopName", "ex", "edag")]

# Missouri
MO <- read.csv("MO/MO_bltper_1x5.csv")
MO <- MO[MO$Year == "2015-2019", -4]
MO$Age <- 0:110
MO$edag <- ineq(age = MO$Age, dx = MO$dx, lx = MO$lx, ex = MO$ex, ax = MO$ax, method = 'edag')
MO <- MO[MO$Age == 0, c("PopName", "ex", "edag")]

# Mississippi
MS <- read.csv("MS/MS_bltper_1x5.csv")
MS <- MS[MS$Year == "2015-2019", -4]
MS$Age <- 0:110
MS$edag <- ineq(age = MS$Age, dx = MS$dx, lx = MS$lx, ex = MS$ex, ax = MS$ax, method = 'edag')
MS <- MS[MS$Age == 0, c("PopName", "ex", "edag")]

# Montana
MT <- read.csv("MT/MT_bltper_1x5.csv")
MT <- MT[MT$Year == "2015-2019", -4]
MT$Age <- 0:110
MT$edag <- ineq(age = MT$Age, dx = MT$dx, lx = MT$lx, ex = MT$ex, ax = MT$ax, method = 'edag')
MT <- MT[MT$Age == 0, c("PopName", "ex", "edag")]

# North Carolina
NC <- read.csv("NC/NC_bltper_1x5.csv")
NC <- NC[NC$Year == "2015-2019", -4]
NC$Age <- 0:110
NC$edag <- ineq(age = NC$Age, dx = NC$dx, lx = NC$lx, ex = NC$ex, ax = NC$ax, method = 'edag')
NC <- NC[NC$Age == 0, c("PopName", "ex", "edag")]

# North Dakota
ND <- read.csv("ND/ND_bltper_1x5.csv")
ND <- ND[ND$Year == "2015-2019", -4]
ND$Age <- 0:110
ND$edag <- ineq(age = ND$Age, dx = ND$dx, lx = ND$lx, ex = ND$ex, ax = ND$ax, method = 'edag')
ND <- ND[ND$Age == 0, c("PopName", "ex", "edag")]

# Nebraska
NE <- read.csv("NE/NE_bltper_1x5.csv")
NE <- NE[NE$Year == "2015-2019", -4]
NE$Age <- 0:110
NE$edag <- ineq(age = NE$Age, dx = NE$dx, lx = NE$lx, ex = NE$ex, ax = NE$ax, method = 'edag')
NE <- NE[NE$Age == 0, c("PopName", "ex", "edag")]

# New Hampshire
NH <- read.csv("NH/NH_bltper_1x5.csv")
NH <- NH[NH$Year == "2015-2019", -4]
NH$Age <- 0:110
NH$edag <- ineq(age = NH$Age, dx = NH$dx, lx = NH$lx, ex = NH$ex, ax = NH$ax, method = 'edag')
NH <- NH[NH$Age == 0, c("PopName", "ex", "edag")]

# New Jersey
NJ <- read.csv("NJ/NJ_bltper_1x5.csv")
NJ <- NJ[NJ$Year == "2015-2019", -4]
NJ$Age <- 0:110
NJ$edag <- ineq(age = NJ$Age, dx = NJ$dx, lx = NJ$lx, ex = NJ$ex, ax = NJ$ax, method = 'edag')
NJ <- NJ[NJ$Age == 0, c("PopName", "ex", "edag")]

# New Mexico
NM <- read.csv("NM/NM_bltper_1x5.csv")
NM <- NM[NM$Year == "2015-2019", -4]
NM$Age <- 0:110
NM$edag <- ineq(age = NM$Age, dx = NM$dx, lx = NM$lx, ex = NM$ex, ax = NM$ax, method = 'edag')
NM <- NM[NM$Age == 0, c("PopName", "ex", "edag")]

# Nevada
NV <- read.csv("NV/NV_bltper_1x5.csv")
NV <- NV[NV$Year == "2015-2019", -4]
NV$Age <- 0:110
NV$edag <- ineq(age = NV$Age, dx = NV$dx, lx = NV$lx, ex = NV$ex, ax = NV$ax, method = 'edag')
NV <- NV[NV$Age == 0, c("PopName", "ex", "edag")]

# New York
NY <- read.csv("NY/NY_bltper_1x5.csv")
NY <- NY[NY$Year == "2015-2019", -4]
NY$Age <- 0:110
NY$edag <- ineq(age = NY$Age, dx = NY$dx, lx = NY$lx, ex = NY$ex, ax = NY$ax, method = 'edag')
NY <- NY[NY$Age == 0, c("PopName", "ex", "edag")]

# Ohio
OH <- read.csv("OH/OH_bltper_1x5.csv")
OH <- OH[OH$Year == "2015-2019", -4]
OH$Age <- 0:110
OH$edag <- ineq(age = OH$Age, dx = OH$dx, lx = OH$lx, ex = OH$ex, ax = OH$ax, method = 'edag')
OH <- OH[OH$Age == 0, c("PopName", "ex", "edag")]

# Oklahoma
OK <- read.csv("OK/OK_bltper_1x5.csv")
OK <- OK[OK$Year == "2015-2019", -4]
OK$Age <- 0:110
OK$edag <- ineq(age = OK$Age, dx = OK$dx, lx = OK$lx, ex = OK$ex, ax = OK$ax, method = 'edag')
OK <- OK[OK$Age == 0, c("PopName", "ex", "edag")]

# Oregon
OR <- read.csv("OR/OR_bltper_1x5.csv")
OR <- OR[OR$Year == "2015-2019", -4]
OR$Age <- 0:110
OR$edag <- ineq(age = OR$Age, dx = OR$dx, lx = OR$lx, ex = OR$ex, ax = OR$ax, method = 'edag')
OR <- OR[OR$Age == 0, c("PopName", "ex", "edag")]

# Pennsylvania
PA <- read.csv("PA/PA_bltper_1x5.csv")
PA <- PA[PA$Year == "2015-2019", -4]
PA$Age <- 0:110
PA$edag <- ineq(age = PA$Age, dx = PA$dx, lx = PA$lx, ex = PA$ex, ax = PA$ax, method = 'edag')
PA <- PA[PA$Age == 0, c("PopName", "ex", "edag")]

# Rhode Island
RI <- read.csv("RI/RI_bltper_1x5.csv")
RI <- RI[RI$Year == "2015-2019", -4]
RI$Age <- 0:110
RI$edag <- ineq(age = RI$Age, dx = RI$dx, lx = RI$lx, ex = RI$ex, ax = RI$ax, method = 'edag')
RI <- RI[RI$Age == 0, c("PopName", "ex", "edag")]

# South Carolina
SC <- read.csv("SC/SC_bltper_1x5.csv")
SC <- SC[SC$Year == "2015-2019", -4]
SC$Age <- 0:110
SC$edag <- ineq(age = SC$Age, dx = SC$dx, lx = SC$lx, ex = SC$ex, ax = SC$ax, method = 'edag')
SC <- SC[SC$Age == 0, c("PopName", "ex", "edag")]

# South Dakota
SD <- read.csv("SD/SD_bltper_1x5.csv")
SD <- SD[SD$Year == "2015-2019", -4]
SD$Age <- 0:110
SD$edag <- ineq(age = SD$Age, dx = SD$dx, lx = SD$lx, ex = SD$ex, ax = SD$ax, method = 'edag')
SD <- SD[SD$Age == 0, c("PopName", "ex", "edag")]

# Tennessee
TN <- read.csv("TN/TN_bltper_1x5.csv")
TN <- TN[TN$Year == "2015-2019", -4]
TN$Age <- 0:110
TN$edag <- ineq(age = TN$Age, dx = TN$dx, lx = TN$lx, ex = TN$ex, ax = TN$ax, method = 'edag')
TN <- TN[TN$Age == 0, c("PopName", "ex", "edag")]

# Texas
TX <- read.csv("TX/TX_bltper_1x5.csv")
TX <- TX[TX$Year == "2015-2019", -4]
TX$Age <- 0:110
TX$edag <- ineq(age = TX$Age, dx = TX$dx, lx = TX$lx, ex = TX$ex, ax = TX$ax, method = 'edag')
TX <- TX[TX$Age == 0, c("PopName", "ex", "edag")]

# Utah
UT <- read.csv("UT/UT_bltper_1x5.csv")
UT <- UT[UT$Year == "2015-2019", -4]
UT$Age <- 0:110
UT$edag <- ineq(age = UT$Age, dx = UT$dx, lx = UT$lx, ex = UT$ex, ax = UT$ax, method = 'edag')
UT <- UT[UT$Age == 0, c("PopName", "ex", "edag")]

# Virginia
VA <- read.csv("VA/VA_bltper_1x5.csv")
VA <- VA[VA$Year == "2015-2019", -4]
VA$Age <- 0:110
VA$edag <- ineq(age = VA$Age, dx = VA$dx, lx = VA$lx, ex = VA$ex, ax = VA$ax, method = 'edag')
VA <- VA[VA$Age == 0, c("PopName", "ex", "edag")]

# Vermont
VT <- read.csv("VT/VT_bltper_1x5.csv")
VT <- VT[VT$Year == "2015-2019", -4]
VT$Age <- 0:110
VT$edag <- ineq(age = VT$Age, dx = VT$dx, lx = VT$lx, ex = VT$ex, ax = VT$ax, method = 'edag')
VT <- VT[VT$Age == 0, c("PopName", "ex", "edag")]

# Washington
WA <- read.csv("WA/WA_bltper_1x5.csv")
WA <- WA[WA$Year == "2015-2019", -4]
WA$Age <- 0:110
WA$edag <- ineq(age = WA$Age, dx = WA$dx, lx = WA$lx, ex = WA$ex, ax = WA$ax, method = 'edag')
WA <- WA[WA$Age == 0, c("PopName", "ex", "edag")]

# Wisconsin
WI <- read.csv("WI/WI_bltper_1x5.csv")
WI <- WI[WI$Year == "2015-2019", -4]
WI$Age <- 0:110
WI$edag <- ineq(age = WI$Age, dx = WI$dx, lx = WI$lx, ex = WI$ex, ax = WI$ax, method = 'edag')
WI <- WI[WI$Age == 0, c("PopName", "ex", "edag")]

# West Virginia
WV <- read.csv("WV/WV_bltper_1x5.csv")
WV <- WV[WV$Year == "2015-2019", -4]
WV$Age <- 0:110
WV$edag <- ineq(age = WV$Age, dx = WV$dx, lx = WV$lx, ex = WV$ex, ax = WV$ax, method = 'edag')
WV <- WV[WV$Age == 0, c("PopName", "ex", "edag")]

# Wyoming
WY <- read.csv("WY/WY_bltper_1x5.csv")
WY <- WY[WY$Year == "2015-2019", -4]
WY$Age <- 0:110
WY$edag <- ineq(age = WY$Age, dx = WY$dx, lx = WY$lx, ex = WY$ex, ax = WY$ax, method = 'edag')
WY <- WY[WY$Age == 0, c("PopName", "ex", "edag")]

states <- rbind(AK, AL, AR, AZ, CA, CO, CT, DC, DE, FL, 
                GA, HI, IA, ID, IL, IN, KS, KY, LA, MA, 
                MD, ME, MI, MN, MO, MS, MT, NC, ND, NE, 
                NH, NJ, NM, NV, NY, OH, OK, OR, PA, RI, 
                SC, SD, TN, TX, UT, VA, VT, WA, WI, WV, WY)

rm(AK, AL, AR, AZ, CA, CO, CT, DC, DE, FL, 
   GA, HI, IA, ID, IL, IN, KS, KY, LA, MA, 
   MD, ME, MI, MN, MO, MS, MT, NC, ND, NE, 
   NH, NJ, NM, NV, NY, OH, OK, OR, PA, RI, 
   SC, SD, TN, TX, UT, VA, VT, WA, WI, WV, WY)
