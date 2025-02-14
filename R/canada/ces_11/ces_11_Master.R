library(dplyr)

# Load the data
Df_raw_11 <- read.csv("_SharedFolder_global_es/data/canada/raw/ces11_RawData_2018-10-13.csv")

# Create clean dataframe
Df_clean_11 <- data.frame(id = 1:nrow(Df_raw_11))
Df_clean_11$year <- 2011
Df_clean_11$country <- "ca"

# Clean ses

source("R/canada/ces_11/ces_11_ses.R")

# Clean values

source("R/canada/ces_11/ces_11_values.R")

# Clean PartyId

source("R/canada/ces_11/ces_11_party_id.R")

# Clean Party_Eval

source("R/canada/ces_11/ces_11_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_11/ces_11_leader_eval.R")

# Clean Vote

source("R/canada/ces_11/ces_11_vote")

# Clean issues

source("R/canada/ces_11/ces_11_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_11.rds")