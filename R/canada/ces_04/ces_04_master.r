library(dplyr)

# Load the data
Df_raw_04 <- read.csv("_SharedFolder_global_es/data/canada/raw/data_ces_2004_raw.rds")

# Create clean dataframe
Df_clean_04 <- data.frame(id = 1:nrow(Df_raw_04))
Df_clean_04$year <- 2004
Df_clean_04$country <- "ca"

# Clean ses

source("R/canada/ces_04/ces_04_ses.R")

# Clean values

source("R/canada/ces_04/ces_04_salues.R")

# Clean PartyId

source("R/canada/ces_04/ces_04_sarty_id.R")

# Clean Party_Eval

source("R/canada/ces_04/ces_04_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_04/ces_04_leader_eval.R")

# Clean Vote

source("R/canada/ces_04/ces_04_vote")

# Clean issues

source("R/canada/ces_04/ces_04_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_04.rds")
