# --- libraries --- # 

library(readr)
library(dplyr)
library(estimatr)
library(broom)

# --- Load Data --- #
df <- read_csv("data/Money_Experiment.csv")

# --- Regressions: --- # 
# Money - Main
# Evidence for Concentration Bias
# reg1 - later payoff dispersed
# reg 2 - early payoff dispersed
reg1 <- lm(diff_bs_choice ~ 1, data = df %>% filter(condition == 7 & treatment == 1))
reg2 <- lm(diff_bs_choice ~ 1, data = df %>% filter(condition == 8 & treatment == 1))

tidy(reg1, conf.int = TRUE)
glance(reg1)

tidy(reg2, conf.int = TRUE)
glance(reg2)

# Dispersed Payoff Over time
## 8 payment dates
reg3 <- lm_robust(
    diff_bs_choice ~ 1,
    data = df %>% filter(condition %in% c(5, 6) & treatment == 1),
    clusters = tn,
    se_type = "stata"
)

tidy(reg3, conf.int = TRUE)
glance(reg3)

## 4 payment dates
reg4 <- lm_robust(
    diff_bs_choice ~ 1,
    data = df %>% filter(condition %in% c(3, 4) & treatment == 1),
    clusters = tn,
    se_type = "stata"
)

tidy(reg4, conf.int = TRUE)
glance(reg4)

## two payment dates
reg5 <- lm_robust(
    diff_bs_choice ~ 1,
    data = df %>% filter(condition %in% c(1, 2) & treatment == 1),
    clusters = tn,
    se_type = "stata"
)

tidy(reg5, conf.int = TRUE)
glance(reg5)

# Mechanism 


reg6 <- lm_robust(
    diff_bs_choice ~ treatment,
    data = df %>% filter(condition %in% c(7,8)),
    clusters = tn,
    se_type = "stata"
)

summary(reg6)
glance(reg6)
