library(dplyr)

# Load the data
Df_raw_88 <- read.csv("_SharedFolder_global_es/data/canada/raw/ces88_RawData_2018-09-03.csv")

# Create clean dataframe
Df_clean_88 <- data.frame(id = 1:nrow(Df_raw_88))
Df_clean_88$year <- 1988
Df_clean_88$country <- "ca"

# Clean ses

source("R/canada/ces_88/ces_88_ses.R")

# Clean values

source("R/canada/ces_88/ces_88_values.R")

# Clean PartyId

source("R/canada/ces_88/ces_88_party_id.R")

# Clean Party_Eval

source("R/canada/ces_88/ces_88_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_88/ces_88_leader_eval.R")

# Clean Vote

source("R/canada/ces_88/ces_88_vote")

# Clean issues

source("R/canada/ces_88/ces_88_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_88.rds")