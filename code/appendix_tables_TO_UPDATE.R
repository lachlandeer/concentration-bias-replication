# --- Corner Choices? --- #
# Appendix A.4
model_lb_rel_corner <- 
    lm_robust(qe_rad_lower ~ 1, 
              data = df_tab2, 
              se_type = "stata"
    )

model_mid_rel_corner <- 
    lm_robust(qe_rad ~ 1, 
              data = df_tab2, 
              se_type = "stata"
    )

model_upper_rel_corner <- 
    lm_robust(qe_rad_upper ~ 1, 
              data = df_tab2, 
              se_type = "stata"
    )      

models_rel_corner <- list(
    "Lower Bound" = model_lb_rel_corner,
    "Midpoint" = model_mid_rel_corner, 
    "Upper Bound" = model_upper_rel_corner
)

modelsummary(models_rel_corner)

# --- Include Excluded Subjects --- # 
df_tab2_app <- 
    df %>%
    filter(treatment == 1, 
           dispersed == 0
    )

model_lb_ext <- 
    lm_robust(id_stage2 ~ 1, 
              data = df_tab2_app, 
              se_type = "stata"
    )

model_mid_ext <- 
    lm_robust(avg_id_stage2 ~ 1, 
              data = df_tab2_app, 
              se_type = "stata"
    )

model_upper_ext <- 
    lm_robust(id_stage2_upper ~ 1, 
              data = df_tab2_app, 
              se_type = "stata"
    )

model_tobit_ext <-
    tobit(id_stage2 ~ 1, 
          data = df_tab2_app, 
          left = -63, 
          right = 63
    )

models_ext <- list(
    "Lower Bound" = model_lb_ext,
    "Midpoint" = model_mid_ext, 
    "Upper Bound" = model_upper_ext,
    "Tobit" = model_tobit_ext
)

modelsummary(models_ext)

# d rel
model_lb_rel_ext <- 
    lm_robust(qe_ard_lower ~ 1, 
              data = df_tab2_app, 
              se_type = "stata"
    )

model_mid_rel_ext <- 
    lm_robust(qe_ard ~ 1, 
              data = df_tab2_app, 
              se_type = "stata"
    )

model_upper_rel_ext <- 
    lm_robust(qe_ard_upper ~ 1, 
              data = df_tab2_app, 
              se_type = "stata"
    )      

models_rel_ext <- list(
    "Lower Bound" = model_lb_rel_ext,
    "Midpoint" = model_mid_rel_ext, 
    "Upper Bound" = model_upper_rel_ext
)

modelsummary(models_rel_ext)


# --- Appendix table A1 --- #

model_mid_age <- 
    lm_robust(qe_ard ~ 1 + as.factor(age), 
              #fixed_effects = ~ as.factor(age),
              data = df_tab2, 
              se_type = "stata"
    )

model_mid_fe <- 
    lm_robust(qe_ard ~ 1 + 
                  d_a0_main_tr + d_a1_main_tr + d_a2_main_tr +
                  d_g0_main_tr + d_g1_main_tr + d_g2_main_tr + 
                  d_d1_main_tr + d_d2_main_tr + d_d3_main_tr + d_d4_main_tr + d_d5_main_tr +
                  d_t1_main_tr + d_t2_main_tr + d_t3_main_tr + d_t4_main_tr, 
              #fixed_effects = ~ as.factor(age),
              data = df_tab2, 
              se_type = "stata"
    )

summary(model_mid_fe)

model_mid_fe_rt <- 
    lm_robust(qe_ard ~ 1 + 
                  std_rt_2_main_tr + 
                  d_a0_main_tr + d_a1_main_tr + d_a2_main_tr +
                  d_g0_main_tr + d_g1_main_tr + d_g2_main_tr + 
                  d_d1_main_tr + d_d2_main_tr + d_d3_main_tr + d_d4_main_tr + d_d5_main_tr +
                  d_t1_main_tr + d_t2_main_tr + d_t3_main_tr + d_t4_main_tr, 
              #fixed_effects = ~ as.factor(age),
              data = df_tab2, 
              se_type = "stata"
    )

model_mid_fe_math <- 
    lm_robust(qe_ard ~ 1 + 
                  std_math_main_tr +
                  d_a0_main_tr + d_a1_main_tr + d_a2_main_tr +
                  d_g0_main_tr + d_g1_main_tr + d_g2_main_tr + 
                  d_d1_main_tr + d_d2_main_tr + d_d3_main_tr + d_d4_main_tr + d_d5_main_tr +
                  d_t1_main_tr + d_t2_main_tr + d_t3_main_tr + d_t4_main_tr, 
              #fixed_effects = ~ as.factor(age),
              data = df_tab2, 
              se_type = "stata"
    )

model_mid_fe_crt <- 
    lm_robust(qe_ard ~ 1 + 
                  std_crt_main_tr + 
                  d_a0_main_tr + d_a1_main_tr + d_a2_main_tr +
                  d_g0_main_tr + d_g1_main_tr + d_g2_main_tr + 
                  d_d1_main_tr + d_d2_main_tr + d_d3_main_tr + d_d4_main_tr + d_d5_main_tr +
                  d_t1_main_tr + d_t2_main_tr + d_t3_main_tr + d_t4_main_tr, 
              #fixed_effects = ~ as.factor(age),
              data = df_tab2, 
              se_type = "stata"
    )

model_mid_fe_raven <- 
    lm_robust(qe_ard ~ 1 + 
                  std_raven_main_tr + 
                  d_a0_main_tr + d_a1_main_tr + d_a2_main_tr +
                  d_g0_main_tr + d_g1_main_tr + d_g2_main_tr + 
                  d_d1_main_tr + d_d2_main_tr + d_d3_main_tr + d_d4_main_tr + d_d5_main_tr +
                  d_t1_main_tr + d_t2_main_tr + d_t3_main_tr + d_t4_main_tr, 
              #fixed_effects = ~ as.factor(age),
              data = df_tab2, 
              se_type = "stata"
    )

model_mid_fe_all <- 
    lm_robust(qe_ard ~ 1 + 
                  std_rt_2_main_tr + std_math_main_tr + std_crt_main_tr + std_raven_main_tr + 
                  as.factor(d_a0_main_tr) + as.factor(d_a1_main_tr) + as.factor(d_a2_main_tr) +
                  as.factor(d_g0_main_tr) + as.factor(d_g1_main_tr) + as.factor(d_g2_main_tr) + 
                  as.factor(d_d1_main_tr) + as.factor(d_d2_main_tr) + as.factor(d_d3_main_tr) + as.factor(d_d4_main_tr) + d_d5_main_tr +
                  as.factor(d_t1_main_tr) + as.factor(d_t2_main_tr) + as.factor(d_t3_main_tr) + as.factor(d_t4_main_tr), 
              #fixed_effects = ~ as.factor(age),
              data = df_tab2, 
              se_type = "stata"
    )

summary(model_mid_fe_all)

models_rel_fe <- list(
    model_mid_fe,
    model_mid_fe_rt,
    model_mid_fe_math,
    model_mid_fe_crt,
    model_mid_fe_raven,
    model_mid_fe_all
)

modelsummary(models_rel_fe)


