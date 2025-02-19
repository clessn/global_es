library(dplyr)
library(claudeR)

# Load the data
df <- readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_1965_raw.rds")
codebook <- sondr::sav_to_codebook(df)

# Initialize cleaning script with header and setup code
cleaning_header <- '# Survey Data Cleaning Script
# Generated on: %s

library(dplyr)

# Load the raw data
df_raw <- readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_1965_raw.rds")

# Initialize clean dataframe
df_clean <- df_raw

'

# Create the cleaning file with header
cat(sprintf(cleaning_header, Sys.time()), 
    file = "R/canada/ces_65/auto_cleaning.R")

# Function to clean Claude's response
clean_response <- function(response) {
  # Remove markdown R code indicators
  response <- gsub("```r\n", "", response)
  response <- gsub("```", "", response)
  return(response)
}

# Process the first 3 variables
for(i in 35:37) {
  tryCatch({
    # Progress message
    cat(sprintf("\nProcessing variable %d of 3: %s\n", 
                i, codebook$variable_name[i]))
    
    # Get variable information
    raw_variable <- codebook$variable_name[i]
    raw_label <- codebook$question[i]
    raw_choices <- codebook$answers[i]
    table_output <- table(get(raw_variable, df))
    
    # Create the content for the API call
    content <- sprintf('You are a data cleaning expert who specializes in survey data standardization in R.

Raw survey variable details:
- Variable name: %s
- Question text: %s
- Response choices: %s
- Value distribution: 
%s

Task: Generate R code to create standardized variables following these rules:

1. Variable type determination:
   - Numeric (0-1 scaled) for: Likert scales, ordinal rankings, percentages
   - Binary dummies for: Multiple categories, nominal data, yes/no

2. Numeric variables (_num suffix):
   - Scale to 0-1 range (1 = most positive)
   - Handle non-numeric entries
   
3. Binary variables (_bin suffix):
   - One dummy per response option
   - Use exact string matching
   - Format: prefix_description_value_bin

4. Naming conventions:
   - Prefixes: ses/issue/lifestyle/vote/leader/party
   - Descriptive lowercase names showing direction
   
5. Required handling:
   - NAs and missing values
   - Original order preservation
   - Exact string matching
   - Explanatory comments

Generate dplyr code that:
1. Takes df_raw$%s as input
2. Creates new df_clean columns
3. Processes all observed values
4. Uses strict naming rules

Output R code with comments only, no explanations.', 
    raw_variable, raw_label, raw_choices, 
    paste(capture.output(table_output), collapse="\n"), 
    raw_variable)
    
    # Format the prompt
    prompt <- list(
      list(
        role = "user",
        content = content
      )
    )
    
    # Get response from Claude
    response <- claudeR::claudeR(
      prompt = prompt,
      model = "claude-3-5-sonnet-20241022",
      max_tokens = 8000
    )
    
    # Clean the response
    cleaned_code <- clean_response(response)
    
    # Validate the R code syntax
    tryCatch({
      parse(text = cleaned_code)
      
      # If code parsing succeeds, write to file with proper formatting
      cat(sprintf("\n# ============================================
# Cleaning for variable: %s
# Original question: %s
# ============================================\n\n", 
                  raw_variable, raw_label),
          cleaned_code,
          "\n\n",
          file = "R/canada/ces_65/auto_cleaning.R",
          append = TRUE)
      
      cat("Successfully processed and wrote code for:", raw_variable, "\n")
      
    }, error = function(e) {
      cat("\n# ERROR: Invalid R code generated for variable:", raw_variable, 
          "\n# Error message:", conditionMessage(e), "\n",
          file = "R/canada/ces_65/auto_cleaning.R",
          append = TRUE)
      cat("ERROR: Invalid R code for variable:", raw_variable, "\n")
    })
    
    # Add a small delay to avoid API rate limits
    Sys.sleep(1)
    
  }, error = function(e) {
    # Main error handling for the entire process
    cat(sprintf("\n# ERROR processing variable %s: %s\n", 
                codebook$variable_name[i], 
                conditionMessage(e)),
        file = "R/canada/ces_65/auto_cleaning.R",
        append = TRUE)
    cat("ERROR in main process for variable:", codebook$variable_name[i], "\n")
  })
}

# Add final code to save the cleaned dataset
cat("\n# ============================================
# Save the cleaned dataset
# ============================================
saveRDS(df_clean, '_SharedFolder_global_es/data/canada/clean/data_ces_1965_clean.rds')

# End of cleaning script", 
    file = "R/canada/ces_65/auto_cleaning.R",
    append = TRUE)

cat("\nCleaning script generation complete! Check 'cleaning.R' for the results.\n")
