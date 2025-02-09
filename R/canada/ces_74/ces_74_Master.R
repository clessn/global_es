library(dplyr)

# Load the data
Df_raw <- read.csv("_SharedFolder_global_es/data/canada/raw/ces_74.csv")

# Create clean dataframe
Df_clean <- data.frame(id = 1:nrow(Df_raw))

# Clean ses

source("R/canada/ces_74/ces_74_ses.R")

# Clean vote

source("R/canada/ces_74/ces_74_vote")

# Clean issues

source("R/canada/ces_74/ces_74_issues")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_74.rds")