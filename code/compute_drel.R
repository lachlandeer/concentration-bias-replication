# compute_drel.R
#
# Compute our own version of relative concentration bias
# from the choice data

# --- libraries --- # 

library(readr)
library(dplyr)

# --- Load Data --- #
df <- read_csv("data/Consumption_Experiment.csv")

# --- we compute the outcomes --- #
# keep only variables we might need for table 2
df <- 
    df %>%
    select(tn, dispersed, session, treatment, pap_sample, control, 
           main, pizza, average_ip, 
           decision_number, utility_point, indifference_point, 
           id_stage2, avg_id_stage2, id_stage2_upper, 
           qe_ard, qe_ard_upper, qe_ard_lower
           )

# mean effort levels reported in the paper, one for each choice task
# these are reported in footnote 3 of the main text
efforts <-
    tibble(
        effort = c(129, 132, 143, 115, 121, 117, 135, 127, NA)
    )

# get a table of subject ids to merge to later
subject_ids <- 
    unique(df$tn) %>%
    as_tibble()

efforts$fake <- 1
subject_ids$fake <- 1

# create a  table that has each of the mean efforts for each subject
cross_join <-
    full_join(subject_ids, efforts, by = "fake") %>%
    select(-fake)

# put the mean efforts into the data
df_outcomes <- cbind(df, cross_join) %>%
    select(-value)
    
# compute mean indifference point per subject
mean_indiff_point <- 
    df_outcomes %>% 
    group_by(tn) %>% 
    filter(decision_number<9) %>% 
    summarise(indiff = mean(indifference_point + effort,
                            na.rm = T
                            )
              )

# get unbalanced choices of subjects:
unbal_choice <-
    df %>%
    filter(decision_number == 9) 

# merge our mean indiff point into the data
unbal_choice <-
    unbal_choice %>%
    inner_join(mean_indiff_point, by = "tn")

# Compute d_rel
unbal_choice <-
    unbal_choice %>%
    mutate(d_rel = avg_id_stage2 / indiff)

# --- save it! --- #
output_dir <- "out_data"

if (!dir.exists(output_dir)){
    dir.create(output_dir)
} else {
    print("Dir already exists!")
}

write_csv(unbal_choice, "out_data/consumption_experiment.csv")
