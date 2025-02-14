library(dplyr)

# Load the data
Df_raw_79 <- read.csv("_SharedFolder_global_es/data/canada/raw/ces79_RawData_2018-09-03.csv")

# Create clean dataframe
Df_clean_79 <- data.frame(id = 1:nrow(Df_raw_79))
Df_clean_79$year <- 1979
Df_clean_79$country <- "ca"
# Clean ses

source("R/canada/ces_79/ces_79_ses.R")

# Clean values

source("R/canada/ces_79/ces_79_values.R")

# Clean PartyId

source("R/canada/ces_79/ces_79_party_id.R")

# Clean Party_Eval

source("R/canada/ces_79/ces_79_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_79/ces_79_leader_eval.R")

# Clean Vote

source("R/canada/ces_79/ces_79_vote")

# Clean issues

source("R/canada/ces_79/ces_79_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_79.rds")