library(dplyr)

# Load the data
Df_raw <- read.csv("_SharedFolder_global_es/data/canada/raw/data_ces_1965_raw.rds")

# Create clean dataframe
Df_clean <- data.frame(id = 1:nrow(Df_raw))

# Clean ses

source("R/canada/ces_1965/ces_1965_ses.R")

# Clean vote

source("R/canada/ces_1965/ces_1965_vote")

# Clean issues

source("R/canada/ces_1965/ces_1965_issues")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_1965.rds")
