# I arrange the e-dagger and life expectancy values so that they match the
# input files for the R programs that produce figures in Brown, Lariscy, and
# Walker (2023).

# Run programs 1-chmd_import.R and 2-chmd_us_states.R before running this 
# program.

install.packages("data.table")
install.packages("dplyr")
install.packages("extrafont")
install.packages("ggplot2")
install.packages("grid")
install.packages("gridExtra")
install.packages("reshape2")
install.packages("scales")
library(data.table)  # transpose() function
library(dplyr)
library(extrafont)
library(grid)
library(ggplot2)
library(gridExtra)
library(reshape2)
library(scales)


# Figure 1: dx curves in 1950-1954 and 2015-2019 ----

# Plot dx function with plot()
#windows(width = 9, height = 6)
#plot(b_can$Age[b_can$Year == 1950], b_can$dx[b_can$Year == 1950], type = "l", lty = 1,
#     xlab = "age", ylab = "dx", ylim = c(0, 4500), las = 1)
#lines(b_can$Age[b_can$Year == 2015], b_can$dx[b_can$Year == 2015], type = "l", lty = 2)
#legend("top", legend = c("1950-1954", "2015-2019"),
#       lty = 1:2, cex)


# Plot dx function with ggplot2()
can1950_2015 <- subset(b_can, b_can$Year == 1950 | b_can$Year == 2015)
can1950_2015$Year <- factor(can1950_2015$Year)

windows(width = 9, height = 6)
ggplot(data = can1950_2015, 
       aes(x = Age, y = dx, group = Year, linetype = Year, color = Year)) +
  geom_line(size = 1.1) +
  scale_x_continuous(breaks = seq(0, 110, by = 10), expand = c(0.02, 0.1)) +
  scale_y_continuous(label = comma, expand = c(0.02, 0.1)) +
  scale_color_manual(values = c("black", "grey"), 
                     labels = c("1950\u20131954", "2015\u20132019")) +
  scale_linetype_manual(values = c("solid", "dashed"),
                        labels = c("1950\u20131954", "2015\u20132019")) +
  ggtitle(expression(bold("Figure 1:")~"Age-at-death distributions for Canada overall in 1950\u20131954 and 2015\u20132019")) +
  ylab(expression(bold("Life table deaths (")~bold(""["1"])~bolditalic("d")~bold(""["x"])~bold(")"))) +
  xlab(expression(bold("Age"))) +
  coord_cartesian(ylim = c(0, 4500)) +
  theme_bw() +
  theme(text = element_text(family = "serif"),
        axis.text.x = element_text(color = "black", size = 12),
        axis.text.y = element_text(color = "black", size = 12),
        axis.title = element_text(size = 13),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = c(0.3, 0.8),
        legend.title = element_blank(),
        legend.text = element_text(size = 12),
        legend.key.width = unit(4, "line")) 

#loadfonts(device = "postscript")

ggsave("C:/Users/jlariscy/lifespan var in Canada/canada_lifespan_variability/figures/figure1_dx.png", 
       device = png)


# Figure 2 - plot of e-dagger 0 over time for Canada overall ----

df_fig1_b <- b_can[b_can$Age==0, c("prov", "sex", "Year", "Age", "edag")]
df_fig1_f <- f_can[f_can$Age==0, c("prov", "sex", "Year", "Age", "edag")]
df_fig1_m <- m_can[m_can$Age==0, c("prov", "sex", "Year", "Age", "edag")]
df_fig1 <- rbind(df_fig1_b, df_fig1_f, df_fig1_m)

# With plot() function
#windows(width = 8, height = 6)
#plot(df_fig1$Year[df_fig1$sex=="b"], df_fig1$edag[df_fig1$sex=="b"], 
#     type = "l", lty = 1, las = 1,
#     ylim = c(9, 15), xlab = "Year", ylab = "e-dagger")
#lines(df_fig1$Year[df_fig1$sex=="f"], df_fig1$edag[df_fig1$sex=="f"], 
#      type = "l", lty = 2)
#lines(df_fig1$Year[df_fig1$sex=="m"], df_fig1$edag[df_fig1$sex=="m"], 
#      type = "l", lty = 3)
#legend("topright", legend = c("Both sexes combined", "Female", "Male"),
#       lty = 1:3, cex)


# With ggplot

# Value labels for x-axis
year.lbl <- c("1950\u20131954", "1955\u20131959", "1960\u20131964",
              "1965\u20131969", "1970\u20131974", "1975\u20131979",
              "1980\u20131984", "1985\u20131989", "1990\u20131994", 
              "1995\u20131999", "2000\u20132004", "2005\u20132009", 
              "2010\u20132014", "2015\u20132019")
# \u2013 makes an endash

windows(width = 8, height = 6)
ggplot(data = df_fig1,
       aes(x = Year, y = edag, group = sex)) +
  geom_line(aes(linetype = sex), size = 1.3) +
  scale_linetype_manual(values = c("solid", "longdash", "dotted"),
                        labels = c("Overall", "Women", "Men")) +
  scale_y_continuous(limits = c(9, 16), n.breaks = 7) +
  scale_x_continuous(breaks = seq(1950, 2019, by = 5), labels = year.lbl) +
  ggtitle(expression(bold("Figure 2:")~"Trends in lifespan variability in Canada, overall and by sex")) +
  ylab(expression(bold("Lifespan Disparity (")~bolditalic("e")~bold(""["0"]^"\u2020")~bold(")"))) +
  xlab(expression(bold("Year"))) +
  theme_bw() +
  theme(text = element_text(family = "serif"),
        axis.text.x = element_text(color = "black", size = 12, angle = 45,
                                   vjust = 1, hjust = 1),
        axis.text.y = element_text(color = "black", size = 12),
        axis.title = element_text(size = 13),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = c(0.2, 0.2),
        legend.title = element_blank(),
        legend.key.width = unit(1.5,"cm"),
        legend.text = element_text(size = 12))

ggsave("C:/Users/jlariscy/lifespan var in Canada/canada_lifespan_variability/figures/figure2_e-dagger.png", 
       device = png)


# Supplemental analysis with e-dagger-10
df_fig1_b_e10 <- b_can[b_can$Age==10, c("prov", "sex", "Year", "Age", "edag")]
df_fig1_f_e10 <- f_can[f_can$Age==10, c("prov", "sex", "Year", "Age", "edag")]
df_fig1_m_e10 <- m_can[m_can$Age==10, c("prov", "sex", "Year", "Age", "edag")]
df_fig1_e10 <- rbind(df_fig1_b_e10, df_fig1_f_e10, df_fig1_m_e10)

# With plot() function
windows(width = 8, height = 6)
plot(df_fig1_e10$Year[df_fig1_e10$sex=="b"], df_fig1_e10$edag[df_fig1_e10$sex=="b"], 
     type = "l", lty = 1, las = 1,
     ylim = c(9, 16), xlab = "Year", ylab = "e-dagger")
lines(df_fig1_e10$Year[df_fig1_e10$sex=="f"], df_fig1_e10$edag[df_fig1_e10$sex=="f"], 
      type = "l", lty = 2)
lines(df_fig1_e10$Year[df_fig1_e10$sex=="m"], df_fig1_e10$edag[df_fig1_e10$sex=="m"], 
      type = "l", lty = 3)
legend("topright", legend = c("Both sexes combined", "Female", "Male"),
       lty = 1:3, cex)



# Facet plot for each province/territory, both sexes ----

  # These table requires three separate input data files:
    # 1. Canada overall: one column for year and one column for e-dagger
    # 2. Provinces: one column for province, one column for year, one column
    #    for e-dagger
    # 3. Other provinces: One column for year and one column for e-dagger

# Data prep:

# For Canada overall, I can use data file "df_fig1_b"

# Provinces:

df_fig3_alb <- b_alb[b_alb$Age == 0, c("prov", "sex", "Year", "Age", "edag")]
df_fig3_bco <- b_bco[b_bco$Age == 0, c("prov", "sex", "Year", "Age", "edag")]
df_fig3_man <- b_man[b_man$Age == 0, c("prov", "sex", "Year", "Age", "edag")]
df_fig3_nbr <- b_nbr[b_nbr$Age == 0, c("prov", "sex", "Year", "Age", "edag")]
df_fig3_nfl <- b_nfl[b_nfl$Age == 0, c("prov", "sex", "Year", "Age", "edag")]
df_fig3_nsc <- b_nsc[b_nsc$Age == 0, c("prov", "sex", "Year", "Age", "edag")]
df_fig3_nwt <- b_nwt[b_nwt$Age == 0, c("prov", "sex", "Year", "Age", "edag")]
df_fig3_ont <- b_ont[b_ont$Age == 0, c("prov", "sex", "Year", "Age", "edag")]
df_fig3_pei <- b_pei[b_pei$Age == 0, c("prov", "sex", "Year", "Age", "edag")]
df_fig3_que <- b_que[b_que$Age == 0, c("prov", "sex", "Year", "Age", "edag")]
df_fig3_sas <- b_sas[b_sas$Age == 0, c("prov", "sex", "Year", "Age", "edag")]
df_fig3_yuk <- b_yuk[b_yuk$Age == 0, c("prov", "sex", "Year", "Age", "edag")]
df_fig3_provs <- rbind(df_fig3_alb, df_fig3_bco, df_fig3_man, df_fig3_nbr,
                       df_fig3_nfl, df_fig3_nsc, df_fig3_nwt, df_fig3_ont,
                       df_fig3_pei, df_fig3_que, df_fig3_sas, df_fig3_yuk)

class(df_fig3_provs$prov)
df_fig3_provs$prov[df_fig3_provs$prov == "alb"] = "Alberta"
df_fig3_provs$prov[df_fig3_provs$prov == "bco"] = "British Columbia"
df_fig3_provs$prov[df_fig3_provs$prov == "man"] = "Manitoba"
df_fig3_provs$prov[df_fig3_provs$prov == "nbr"] = "New Brunswick"
df_fig3_provs$prov[df_fig3_provs$prov == "nfl"] = "Newfoundland"
df_fig3_provs$prov[df_fig3_provs$prov == "nsc"] = "Nova Scotia"
df_fig3_provs$prov[df_fig3_provs$prov == "nwt"] = "Northwest Territories"
df_fig3_provs$prov[df_fig3_provs$prov == "ont"] = "Ontario"
df_fig3_provs$prov[df_fig3_provs$prov == "pei"] = "Prince Edward Island"
df_fig3_provs$prov[df_fig3_provs$prov == "que"] = "Quebec"
df_fig3_provs$prov[df_fig3_provs$prov == "sas"] = "Saskatchewan"
df_fig3_provs$prov[df_fig3_provs$prov == "yuk"] = "Yukon"

df_fig3_other_provs <- df_fig3_provs[,-1]  # remove prov variable
df_fig3_b <- df_fig1_b[,-1]  # remove prov variable


windows(width = 13, height = 7)
ggplot(NULL, aes(x = Year, y = edag)) +
  geom_point(data = df_fig3_other_provs, size = 2, col = "grey") +
  geom_point(data = df_fig3_b, shape = 5, size = 2, fill = "grey", col = "black") +
  geom_point(data = df_fig3_provs, size = 3.5) +
  facet_wrap(~ prov, ncol = 4) +
  ylab(expression(bold("Lifespan Disparity (")~bolditalic("e")~bold(""["0"]^"\u2020")~bold(")"))) +
  xlab(expression(bold("Year"))) +
  scale_y_continuous(labels = label_number(accuracy = 0.1)) +
  scale_x_continuous(breaks = seq(1950, 2019, by = 5), labels = year.lbl) +
  coord_cartesian(ylim = c(9, 25)) +
  theme_bw() +
  theme(axis.text.x = element_text(color = "black", angle = 90, vjust = 0.5),
        axis.text.y = element_text(color = "black"),
        text = element_text(family = "serif"),
        strip.text = element_text(face = "bold"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

#ggsave("C:/Users/jlariscy/lifespan var in Canada/canada_lifespan_variability/figures/figure3_facet.png", 
#       device = png)


# Figure 3: Facet plot for the 10 provinces, without Northwest Territories and Yukon, both sexes ----

df_fig3_provs_no_terrs <- df_fig3_provs[df_fig3_provs$prov != "Northwest Territories" & df_fig3_provs$prov != "Yukon", ]
df_fig3_other_provs_no_terrs <- df_fig3_provs_no_terrs[,-1]  # remove prov variable

range(df_fig3_provs_no_terrs$edag)

windows(width = 13, height = 7)
ggplot(NULL, aes(x = Year, y = edag)) +
  geom_point(data = df_fig3_other_provs_no_terrs, size = 2, col = "grey") +
  geom_point(data = df_fig3_b, shape = 5, size = 2, fill = "grey", col = "black") +
  geom_point(data = df_fig3_provs_no_terrs, size = 3.5) +
  facet_wrap(~ prov, ncol = 4) +
  ggtitle(expression(bold("Figure 3:")~"Trends in lifespan variability among Canadian provinces, excluding Yukon and the Northwest Territories")) +
  ylab(expression(bold("Lifespan Disparity (")~bolditalic("e")~bold(""["0"]^"\u2020")~bold(")"))) +
  xlab(expression(bold("Year"))) +
  scale_y_continuous(labels = label_number(accuracy = 0.1), n.breaks = 6) +
  scale_x_continuous(breaks = seq(1950, 2019, by = 5), labels = year.lbl) +
  coord_cartesian(ylim = c(9, 15.5)) +
  theme_bw() +
  theme(axis.text.x = element_text(color = "black", angle = 90, vjust = 0.5),
        axis.text.y = element_text(color = "black"),
        text = element_text(family = "serif"),
        strip.text = element_text(face = "bold"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggsave("C:/Users/jlariscy/lifespan var in Canada/canada_lifespan_variability/figures/figure3_facet_no_territories.png", 
       device = png)


# Figure 4: Facet plot for ONLY Northwest Territories and Yukon, both sexes ----

df_fig3_terrs <- df_fig3_provs[df_fig3_provs$prov == "Northwest Territories" | df_fig3_provs$prov == "Yukon", ]

range(df_fig3_provs_no_terrs$edag)

windows(width = 7, height = 3.5)
ggplot(NULL, aes(x = Year, y = edag)) +
  geom_point(data = df_fig3_other_provs, size = 2, col = "grey") +
  geom_point(data = df_fig3_b, shape = 5, size = 2, fill = "grey", col = "black") +
  geom_point(data = df_fig3_terrs, size = 3.5) +
  facet_wrap(~ prov, ncol = 2) +
  ggtitle(expression(bold("Figure 4:")~"Trends in lifespan variability in Yukon and the Northwest Territories")) +
  ylab(expression(bold("Lifespan Disparity (")~bolditalic("e")~bold(""["0"]^"\u2020")~bold(")"))) +
  xlab(expression(bold("Year"))) +
  scale_y_continuous(labels = label_number(accuracy = 0.1), n.breaks = 6) +
  scale_x_continuous(breaks = seq(1950, 2019, by = 5), labels = year.lbl) +
  coord_cartesian(ylim = c(9, 25)) +
  theme_bw() +
  theme(axis.text.x = element_text(color = "black", angle = 90, vjust = 0.5),
        axis.text.y = element_text(color = "black"),
        text = element_text(family = "serif"),
        strip.text = element_text(face = "bold"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggsave("C:/Users/jlariscy/lifespan var in Canada/canada_lifespan_variability/figures/figure4_facet_only_territories.png", 
       device = png)


# Table 1 ----

table1_edagger0 <- cbind(df_fig1_b[,3], df_fig1_b[,5], 
                         df_fig3_alb[,5], df_fig3_bco[,5], df_fig3_man[,5], 
                         df_fig3_nbr[,5], df_fig3_nfl[,5], df_fig3_nsc[,5], 
                         df_fig3_nwt[,5], df_fig3_ont[,5], df_fig3_pei[,5], 
                         df_fig3_que[,5], df_fig3_sas[,5], df_fig3_yuk[,5])
table1_edagger0 <- data.frame(table1_edagger0)
View(table1_edagger0)  # Year is the first column
table1_edagger0 <- transpose(table1_edagger0)
View(table1_edagger0)  # Year is the first row
table1_edagger0 <- table1_edagger0[-1,] # Remove first row (Year)
View(table1_edagger0)

# I would like to add line breaks after the em dashes
colnames(table1_edagger0) <- year.lbl
rownames(table1_edagger0) <- c("Canada", "Alberta", "British Columbia",
                               "Manitoba", "New Brunswick", "Newfoundland",
                               "Nova Scotia", "Northwest Territories",
                               "Ontario", "Prince Edward Island", "Quebec",
                               "Saskatchewan", "Yukon")

table1_edagger0 <- round(table1_edagger0, 1)  # round e-dagger to 1 decimal place
write.csv(table1_edagger0, 
          "C:/Users/jlariscy/lifespan var in Canada/canada_lifespan_variability/figures/table1_edagger0.csv")


# Figure 5: Changes in life expectancy and e-dagger ----

  # Data prep: The input data file should have four variables: 
  # province, year, ex, and edagger

df_fig5_alb <- b_alb[b_alb$Age == 0, c("prov", "Year", "ex", "edag")]
df_fig5_bco <- b_bco[b_bco$Age == 0, c("prov", "Year", "ex", "edag")]
df_fig5_man <- b_man[b_man$Age == 0, c("prov", "Year", "ex", "edag")]
df_fig5_nbr <- b_nbr[b_nbr$Age == 0, c("prov", "Year", "ex", "edag")]
df_fig5_nfl <- b_nfl[b_nfl$Age == 0, c("prov", "Year", "ex", "edag")]
df_fig5_nsc <- b_nsc[b_nsc$Age == 0, c("prov", "Year", "ex", "edag")]
df_fig5_nwt <- b_nwt[b_nwt$Age == 0, c("prov", "Year", "ex", "edag")]
df_fig5_ont <- b_ont[b_ont$Age == 0, c("prov", "Year", "ex", "edag")]
df_fig5_pei <- b_pei[b_pei$Age == 0, c("prov", "Year", "ex", "edag")]
df_fig5_que <- b_que[b_que$Age == 0, c("prov", "Year", "ex", "edag")]
df_fig5_sas <- b_sas[b_sas$Age == 0, c("prov", "Year", "ex", "edag")]
df_fig5_yuk <- b_yuk[b_yuk$Age == 0, c("prov", "Year", "ex", "edag")]
df_fig5_scatter <- rbind(df_fig5_alb, df_fig5_bco, df_fig5_man, df_fig5_nbr,
                         df_fig5_nfl, df_fig5_nsc, df_fig5_nwt, df_fig5_ont,
                         df_fig5_pei, df_fig5_que, df_fig5_sas, df_fig5_yuk)

# reshape data from long to wide
df_fig5_scatter_wide <- reshape(data = df_fig5_scatter,
                                idvar = "prov",
                                v.names = c("ex", "edag"),
                                timevar = "Year",
                                direction = "wide")

df_fig5_scatter_wide$ex.1950.1974 = df_fig5_scatter_wide$ex.1970 - df_fig5_scatter_wide$ex.1950
df_fig5_scatter_wide$ex.1975.1999 = df_fig5_scatter_wide$ex.1995 - df_fig5_scatter_wide$ex.1975
df_fig5_scatter_wide$ex.2000.2019 = df_fig5_scatter_wide$ex.2015 - df_fig5_scatter_wide$ex.2000

df_fig5_scatter_wide$ld.1950.1974 = df_fig5_scatter_wide$edag.1970 - df_fig5_scatter_wide$edag.1950
df_fig5_scatter_wide$ld.1975.1999 = df_fig5_scatter_wide$edag.1995 - df_fig5_scatter_wide$edag.1975
df_fig5_scatter_wide$ld.2000.2019 = df_fig5_scatter_wide$edag.2015 - df_fig5_scatter_wide$edag.2000

# Keep only the variables I need
df_fig5_scatter_wide <- df_fig5_scatter_wide[c("prov",
                                               "ex.1950.1974", "ex.1975.1999",
                                               "ex.2000.2019", "ld.1950.1974",
                                               "ld.1975.1999", "ld.2000.2019")]

df_fig5_scatter_long <- reshape(data = df_fig5_scatter_wide,
                                direction = 'long', 
                                varying = c('ex.1950.1974', 'ld.1950.1974',
                                            'ex.1975.1999', 'ld.1975.1999',
                                            'ex.2000.2019', 'ld.2000.2019'), 
                                timevar = 'Year',
                                times = c('1950.1974', '1975.1999','2000.2019'),
                                v.names = c('ex.change', 'ld.change'),
                                idvar = 'prov')

facet_labels <- c("1950.1974" = "1950\u20131954 to 1970\u20131974",
                  "1975.1999" = "1975\u20131979 to 1995\u20131999", 
                  "2000.2019" = "2000\u20132004 to 2015\u20132019")

ann_text <- data.frame(ld.change = 0.3, ex.change = 4, Year = "1950.1974",
                       label = 
"Data point for
Northwest Territories
not shown. Life
expectancy increased
by 20.0 years, and
e-dagger decreased
by 7.0 years.")

# labeller function to have true minus sign for negative numbers
label_trueminus <- function(x){
  ifelse(sign(x) == -1, paste0("\u2212", abs(x)), x)
}

# Check range of ex.change and ld.change to see how to set axes
range(df_fig5_scatter_long$ld.change)
range(df_fig5_scatter_long$ex.change)
  # From 1950 to 1974, ex in Northwest Territories increased by 19.96 years
  # From 1950 to 1974, e-dagger in Northwest Territories decreased by -7.0 years

windows(width = 12, height = 30)
ggplot(data = df_fig5_scatter_long, aes(x = ld.change, y = ex.change)) +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = 0) +
  geom_point(shape = 21, size = 2, fill = "grey", col = "black") +
  facet_wrap(~ Year, nrow = 3,
             scales = "free",
             labeller = labeller(Year = facet_labels)) +
  ggtitle(expression(bold("Figure 5:\n\n")~"Changes in lifespan \nvariability and life \nexpectancy")) +
  ylab(expression(bold('Changes in')~bolditalic('e')~bold(""["0"]))) +     
  xlab(expression(bold('Changes in')~bolditalic('e')~bold(""["0"]^"\u2020"))) + 
  scale_x_continuous(breaks = seq(-3, 3, by = 1), labels = label_trueminus) +
  scale_y_continuous(breaks = seq(-1, 7, by = 1), labels = label_trueminus) +
  coord_cartesian(ylim = c(-1, 7), xlim = c(-3, 3)) +
  theme_bw() +
  theme(axis.text.x = element_text(size = 11, color = "black"),
        axis.text.y = element_text(size = 11, color = "black"),
        text = element_text(size = 12, family = "serif"),
        panel.spacing = unit(1, "lines"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        strip.text = element_text(face = "bold", size = 12),
        plot.margin = margin(t = 40, r = 10, b = 10, l = 10)) +
  geom_text(data = ann_text, label = ann_text$label, family = "Times New Roman",
            size = 2.5, hjust = 0)

# scales = "free" - adds y-axis to all three facets, not just the first one
# panel.spacing = unit(2, "lines") - adds space between facets

ggsave("C:/Users/jlariscy/lifespan var in Canada/canada_lifespan_variability/figures/figure5_scatter.png", 
       device = png)


# Canada and US comparison in 2015-2019 ----

# Prep data
comp_can <- df_fig5_scatter[df_fig5_scatter$Year == 2015, ]
comp_can$PopName <- comp_can$prov
comp_can$nation <- rep("CAN", times = 12)  
  # Add variable nation, give all rows a value of "can"
comp_can <- comp_can[, c(6, 5, 3, 4)]
  # Reorder the columns to match order of comp_us.

# Run the script chmd_us_states.R first.
comp_usa <- states
comp_usa$nation <- rep("USA", length(comp_usa))

comp_fig <- rbind(comp_usa, comp_can)  
  # Bind Canada second so their points are on top.
range(comp_fig$ex)
range(comp_fig$edag)


windows(width = 6, height = 6)
ggplot(data = comp_fig, aes(x = ex, y = edag)) +
  geom_point(aes(fill = factor(nation)), color = "black", size = 4, shape = 21) +
  scale_fill_manual(values = c("black", "grey"), 
                     labels = c("Canadian provinces and territories", "U.S. states")) +
  ggtitle(expression(bold("Figure 6:\n")~"Lifespan variability and life expectancy in Canadian \nprovinces/territories and U.S. states, 2015\u20132019")) +
  xlab(expression(bold('Life expectancy')~bolditalic('e')~bold(""["0"]))) +     
  ylab(expression(bold('Lifespan disparity ')~bolditalic('e')~bold(""["0"]^"\u2020"))) +
  scale_x_continuous(limits = c(74, 84), breaks = seq(74, 84, 2)) +
  scale_y_continuous(limits = c(9, 14)) +
  theme_bw() + 
  theme(text = element_text(family = "serif"),
        axis.text.x = element_text(color = "black", size = 12),
        axis.text.y = element_text(color = "black", size = 12),
        axis.title = element_text(size = 13),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = c(0.3, 0.1),
        legend.title = element_blank(),
        legend.background = element_blank(),
        legend.box.background = element_rect(color = "black"),
        legend.text = element_text(size = 12),
        plot.margin = margin(t = 30, r = 10, b = 10, l = 10)) +
  annotate("text", x = 74.9, y = 12,   family = "serif", label = "Northwest\nTerritories") +
  annotate("text", x = 78.2, y = 11,   family = "serif", label = "Yukon") +
  annotate("text", x = 79.9, y = 12.4, family = "serif", label = "Manitoba") +
  annotate("text", x = 81.5, y = 12,   family = "serif", label = "Saskatchewan") +
  annotate("segment", x = 74.9, xend = 74.43, y = 12.3, yend = 12.8) +
  annotate("segment", x = 78.2, xend = 78.9,  y = 11.1, yend = 11.7) +
  annotate("segment", x = 79.8, xend = 80,    y = 12.3, yend = 11.5) +
  annotate("segment", x = 81,   xend = 80.15, y = 11.9, yend = 11.57)

ggsave("C:/Users/jlariscy/lifespan var in Canada/canada_lifespan_variability/figures/figure6_comparison.png", 
       device = png)
