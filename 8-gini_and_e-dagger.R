#e_dagger_5 <- predictors |>
#  filter(year==2000 | year==2005 | year==2010 | year==2015 | year==2019)

#e_dagger_5 <- predictors |>
#  filter(year==2000 | year==2019)

e_dagger_5 <- predictors |>
  filter(year==2000 | year==2010 | year==2019)

install.packages("ggrepel")
library(ggrepel)

e_dagger_5$province[e_dagger_5$province == "alb"] = "Alberta"
e_dagger_5$province[e_dagger_5$province == "bco"] = "British Columbia"
e_dagger_5$province[e_dagger_5$province == "man"] = "Manitoba"
e_dagger_5$province[e_dagger_5$province == "nbr"] = "New Brunswick"
e_dagger_5$province[e_dagger_5$province == "nfl"] = "Newfoundland"
e_dagger_5$province[e_dagger_5$province == "nsc"] = "Nova Scotia"
e_dagger_5$province[e_dagger_5$province == "ont"] = "Ontario"
e_dagger_5$province[e_dagger_5$province == "pei"] = "Prince Edward Island"
e_dagger_5$province[e_dagger_5$province == "que"] = "Quebec"
e_dagger_5$province[e_dagger_5$province == "sas"] = "Saskatchewan"


# Replicating the Gini and lifespan variability from Edwards and Tuljapurkar

ggplot(data = e_dagger_5, aes(x = gini, y = edag, 
                              color = province, shape = province)) +
  geom_path() +
  geom_point() +
  geom_text_repel(aes(label = year, family = "serif")) +
  scale_shape_manual(values = c("Alberta" = 1,
                                "British Columbia" = 2,
                                "Manitoba" = 3,
                                "New Brunswick" = 4,
                                "Newfoundland" = 5,
                                "Nova Scotia" = 6,
                                "Ontario" = 7,
                                "Prince Edward Island" = 8,
                                "Quebec"= 9,
                                "Saskatchewan" = 10)) +
  guides(color = guide_legend(override.aes = list(label = ""))) +
  ylab(expression(bold("Lifespan Disparity (")~bolditalic("e")~bold(""["0"]^"\u2020")~bold(")"))) +
  xlab(expression(bold("Gini Index"))) +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(color = "black"),
        axis.text.y = element_text(color = "black"),
        text = element_text(family = "serif"),
        strip.text = element_text(face = "bold"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.title = element_blank()) +
  coord_cartesian(ylim = c(9.5, 12), xlim = c(.28,.38)) +
  scale_x_continuous(breaks = seq(.28, .38, by = 0.02))
  scale_y_continuous(breaks = seq(9.5, 12, by = 0.5))

# guides(color = guide_legend(override.aes = list(label = "")))
# changes the legend so that the shape is shown next to each province
# rather than the letter a, which comes from geom_text.

  
# Manitoba and Saskatchewan (two of the prairie provinces) are unique.
# They had higher e-daggers than the other provinces, and they did not
# exhibit an association between Gini index and e-dagger.
  