library(dplyr)

# Load the data
Df_raw_93 <- read.csv("_SharedFolder_global_es/data/canada/raw/ces93_RawData_2018-09-16.csv")

# Create clean dataframe
Df_clean_93 <- data.frame(id = 1:nrow(Df_raw_93))
Df_clean_93$year <- 1993
Df_clean_93$country <- "ca"

# Clean ses

source("R/canada/ces_93/ces_93_ses.R")

# Clean values

source("R/canada/ces_93/ces_93_values.R")

# Clean PartyId

source("R/canada/ces_93/ces_93_party_id.R")

# Clean Party_Eval

source("R/canada/ces_93/ces_93_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_93/ces_93_leader_eval.R")

# Clean Vote

source("R/canada/ces_93/ces_93_vote")

# Clean issues

source("R/canada/ces_93/ces_93_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_93.rds")