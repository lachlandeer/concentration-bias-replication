# What we do 

# --- Libraries --- # 
library(readr)
library(dplyr)
library(estimatr)
library(modelsummary)

# --- Load Data --- #
df <- read_csv("out_data/consumption_experiment.csv")

# --- Selecting Slices of Data --- # 
# Each column of table 3 uses a different slice of data
# Here we pre-filter so we have one data set per specification 

df_col1 <- 
    df %>% 
    filter(treatment == 1, pap_sample == 1)

df_col2 <-
    df %>%
    filter(pizza == 0, pap_sample == 1)

df_col3 <- 
    df %>% 
    filter(pap_sample == 1, pizza == 1 , dispersed == 0)

df_col4 <- 
    df %>%
    filter(pap_sample == 1 , pizza == 1 , dispersed == 1)

# --- Regressions Using DGRSS measure of d^rel --- #
mod_col1 <- lm_robust(qe_ard ~ main, 
                      data = df_col1,
                      se_type = "stata")

mod_col2 <- lm_robust(qe_ard ~ control, 
                      data = df_col2,
                      se_type = "stata")

mod_col3 <-lm_robust(qe_ard ~ treatment, 
                     data = df_col3,
                     se_type = "stata")

mod_col4 <-lm_robust(qe_ard ~ treatment, 
                     data = df_col4,
                     se_type = "stata")

models <- list(
    "m1" = mod_col1,
    "m2" = mod_col2, 
    "m3" = mod_col3,
    "m4" = mod_col4
)

modelsummary(models)

# --- Regressions Using OUR measure of d^rel --- #
mod_col1_ours <- lm_robust(d_rel ~ main, 
                      data = df_col1,
                      se_type = "stata")

mod_col2_ours <- lm_robust(d_rel ~ control, 
                      data = df_col2,
                      se_type = "stata")

mod_col3_ours <-lm_robust(d_rel ~ treatment, 
                     data = df_col3,
                     se_type = "stata")

mod_col4_ours <-lm_robust(d_rel ~ treatment, 
                     data = df_col4,
                     se_type = "stata")

models_ours <- list(
    "m1" = mod_col1_ours,
    "m2" = mod_col2_ours, 
    "m3" = mod_col3_ours,
    "m4" = mod_col4_ours
)

modelsummary(models_ours)
