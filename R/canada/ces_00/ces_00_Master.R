library(dplyr)

# Load the data
Df_raw <- read.csv("_SharedFolder_global_es/data/canada/raw/ces_00.csv")

# Create clean dataframe
Df_clean <- data.frame(id = 1:nrow(Df_raw))

# Clean ses

source("R/canada/ces_00/ces_00_Ses.R")

# Clean values

source("R/canada/ces_00/ces_00_Values.R")

# Clean PartyId

source("R/canada/ces_00/ces_00_Party_Id.R")

# Clean Party_Eval

source("R/canada/ces_00_Party_Eval.R")

# Clean Leader_Eval

source("R/canada/ces_00/ces_00_Leader_Eval.R")

# Clean Vote

source("R/canada/ces_00/ces_Vote")

# Clean issues

source("R/canada/ces_00/ces_00_Issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_00.rds")