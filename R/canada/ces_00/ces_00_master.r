library(dplyr)

# Load the data
DataRaw_00 <-readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2000_raw.rds")

# Create clean dataframe
DataClean_00 <- data.frame(id = 1:nrow(DataRaw_00))
DataClean_00$year <- 2000
DataClean_00$country <- "ca"

# Clean ses

source("R/canada/ces_00/ces_00_Ses.R")

# Clean values

source("R/canada/ces_00/ces_00_Values.R")

# Clean PartyId

source("R/canada/ces_00/ces_00_Party_Id.R")

# Clean Party_Eval

source("R/canada/ces_00_Party_Eval.R")

# Clean Leader_Eval

source("R/canada/ces_00/ces_00_Leader_Eval.R")

# Clean Vote

source("R/canada/ces_00/ces_Vote")

# Clean issues

source("R/canada/ces_00/ces_00_Issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_00.rds")
