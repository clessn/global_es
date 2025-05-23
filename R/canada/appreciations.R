library(tidyr)
library(dplyr)

# Load 2019 data
DataRaw_19 <- readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2019_raw.rds") %>%
  select(
    starts_with("pes19_lead_rate"),
    starts_with("cps19_lead_rating")
  )

# Filter 2019 data
df_2019_pes <- DataRaw_19 %>%
  filter(
    !is.na(pes19_lead_rate_7) | # Andrew Scheer
    !is.na(pes19_lead_rate_8) | # Justin Trudeau
    !is.na(pes19_lead_rate_9)   # Jagmeet Singh 
  )

df_2019_cps <- DataRaw_19 %>%
  filter(
    !is.na(cps19_lead_rating_23) | # Justin Trudeau
    !is.na(cps19_lead_rating_24) | # Andrew Scheer
    !is.na(cps19_lead_rating_25)   # Jagmeet Singh
  )

# Process the 2019 PES data with scale adjustment (0-10 to 0-100)
df_2019_pes_avg <- df_2019_pes %>%
  # Create a row-wise mean for each politician
  mutate(
    scheer_rating = pes19_lead_rate_7 * 10,  # Scale from 0-10 to 0-100
    trudeau_rating = pes19_lead_rate_8 * 10, # Scale from 0-10 to 0-100
    singh_rating = pes19_lead_rate_9 * 10    # Scale from 0-10 to 0-100
  ) %>%
  # Select only the calculated columns
  select(scheer_rating, trudeau_rating, singh_rating) %>%
  # Calculate means ignoring NA values
  summarise(
    scheer_avg = mean(scheer_rating, na.rm = TRUE),
    trudeau_avg = mean(trudeau_rating, na.rm = TRUE),
    singh_avg = mean(singh_rating, na.rm = TRUE)
  )

# Process the 2019 CPS data (already on 0-100 scale)
df_2019_cps_avg <- df_2019_cps %>%
  mutate(
    trudeau_rating = cps19_lead_rating_23,
    scheer_rating = cps19_lead_rating_24,
    singh_rating = cps19_lead_rating_25
  ) %>%
  select(trudeau_rating, scheer_rating, singh_rating) %>%
  summarise(
    trudeau_avg = mean(trudeau_rating, na.rm = TRUE),
    scheer_avg = mean(scheer_rating, na.rm = TRUE),
    singh_avg = mean(singh_rating, na.rm = TRUE)
  )

# Convert to long format for ease of merging
pes_long <- df_2019_pes_avg %>%
  pivot_longer(cols = everything(),
               names_to = "leader",
               values_to = "pes_rating") %>%
  mutate(leader = sub("_avg", "", leader))

cps_long <- df_2019_cps_avg %>%
  pivot_longer(cols = everything(),
               names_to = "leader",
               values_to = "cps_rating") %>%
  mutate(leader = sub("_avg", "", leader))

# Merge 2019 PES and CPS data
df_2019_final_ratings <- full_join(pes_long, cps_long, by = "leader") %>%
  # Calculate the average rating across both surveys
  mutate(
    # Count how many non-NA values we have for each leader
    rating_count = (!is.na(pes_rating)) + (!is.na(cps_rating)),
    
    # Calculate the mean (handling cases where one might be NA)
    final_rating = case_when(
      rating_count == 2 ~ (pes_rating + cps_rating) / 2,
      !is.na(pes_rating) ~ pes_rating,
      !is.na(cps_rating) ~ cps_rating,
      TRUE ~ NA_real_
    )
  ) %>%
  # Clean up leader names
  mutate(
    leader_name = case_when(
      leader == "trudeau" ~ "Justin Trudeau",
      leader == "scheer" ~ "Andrew Scheer",
      leader == "singh" ~ "Jagmeet Singh",
      TRUE ~ leader
    ),
    year = 2019
  ) %>%
  # Select and arrange final data
  select(year, leader_name, pes_rating, cps_rating, final_rating) %>%
  arrange(desc(final_rating))

# Load and process 2021 data
DataRaw_21 <- readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2021_raw.rds") %>%
  select(
    starts_with("cps21_lead_rating")
  )

df_2021_cps <- DataRaw_21 %>%
  filter(
    !is.na(cps21_lead_rating_23) | # Justin Trudeau
    !is.na(cps21_lead_rating_24) | # Erin O'Toole
    !is.na(cps21_lead_rating_25)   # Jagmeet Singh
  )

# Process the 2021 CPS data (already on 0-100 scale)
df_2021_cps_avg <- df_2021_cps %>%
  mutate(
    trudeau_rating = cps21_lead_rating_23,
    otoole_rating = cps21_lead_rating_24,
    singh_rating = cps21_lead_rating_25
  ) %>%
  select(trudeau_rating, otoole_rating, singh_rating) %>%
  summarise(
    trudeau_avg = mean(trudeau_rating, na.rm = TRUE),
    otoole_avg = mean(otoole_rating, na.rm = TRUE),
    singh_avg = mean(singh_rating, na.rm = TRUE)
  )

# Convert to long format
cps_2021_long <- df_2021_cps_avg %>%
  pivot_longer(cols = everything(),
               names_to = "leader",
               values_to = "cps_rating") %>%
  mutate(leader = sub("_avg", "", leader))

# For 2021, since we only have CPS data, the final rating is the same as the CPS rating
df_2021_final_ratings <- cps_2021_long %>%
  # Use CPS rating as the final rating
  mutate(
    final_rating = cps_rating,
    
    # Clean up leader names
    leader_name = case_when(
      leader == "trudeau" ~ "Justin Trudeau",
      leader == "otoole" ~ "Erin O'Toole",
      leader == "singh" ~ "Jagmeet Singh",
      TRUE ~ leader
    ),
    
    # Add year identifier
    year = 2021,
    
    # Add NA for pes_rating since it doesn't exist for 2021
    pes_rating = NA_real_
  ) %>%
  # Select and arrange final data
  select(year, leader_name, pes_rating, cps_rating, final_rating) %>%
  arrange(desc(final_rating))

# Create combined dataset with both years
df_combined_ratings <- bind_rows(
  df_2019_final_ratings,
  df_2021_final_ratings
) %>%
  arrange(year, desc(final_rating))

# View the combined results
print(df_combined_ratings)
