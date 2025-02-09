library(dplyr)

# Load the data
Df_raw <- read.csv("_SharedFolder_global_es/data/canada/raw/ces_19.csv")

# Create clean dataframe
Df_clean <- data.frame(id = 1:nrow(Df_raw))

# Clean ses

source("R/canada/ces_19/ces_19_Ses.R")

# Clean vote

source("R/canada/ces_19/ces_19_Vote")

# Clean issues

source("R/canada/ces_19/ces_19_Issues")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_19.rds")