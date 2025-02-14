library(dplyr)

# Load the data
Df_raw_21 <- read.csv("_SharedFolder_global_es/data/canada/raw/ces2021.csv", 
                      fileEncoding = "latin1")

# Create clean dataframe
Df_clean_21 <- data.frame(id = 1:nrow(Df_raw_21))
Df_clean_21$year <- 2021
Df_clean_21$country <- "ca"

# Clean ses

source("R/canada/ces_21/ces_21_ses.R")

# Clean values

source("R/canada/ces_21/ces_21_values.R")

# Clean PartyId

source("R/canada/ces_21/ces_21_party_id.R")

# Clean Party_Eval

source("R/canada/ces_21/ces_21_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_21/ces_21_leader_eval.R")

# Clean Vote

source("R/canada/ces_21/ces_21_vote")

# Clean issues

source("R/canada/ces_21/ces_21_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_21.rds")