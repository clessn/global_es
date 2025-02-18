library(dplyr)

# Load the data
DataRaw_08 <- readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2008_raw.rds")

# Create clean dataframe
DataClean_08 <- data.frame(id = 1:nrow(DataRaw_08))
DataClean_08$year <- 2008
DataClean_08$country <- "ca"

# Clean ses

source("R/canada/ces_08/ces_08_ses.R")

# Clean values

source("R/canada/ces_08/ces_08_values.R")

# Clean PartyId

source("R/canada/ces_08/ces_08_party_id.R")

# Clean Party_Eval

source("R/canada/ces_08/ces_08_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_08/ces_08_leader_eval.R")

# Clean Vote

source("R/canada/ces_08/ces_08_vote")

# Clean issues

source("R/canada/ces_08/ces_08_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_08.rds")
