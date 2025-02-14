library(dplyr)

# Load the data
Df_raw_97 <- read.csv("_SharedFolder_global_es/data/canada/raw/data_ces_1997_raw.rds")

# Create clean dataframe
Df_clean_97 <- data.frame(id = 1:nrow(Df_raw_97))
Df_clean_97$year <- 1997
Df_clean_97$country <- "ca"

# Clean ses

source("R/canada/ces_97/ces_97_ses.R")

# Clean values

source("R/canada/ces_97/ces_97_values.R")

# Clean PartyId

source("R/canada/ces_97/ces_97_party_id.R")

# Clean Party_Eval

source("R/canada/ces_97/ces_97_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_97/ces_97_leader_eval.R")

# Clean Vote

source("R/canada/ces_97/ces_97_vote")

# Clean issues

source("R/canada/ces_97/ces_97_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_97.rds")
