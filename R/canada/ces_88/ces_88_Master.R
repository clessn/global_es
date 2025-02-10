library(dplyr)

# Load the data
Df_raw <- read.csv("_SharedFolder_global_es/data/canada/raw/ces_88.csv")

# Create clean dataframe
Df_clean <- data.frame(id = 1:nrow(Df_raw))

# Clean ses

source("R/canada/ces_88/ces_88_Ses.R")

# Clean values

source("R/canada/ces_88/ces_88_Values.R")

# Clean PartyId

source("R/canada/ces_88/ces_88_Party_Id.R")

# Clean Party_Eval

source("R/canada/ces_88/ces_88_Party_Eval.R")

# Clean Leader_Eval

source("R/canada/ces_88/ces_88_Leader_Eval.R")

# Clean Vote

source("R/canada/ces_88/ces_88_Vote")

# Clean issues

source("R/canada/ces_88/ces_88_Issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_88.rds")