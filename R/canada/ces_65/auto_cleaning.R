# Survey Data Cleaning Script
# Generated on: 2025-02-19 09:43:38

library(dplyr)

# Load the raw data
df_raw <- readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_1965_raw.rds")

# Initialize clean dataframe
df_clean <- df_raw


# ============================================
# Cleaning for variable: V32
# Original question: MAJORITY GOVERNMENT ISSUE - IMPORTANCE IN ELECTION
# ============================================

 # Create standardized numeric and binary variables for majority govt importance
# Prefix: issue_ for policy/election issues
# Direction: higher = more important

# Numeric version scaled 0-1
df_clean <- df_raw %>%
  mutate(
    # Reverse code and scale to 0-1 (1 = very important)
    issue_majority_importance_num = case_when(
      V32 == 1 ~ 1,      # Very important
      V32 == 2 ~ 0.5,    # Fairly important  
      V32 == 3 ~ 0,      # Not too important
      V32 == 8 ~ NA_real_, # Don't know
      V32 == 9 ~ NA_real_, # Not applicable
      TRUE ~ NA_real_
    )
  )

# Binary versions for each response
df_clean <- df_clean %>%
  mutate(
    issue_majority_veryimp_bin = as.numeric(V32 == 1),
    issue_majority_fairlyimp_bin = as.numeric(V32 == 2), 
    issue_majority_nottooimp_bin = as.numeric(V32 == 3),
    issue_majority_dk_bin = as.numeric(V32 == 8),
    issue_majority_na_bin = as.numeric(V32 == 9)
  ) %>%
  # Set NAs for invalid values
  mutate(across(starts_with("issue_majority"), 
                ~if_else(!V32 %in% c(1,2,3,8,9), NA_real_, .)))
 


# ============================================
# Cleaning for variable: V33
# Original question: STRONG LEADER ISSUE - IMPORTANCE IN ELECTION
# ============================================

 # Create standardized numeric and binary variables for leader importance
library(dplyr)

# Numeric transformation (0-1 scale, 1 = most important)
df_clean <- df_raw %>%
  mutate(
    leader_importance_num = case_when(
      V33 == 1 ~ 1,        # Very important
      V33 == 2 ~ 0.5,      # Fairly important  
      V33 == 3 ~ 0,        # Not too important
      V33 == 8 ~ NA_real_, # Don't know
      V33 == 9 ~ NA_real_, # Not applicable
      TRUE ~ NA_real_
    )
  )

# Binary variables for each response option
df_clean <- df_clean %>%
  mutate(
    leader_importance_very_bin = ifelse(V33 == 1, 1, 0),
    leader_importance_fairly_bin = ifelse(V33 == 2, 1, 0), 
    leader_importance_nottoo_bin = ifelse(V33 == 3, 1, 0),
    leader_importance_dk_bin = ifelse(V33 == 8, 1, 0),
    leader_importance_na_bin = ifelse(V33 == 9, 1, 0)
  )

# Set binary vars to NA if original is NA
df_clean <- df_clean %>%
  mutate(across(starts_with("leader_importance_") & ends_with("_bin"),
                ~ifelse(is.na(V33), NA_real_, .)))
 


# ============================================
# Cleaning for variable: V34
# Original question: GOVERNMENT FORMATION - IMPORTANCE OF MAJORITY PARTY
# ============================================

 # Create standardized numeric version scaled 0-1 (1 = most positive)
df_clean <- df_raw %>%
  mutate(
    issue_majority_importance_num = case_when(
      V34 == 1 ~ 1,        # Great deal
      V34 == 2 ~ 0.5,      # Some
      V34 == 3 ~ 0,        # Not much
      V34 == 8 ~ NA_real_, # Don't know
      V34 == 9 ~ NA_real_, # Not applicable
      TRUE ~ NA_real_
    )
  )

# Create binary indicators for each response
df_clean <- df_clean %>%
  mutate(
    issue_majority_greatdeal_bin = as.numeric(V34 == 1),
    issue_majority_some_bin = as.numeric(V34 == 2), 
    issue_majority_notmuch_bin = as.numeric(V34 == 3)
  ) %>%
  # Set binary vars to NA if original was NA/DK/NA
  mutate(across(ends_with("_bin"), 
                ~ifelse(V34 %in% c(8,9), NA_real_, .)))
 


# ============================================
# Save the cleaned dataset
# ============================================
saveRDS(df_clean, '_SharedFolder_global_es/data/canada/clean/data_ces_1965_clean.rds')

# End of cleaning script
