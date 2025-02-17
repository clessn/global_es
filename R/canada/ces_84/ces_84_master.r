library(dplyr)

# Load the data
Df_raw_84 <- read.csv("_SharedFolder_global_es/data/canada/raw/data_ces_1984_raw.rds")

# Create clean dataframe
Df_clean_84 <- data.frame(id = 1:nrow(Df_raw_84))
Df_clean_84$year <- 1984
Df_clean_84$country <- "ca"

# Clean ses

source("R/canada/ces_84/ces_84_ses.R")

# Clean values

source("R/canada/ces_84/ces_84_values.R")

# Clean PartyId

source("R/canada/ces_84/ces_84_party_id.R")

# Clean Party_Eval

source("R/canada/ces_84/ces_84_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_84/ces_84_leader_eval.R")

# Clean Vote

source("R/canada/ces_84/ces_84_vote")

# Clean issues

source("R/canada/ces_84/ces_84_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_84.rds")
