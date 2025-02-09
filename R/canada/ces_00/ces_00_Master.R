library(dplyr)

# Load the data
Df_raw <- read.csv("_SharedFolder_global_es/data/canada/raw/ces_00.csv")

# Create clean dataframe
Df_clean <- data.frame(id = 1:nrow(Df_raw))

# Clean ses

source("R/canada/ces_00/ces_00_Ses.R")

# Clean vote

source("R/canada/ces_00/ces_80_Vote")

# Clean issues

source("R/canada/ces_00/ces_80_Issues")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_00.rds")