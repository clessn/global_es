library(dplyr)

# Load the data
Df_raw <- read.csv("_SharedFolder_global_es/data/canada/raw/ces_93.csv")

# Create clean dataframe
Df_clean <- data.frame(id = 1:nrow(Df_raw))

# Clean ses

source("R/canada/ces_93/ces_93_Ses.R")

# Clean vote

source("R/canada/ces_93/ces_93_Vote")

# Clean issues

source("R/canada/ces_93/ces_93_Issues")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_93.rds")