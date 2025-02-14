library(dplyr)

# Load the data
Df_raw_80 <- read.csv("")

# Create clean dataframe
Df_clean_80 <- data.frame(id = 1:nrow(Df_raw_80))
Df_clean_80$year <- 1980
Df_clean_80$country <- "ca"
# Clean ses

source("R/canada/ces_80/ces_80_Ses.R")

# Clean values

source("R/canada/ces_80/ces_80_Values.R")

# Clean PartyId

source("R/canada/ces_80/ces_80_Party_Id.R")

# Clean Party_Eval

source("R/canada/ces_80/ces_80_Party_Eval.R")

# Clean Leader_Eval

source("R/canada/ces_80/ces_80_Leader_Eval.R")

# Clean Vote

source("R/canada/ces_80/ces_80_Vote")

# Clean issues

source("R/canada/ces_80/ces_80_Issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_80.rds")