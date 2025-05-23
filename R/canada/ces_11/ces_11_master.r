library(dplyr)

# Load the data
Data_raw_11 <- readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2011_raw.rds")

codebook <- sondr::sav_to_codebook(DataRaw_11)
doc <- sondr::codebook_to_qmd(codebook, "_SharedFolder_global_es/docs/codebooks/canada/ces_2011.qmd", "Canadian Election Study 2011")

# Create clean dataframe
Data_clean_11 <- data.frame(id = 1:nrow(DataRaw_11))
Data_clean_11$year <- 2011
Data_clean_11$country <- "ca"

# Clean ses

source("R/canada/ces_11/ces_11_ses.R")

# Clean values

source("R/canada/ces_11/ces_11_values.R")

# Clean PartyId

source("R/canada/ces_11/ces_11_party_id.R")

# Clean Party_Eval

source("R/canada/ces_11/ces_11_party_eval.R")

# Clean Leader_Eval

source("R/canada/ces_11/ces_11_leader_eval.R")

# Clean Vote

source("R/canada/ces_11/ces_11_vote")

# Clean issues

source("R/canada/ces_11/ces_11_issues.R")


# Save data
saveRDS(Df_clean, "_SharedFolder_global_es/data/canada/clean/ces_11.rds")
