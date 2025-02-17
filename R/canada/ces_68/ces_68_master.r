library(dplyr)

# Load the data
<<<<<<< HEAD:R/canada/ces_68/ces_68_Master.R
DataRaw_68 <- read.csv("_SharedFolder_global_es/data/canada/raw/ces68_RawData_2018-08-28.csv")
=======
Df_raw_68 <- read.csv("_SharedFolder_global_es/data/canada/raw/data_ces_1968_raw.rds")
>>>>>>> 5e9f9944b2bc2e433377ca7896978fc32e51eacf:R/canada/ces_68/ces_68_master.r

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
