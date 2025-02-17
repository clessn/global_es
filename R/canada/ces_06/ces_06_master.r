library(dplyr)

# Load the data
<<<<<<< HEAD:R/canada/ces_06/ces_06_Master.R
DataRaw_06 <- read.csv("_SharedFolder_global_es/data/canada/raw/ces06_RawData_2018-11-05.csv")
=======
Df_raw_06 <- read.csv("_SharedFolder_global_es/data/canada/raw/data_ces_2006_raw.rds")
>>>>>>> 5e9f9944b2bc2e433377ca7896978fc32e51eacf:R/canada/ces_06/ces_06_master.r

# Create clean dataframe
DataClean_06 <- data.frame(id = 1:nrow(DataRaw_06))
DataClean_06$year <- 2006
DataClean_06$country <- "ca"

# Clean ses

source("R/canada/ces_06/ces_06_ses.R")

# Clean values

source("R/canada/ces_06/ces_06_values.R")

# Clean PartyId

source("R/canada/ces_06/ces_06_party_id.R")

# Clean Party_Eval

source("R/canada/ces_06/ces_06_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_06/ces_06_leader_eval.R")

# Clean Vote

source("R/canada/ces_06/ces_06_vote")

# Clean issues

source("R/canada/ces_06/ces_06_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_06.rds")
