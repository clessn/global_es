library(dplyr)

# Load the data
DataRaw_68 <- read.csv("_SharedFolder_global_es/data/canada/raw/ces68_RawData_2018-08-28.csv")

# Create clean dataframe
DataClean_68 <- data.frame(id = 1:nrow(DataRaw_68))
DataClean_68$year <- 1968
DataClean_68$country <- "ca"

# Clean ses

source("R/canada/ces_68/ces_68_ses.R")

# Clean values

source("R/canada/ces_68/ces_68_values.R")

# Clean PartyId

source("R/canada/ces_68/ces_68_party_id.R")

# Clean Party_Eval

source("R/canada/ces_68/ces_68_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_68/ces_68_leader_eval.R")

# Clean Vote

source("R/canada/ces_68/ces_68_vote")

# Clean issues

source("R/canada/ces_68/ces_68_issues.R")

# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_1968.rds")