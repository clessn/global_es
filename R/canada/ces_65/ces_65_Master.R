library(dplyr)

# Load the data
Df_raw <- read.csv("_SharedFolder_global_es/data/canada/raw/ces_1965.csv")

# Create clean dataframe
Df_clean <- data.frame(id = 1:nrow(Df_raw))

# Clean ses

source("R/canada/ces_65/ces_65_Ses.R")

# Clean values

source("R/canada/ces_65/ces_65_Values.R")

# Clean PartyId

source("R/canada/ces_65/ces_65_Party_Id.R")

# Clean Party_Eval

source("R/canada/ces_65/ces_65_Party_Eval.R")

# Clean Leader_Eval

source("R/canada/ces_65/ces_65_Leader_Eval.R")

# Clean Vote

source("R/canada/ces_65/ces_65_Vote")

# Clean issues

source("R/canada/ces_65/ces_65_Issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_1965.rds")
