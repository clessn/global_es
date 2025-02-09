library(dplyr)

# Load the data
Df_raw <- read.csv("_SharedFolder_global_es/data/canada/raw/ces_1968.csv")

# Create clean dataframe
Df_clean <- data.frame(id = 1:nrow(Df_raw))

# Clean ses

source("R/canada/ces_1968/ces_1968_ses.R")

# Clean vote

source("R/canada/ces_1968/ces_1968_vote")

# Clean issues

source("R/canada/ces_1968/ces_1968_issues")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_1968.rds")