library(haven)
library(readr)

# Define years with corresponding URLs and reading methods
years <- c("1965", "1968", "1974-1980", "1984", "1988", "1993", "1997",
           "2000", "2004", "2006", "2008", "2011", "2015", "2019", "2021")

urls <- c(
  # SPSS files
  "https://borealisdata.ca/api/access/datafile/563651",
  "https://borealisdata.ca/api/access/datafile/563469",
  "https://borealisdata.ca/api/access/datafile/563390",
  "https://borealisdata.ca/api/access/datafile/563500",
  "https://borealisdata.ca/api/access/datafile/563590",
  "https://borealisdata.ca/api/access/datafile/563806",
  "https://borealisdata.ca/api/access/datafile/563617",
  "https://borealisdata.ca/api/access/datafile/563672",
  "https://borealisdata.ca/api/access/datafile/563592",
  "https://borealisdata.ca/api/access/datafile/563752",
  "https://borealisdata.ca/api/access/datafile/563439",
  "https://borealisdata.ca/api/access/datafile/563961",
  # CSV files
  "https://borealisdata.ca/api/access/datafile/563945",
  "https://borealisdata.ca/api/access/datafile/564211",
  "https://borealisdata.ca/api/access/datafile/658988"
)

# Create output directory
output_dir <- "_SharedFolder_global_es/data/canada/raw"
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Process each dataset
for (i in seq_along(years)) {
  year <- years[i]
  url <- urls[i]
  
  # Select appropriate reader
  if (year == "2019") {
    ces_data <- read.csv(url)
  } else if (year %in% c("2015", "2021")) {
    ces_data <- read_csv(url)
  } else {
    ces_data <- read_sav(url)
  }
  
  # Save as RDS
  filename <- paste0("data_ces_", year, "_raw.rds")
  save_path <- file.path(output_dir, filename)
  saveRDS(ces_data, save_path)
  
  message("Successfully processed: ", year)
}

message("\nAll CES datasets downloaded and saved successfully! 谢谢! 🎉")
