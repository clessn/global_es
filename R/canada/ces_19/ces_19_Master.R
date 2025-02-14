library(dplyr)

# Load the data
Df_raw_19 <- read.csv("_SharedFolder_global_es/data/canada/raw/ces19_RawData_2021-07-16.csv")

# Create clean dataframe
Df_clean_19 <- data.frame(id = 1:nrow(Df_raw_19))
Df_clean_19$year <- 2019
Df_clean_19$country <- "ca"

# Clean ses

source("R/canada/ces_19/ces_19_ses.R")

# Clean values

source("R/canada/ces_19/ces_19_values.R")

# Clean PartyId

source("R/canada/ces_19/ces_19_party_id.R")

# Clean Party_Eval

source("R/canada/ces_19/ces_19_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_19/ces_19_leader_eval.R")

# Clean Vote

source("R/canada/ces_19/ces_19_vote")

# Clean issues

source("R/canada/ces_19/ces_19_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_19.rds")