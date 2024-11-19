library(rjson)
library(dplyr)
library(tidyr)


# Specify the path to your JSON file
file_path <- "_SharedFolder_GlobalES/Dashboard/Canada/json_files/ses_lang.json"



mesdonnees <- fromJSON(file = file_path)

df_donnees <- as.data.frame(mesdonnees)


# Liste des variables "ces" à regrouper
ces_variables <- c("ces65", "ces68", "ces74", "ces79", "ces84", "ces88", 
                   "ces93", "ces97", "ces2000", "ces2004", "ces2006", 
                   "ces2008", "ces2011", "ces2015", "ces2019", "ces2021")


# Réorganiser les colonnes pour chaque variable "ces"
reorder_columns <- function(df, ces_vars) {
  for (ces in ces_vars) {
    ces_columns <- paste0("source_id.", ces, c(".class", ".cleaned", ".question_label", ".raw_variable"))
    existing_columns <- intersect(ces_columns, colnames(df))
    df <- df %>% select(all_of(existing_columns), everything())
  }
  return(df)
}

df_donnees <- reorder_columns(df_donnees, ces_variables)

# Convertir toutes les colonnes en caractères
df_donnees <- df_donnees %>% mutate(across(everything(), as.character))

# Pivoter chaque groupe de colonnes CES séparément et ajouter l'année
pivot_and_add_year <- function(df, ces_var) {
  ces_columns <- paste0("source_id.", ces_var, c(".class", ".cleaned", ".question_label", ".raw_variable"))
  df_long <- df %>%
    select(all_of(ces_columns)) %>%
    pivot_longer(cols = everything(), 
                 names_to = "variable", 
                 values_to = "value") %>%
    mutate(année = as.integer(sub("ces", "", ces_var)))
  return(df_long)
}

# Appliquer la fonction à chaque variable CES et combiner les résultats
df_long_combined <- lapply(ces_variables, function(var) pivot_and_add_year(df_donnees, var)) %>%
  bind_rows()

View(df_long_combined)

x/

# Check if the file exists
if (!file.exists(file_path)) {
  stop("File does not exist")
}

# Read the file content
file_content <- readLines(file_path, warn = FALSE)
cat(file_content, sep = "\n")  # Print the file content for debugging

# Parse the JSON content
tryCatch({
  json_data <- fromJSON(paste(file_content, collapse = "\n"))
  df <- as.data.frame(json_data)
  print(df)
  
  # Display the first few rows of the data frame
  print(head(df))
  
  # Display the column names
  print(names(df))
  
  # Display a summary of the data
  print(summary(df))
}, error = function(e) {
  cat("Error: ", e$message, "\n")
})