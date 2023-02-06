# plot_drel.R
#
# Plot comparisons between our version of drel (relative concentration bias)
# and those of the original study

library(ggplot2)
library(readr)
library(dplyr)

# --- Load Data ---# 
df <- read_csv("out_data/consumption_experiment.csv")

# --- Place to save plots --- # 
output_dir <- "out_figs"

if (!dir.exists(output_dir)){
    dir.create(output_dir)
} else {
    print("Dir already exists!")
}

# --- Plot Our Computed d_rel vs Authors for TABLE 2 --- # 
df %>%
    filter(treatment == 1, 
           pap_sample == 1,
           dispersed == 0
    ) %>%
    ggplot()+
    geom_point(aes(x = qe_ard,
                   y = d_rel),
               size = 2,
               alpha = 0.33
    )  +
    geom_abline(intercept = 0, 
                slope = 1, 
                size = 1, 
                color = "red",
                linetype = "dashed"
    ) +
    theme_bw() + 
    theme(text = element_text(size = 24)) +
    xlab("Authors Original Values") + 
    ylab("Calculated Values")

# Save it 
ggsave("out_figs/d_rel_tab2.pdf")

# --- Plot Our Computed d_rel vs Authors for TABLE 3 Col 1 --- # 
df %>%
    filter(treatment == 1, pap_sample == 1
        ) %>%
    ggplot()+
    geom_point(aes(x = qe_ard,
                   y = d_rel),
               size = 2,
               alpha = 0.33
    )  +
    geom_abline(intercept = 0, 
                slope = 1, 
                size = 1, 
                color = "red",
                linetype = "dashed"
    ) +
    theme_bw() + 
    theme(text = element_text(size = 24)) +
    xlab("Authors Original Values") + 
    ylab("Calculated Values")

ggsave("out_figs/d_rel_tab3_col1.pdf")


# --- Plot Our Computed d_rel vs Authors for TABLE 3 Col 2 --- # 
df %>%
    filter(pizza == 0, pap_sample == 1) %>%
    ggplot()+
    geom_point(aes(x = qe_ard,
                   y = d_rel),
               size = 2,
               alpha = 0.33
    )  +
    geom_abline(intercept = 0, 
                slope = 1, 
                size = 1, 
                color = "red",
                linetype = "dashed"
    ) +
    theme_bw() + 
    theme(text = element_text(size = 24)) +
    xlab("Authors Original Values") + 
    ylab("Calculated Values")

ggsave("out_figs/d_rel_tab3_col2.pdf")

# --- Plot Our Computed d_rel vs Authors for TABLE 3 Col 3 --- # 
df %>%
    filter(pap_sample == 1, pizza == 1 , dispersed == 0) %>%
    ggplot()+
    geom_point(aes(x = qe_ard,
                   y = d_rel),
               size = 2,
               alpha = 0.33
    )  +
    geom_abline(intercept = 0, 
                slope = 1, 
                size = 1, 
                color = "red",
                linetype = "dashed"
    ) +
    theme_bw() + 
    theme(text = element_text(size = 24)) +
    xlab("Authors Original Values") + 
    ylab("Calculated Values")

ggsave("out_figs/d_rel_tab3_col3.pdf")

# --- Plot Our Computed d_rel vs Authors for TABLE 3 Col 4 --- # 
df %>%
    filter(pap_sample == 1, pizza == 1 , dispersed == 1) %>%
    ggplot()+
    geom_point(aes(x = qe_ard,
                   y = d_rel),
               size = 2,
               alpha = 0.33
    )  +
    geom_abline(intercept = 0, 
                slope = 1, 
                size = 1, 
                color = "red",
                linetype = "dashed"
    ) +
    theme_bw() +     
    theme(text = element_text(size = 24)) +
    xlab("Authors Original Values") + 
    ylab("Calculated Values")

ggsave("out_figs/d_rel_tab3_col4.pdf")
