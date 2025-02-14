library(dplyr)

# Load the data
Df_raw_74 <- read.csv("_SharedFolder_global_es/data/canada/raw/data_ces_1974-1980_raw.rds")

# Create clean dataframe
Df_clean_74 <- data.frame(id = 1:nrow(Df_raw_74))
Df_clean_74$year <- 1974
Df_clean_74$country <- "ca"

# Clean ses

source("R/canada/ces_74/ces_74_ses.R")

# Clean values

source("R/canada/ces_74/ces_74_values.R")

# Clean PartyId

source("R/canada/ces_74/ces_74_party_id.R")

# Clean Party_Eval

source("R/canada/ces_74/ces_74_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_74/ces_74_leader_eval.R")

# Clean Vote

source("R/canada/ces_74/ces_74_vote")

# Clean issues

source("R/canada/ces_74/ces_74_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_74.rds")
