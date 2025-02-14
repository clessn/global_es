library(dplyr)

# Load the data
Df_raw_65 <- read.csv("_SharedFolder_global_es/data/canada/raw/ces65_RawData_2018-08-28.csv")

# Create clean dataframe
Df_clean_65 <- data.frame(id = 1:nrow(Df_raw_65))

# Clean ses

source("R/canada/ces_65/ces_65_ses.R")

# Clean values

source("R/canada/ces_65/ces_65_values.R")

# Clean PartyId

source("R/canada/ces_65/ces_65_party_id.R")

# Clean Party_Eval

source("R/canada/ces_65/ces_65_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_65/ces_65_leader_eval.R")

# Clean Vote

source("R/canada/ces_65/ces_65_vote")

# Clean issues

source("R/canada/ces_65/ces_65_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_1965.rds")
