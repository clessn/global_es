library(dplyr)

# Load the data
Df_raw_15 <- read.csv("_SharedFolder_global_es/data/canada/raw/ces15_RawData_2018-10-18.csv")

# Create clean dataframe
Df_clean_15 <- data.frame(id = 1:nrow(Df_raw_15))
Df_clean_15$year <- 2015
Df_clean_15$country <- "ca"

# Clean ses

source("R/canada/ces_15/ces_15_ses.R")

# Clean values

source("R/canada/ces_15/ces_15_values.R")

# Clean PartyId

source("R/canada/ces_15/ces_15_party_id.R")

# Clean Party_Eval

source("R/canada/ces_15/ces_15_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_15/ces_15_leader_eval.R")

# Clean Vote

source("R/canada/ces_15/ces_15_vote")

# Clean issues

source("R/canada/ces_15/ces_15_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_15.rds")