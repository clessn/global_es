files <- list.files(
  "_SharedFolder_GlobalES/Dashboard/Canada/json_files",
  full.names = TRUE
)

# Parse only non-empty files, handling errors gracefully
json_list <- lapply(files, function(file) {
  tryCatch(
    rjson::fromJSON(file = file),
    error = function(e) NULL # Return NULL if parsing fails
  )
})

unique_source_id_values <- unique(unlist(sapply(json_list, function(json) if (!is.null(json)) names(json$source_id) else NULL)))

unique_source_id_values <- unique_source_id_values[grepl("ces", unique_source_id_values)]

# Create a dataframe with the required structure
result <- do.call(rbind, lapply(unique_source_id_values, function(survey_name) {
  data.frame(
    col1 = basename(files), # File names
    col2 = survey_name, # Survey name
    col3 = sapply(json_list, function(json) {
      if (!is.null(json) && "source_id" %in% names(json) && 
          survey_name %in% names(json$source_id) && 
          "cleaned" %in% names(json$source_id[[survey_name]])) {
        json$source_id[[survey_name]]$cleaned
      } else {
        NA
      }
    }),
    stringsAsFactors = FALSE
  )
}))
