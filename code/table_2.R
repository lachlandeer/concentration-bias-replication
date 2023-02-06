# --- libraries --- # 

library(readr)
library(dplyr)
library(estimatr)
library(AER)
library(modelsummary)


# --- Load Data --- #
df <- read_csv("out_data/consumption_experiment.csv")

# --- Data Filter --- # 
# Filter to keep only the data used by DGRSS
df_tab2 <- 
    df %>%
    filter(treatment == 1, 
           pap_sample == 1,
           dispersed == 0
    )

# --- Regression specifications for "d" ---# 
model_lb <- 
    lm_robust(id_stage2 ~ 1, 
              data = df_tab2, 
              se_type = "stata"
              )

model_mid <- 
    lm_robust(avg_id_stage2 ~ 1, 
              data = df_tab2, 
              se_type = "stata"
              )

model_upper <- 
    lm_robust(id_stage2_upper ~ 1, 
              data = df_tab2, 
              se_type = "stata"
              )

model_tobit <-
    tobit(id_stage2 ~ 1, 
          data = df_tab2, 
          left = -63, 
          right = 63
          )

models <- list(
    "Lower Bound" = model_lb,
    "Midpoint" = model_mid, 
    "Upper Bound" = model_upper,
    "Tobit" = model_tobit
)

modelsummary(models)

#--- Regressions for d^rel ---#
model_lb_rel <- 
    lm_robust(qe_ard_lower ~ 1, 
              data = df_tab2, 
              se_type = "stata"
    )

model_mid_rel <- 
    lm_robust(qe_ard ~ 1, 
              data = df_tab2, 
              se_type = "stata"
    )

# remark: this is our computed version of d^rel
model_computed_rel <- 
    lm_robust(d_rel ~ 1, 
              data = df_tab2, 
              se_type = "stata"
    )

model_upper_rel <- 
    lm_robust(qe_ard_upper ~ 1, 
              data = df_tab2, 
              se_type = "stata"
    )      

models_rel <- list(
    "Lower Bound" = model_lb_rel,
    "Midpoint" = model_mid_rel, 
    "Our Mid" = model_computed_rel,
    "Upper Bound" = model_upper_rel
)

modelsummary(models_rel)
